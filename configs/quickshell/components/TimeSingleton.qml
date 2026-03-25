pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string time: ""

    Process {
        id: dateProc
        command: ["date"]
        running: true
        stdout: StdioCollector {
            id: collector
            onStreamFinished: {
                root.time = collector.text.trim();
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: if (!dateProc.running)
            dateProc.running = true
    }
}
