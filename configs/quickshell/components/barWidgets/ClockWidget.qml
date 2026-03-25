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
        implicitWidth: 60
        implicitHeight: bar.implicitHeight
        color: 'blue'
        Text {
            anchors.centerIn: parent
            text: root.time
            font.family: ThemeSingleton.iosevkaFont
            color: ThemeSingleton.text
        }
    }
}
