import UIKit

private class Handler {

    let controlEvents: UIControl.Event
    let block: (ActionButton) -> Void

    init(controlEvents: UIControl.Event, block: @escaping (ActionButton) -> Void) {
        self.controlEvents = controlEvents
        self.block = block
    }

    @objc func eventAction(_ sender: ActionButton) {
        block(sender)
    }
}

class ActionButton: InteractiveButton {

    struct Highlight {
        var defaultColor: UIColor = .clear
        var highlightColor: UIColor
        var animated: Bool = true

        init(defaultColor: UIColor = .clear, highlightColor: UIColor, animated: Bool = true) {
            self.defaultColor = defaultColor
            self.highlightColor = highlightColor
            self.animated = animated
        }
    }

    private var handlers = [Handler]()

    var highlightDidChange: ((ActionButton) -> Void)?

    var customHighlight: Highlight? {
        didSet {
            updateCustomHighlight()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initialize()
    }

    func initialize() {
        titleLabel?.lineBreakMode = .byClipping
    }

    func removeAllActions(for controlEvents: UIControl.Event = .touchUpInside) {
        let toRemove = handlers.filter { $0.controlEvents == controlEvents }
        toRemove.forEach {
            removeTarget($0, action: #selector(Handler.eventAction), for: $0.controlEvents)
        }

        handlers = handlers.filter { $0.controlEvents != controlEvents }
    }

    func addAction(for controlEvents: UIControl.Event = .touchUpInside, action: @escaping (ActionButton) -> Void) {
        let handler = Handler(controlEvents: controlEvents, block: action)
        addTarget(handler, action: #selector(Handler.eventAction), for: controlEvents)

        handlers.append(handler)
    }

    override var isHighlighted: Bool {
        didSet {
            highlightDidChange?(self)
            updateCustomHighlight()
        }
    }

    private func updateCustomHighlight() {
        guard let customHighlight = customHighlight else {
            return
        }

        let setColor = { self.backgroundColor = self.isHighlighted ? customHighlight.highlightColor : customHighlight.defaultColor }

        if customHighlight.animated {
            UIView.animate(withDuration: 0.2) {
                setColor()
            }
        } else {
            setColor()
        }
    }

    // MARK: - Public accessor

    func withAction(_ action: @escaping (ActionButton) -> Void) -> Self {
        addAction { _ in
            action(self)
        }

        return self
    }
}
