import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray

Item {
    id: root
    implicitHeight: bar.implicitHeight
    implicitWidth: childrenRect.width

    RowLayout {
        spacing: 0
        VolumeWidget {}
        Repeater {
            model: SystemTray.items

            delegate: TrayItem {
                item: modelData
            }
        }
    }
}
