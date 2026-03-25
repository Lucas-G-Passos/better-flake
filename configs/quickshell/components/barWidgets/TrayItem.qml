import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Item {
    id: root
    implicitHeight: bar.height
    implicitWidth: 25

    required property SystemTrayItem modelData
    property var item: modelData

    Rectangle {
        color: "blue"
        anchors.fill: parent

        IconImage {
            anchors.centerIn: parent
            implicitWidth: parent.width - 4
            implicitHeight: parent.height - 4
            source: root.item.icon
        }

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: event => {
                if (event.button === Qt.RightButton) {
                    if (root.item.hasMenu)
                        menuAnchor.open();
                } else {
                    if (!root.item.onlyMenu)
                        root.item.activate();
                    else if (root.item.hasMenu)
                        menuAnchor.open();
                }
            }
        }

        QsMenuAnchor {
            id: menuAnchor
            anchor.window: root.QsWindow.window
            menu: root.item.menu

            anchor.rect: root.QsWindow.window.contentItem.mapFromItem(root, 0, 0, root.width, root.height)
            anchor.edges: Edges.Bottom
        }
    }
}
