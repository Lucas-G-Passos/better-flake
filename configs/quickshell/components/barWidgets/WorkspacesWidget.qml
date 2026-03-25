import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "./"

Item {
    id: workspacesWidget
    height: bar.implicitHeight
    implicitWidth: childrenRect.width

    property var workspaces: Hyprland.workspaces

    RowLayout {
        spacing: 0

        Repeater {
            model: workspacesWidget.workspaces

            delegate: Loader {
                active: modelData.id !== -99
                sourceComponent: WorkspaceItem {
                    workspace: modelData
                }
            }
        }
    }
}
