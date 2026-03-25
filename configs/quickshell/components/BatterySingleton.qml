pragma singleton
import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    property List<UPowerDevice> devices
}
