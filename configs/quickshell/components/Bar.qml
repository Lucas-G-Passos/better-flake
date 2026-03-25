import Quickshell
import QtQuick
import QtQuick.Layouts
import "./barWidgets"

PanelWindow {
    id: bar

    implicitHeight: 25

    anchors {
        left: true
        top: true
        right: true
    }
    color: "red"

    Item {
        anchors.fill: parent

        WorkspacesWidget {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }

        ClockWidget {
            anchors.centerIn: parent
        }

        SystemTray {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
