//@ pragma UseQApplication
import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Pipewire

import "./components"

ShellRoot {
    id: shell

    property string scriptsDir: Qt.resolvedUrl("components/scripts/").toString().slice(7)

    PwObjectTracker {
        objects: Pipewire.nodes.values
    }

    Bar {}
    VolumeOsd {}

    Process {
        id: buildCache
        command: ["bash", shell.scriptsDir+("buildDesktopCache.sh")]
        running: true
    }
}
