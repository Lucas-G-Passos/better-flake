//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire

import "./components"

ShellRoot {
    id: shell

    property string scriptsDir: Qt.resolvedUrl("components/scripts/").toString().slice(7)

    property string iosevkaFont: "Iosevka"

    PwObjectTracker {
        objects: Pipewire.nodes.values
    }

    Bar {}
    VolumeOsd {}

    Process {
        id: buildCache
        command: ["bash", Qt.resolvedUrl("buildDesktopCache.sh").toString().slice(7)]
        running: true
    }
}
