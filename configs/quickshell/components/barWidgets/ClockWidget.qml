import QtQuick
import "./../"

Item {
    id: root
    implicitHeight: bar.implicitHeight
    implicitWidth: childrenRect.width

    property string time: formatTime(TimeSingleton.time)

    function formatTime(raw) {
        const parts = raw.trim().split(" ");
        return parts[4];
    }

    Rectangle {
        implicitWidth: childrenRect.width+5
        implicitHeight: bar.implicitHeight
        color: 'blue'
        Text {
            anchors.centerIn: parent
            text: root.time
            font.family: ThemeSingleton.font
            color: ThemeSingleton.text
        }
    }
}
