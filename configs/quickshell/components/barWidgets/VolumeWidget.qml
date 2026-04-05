import QtQuick
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick.Layouts

import "./../"

Item {
    id: root
    implicitHeight: bar.implicitHeight
    implicitWidth: 25

    property PwNode preferred: Pipewire.defaultAudioSink

    property real preferredVolume: mapVolume(preferred.audio.volume)

    property string icon: getIcon(preferredVolume)

    function mapVolume(raw) {
        var mapped = Math.round(raw * 100);
        return mapped;
    }

    function getIcon(volume) {
        var v = volume;
        if (v === 0)
            return "muted";
        else if (v <= 33)
            return "low";
        else if (v <= 66)
            return "medium";
        else
            return "high";
    }

    Rectangle {
        anchors.fill: parent
        color: "blue"

        IconImage {
            anchors.centerIn: parent
            implicitHeight: root.implicitHeight - 4
            implicitWidth: root.implicitWidth - 4

            source: `image://icon/audio-volume-${root.icon}`
        }
    }

    MouseArea{}
}
