import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import "./"

Scope {
    id: root

    property bool shouldShow: false

    property string icon: "low"
    function mapVolume(raw) {
        return Math.round(raw * 100);
    }

    function getIcon(volume) {
        var v = mapVolume(volume);
        if (v === 0)
            return "muted";
        else if (v <= 33)
            return "low";
        else if (v <= 66)
            return "medium";
        else
            return "high";
    }

    Connections {
        target: Pipewire.defaultAudioSink.audio

        function onVolumeChanged() {
            root.icon = root.getIcon(Pipewire.defaultAudioSink.audio.volume);
            root.shouldShow = true;
            hideTimer.restart();
        }
    }

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShow = false
    }

    LazyLoader {
        active: root.shouldShow

        PanelWindow {
            anchors.bottom: true
            exclusiveZone: 0
            margins.bottom: screen.height / 5

            implicitWidth: 400
            implicitHeight: 40

            color: 'transparent'

            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: "red"

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 15

                    IconImage {
                        source: `image://icon/audio-volume-${root.icon}`
                        implicitSize: 30
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 10
                        radius: 20
                        color: "blue"

                        Rectangle {
                            id: indicator
                            color: "purple"
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            height: parent.height

                            implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                            radius: parent.radius

                            Behavior on implicitWidth {
                                NumberAnimation {
                                    duration: 75
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
