pragma Singleton
import Quickshell
import QtQuick

Singleton {
    property color base: "#232136"
    property color surface: "#2a273f"
    property color overlay: "#393552"
    property color muted: "#6e6a86"
    property color subtle: "#908caa"
    property color text: "#e0def4"
    property color love: "#eb6f92"
    property color gold: "#f6c177"
    property color rose: "#ea9a97"
    property color pine: "#3e8fb0"
    property color foam: "#9ccfd8"
    property color iris: "#c4a7e7"
    property color highlightLow: "#2a283e"
    property color highlightMed: "#44415a"
    property color highlightHigh: "#56526e"

    property string scriptsDir: Qt.resolvedUrl("scripts/").toString().slice(7)

    property string iosevkaFont: "Iosevka Nerd Font"
}
