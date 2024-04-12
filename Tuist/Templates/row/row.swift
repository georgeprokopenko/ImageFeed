import ProjectDescription

private let nameAttribute: Template.Attribute = .required("name")
private let sceneAttribute: Template.Attribute = .required("scene")

private let template = Template(
    description: "Create row",
    attributes: [
        nameAttribute,
        sceneAttribute
    ],
    items: [
        .file(
            path: "Scenes/\(sceneAttribute)Scene/Rows/\(nameAttribute)/\(nameAttribute)Cell.swift",
            templatePath: "ui/Cell.stencil"
        ),
        .file(
            path: "Scenes/\(sceneAttribute)Scene/Rows/\(nameAttribute)/\(nameAttribute)CellViewModel.swift",
            templatePath: "core/ViewModel.stencil"
        )
    ]
)
