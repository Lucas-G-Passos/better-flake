import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Widgets
import Quickshell.Io
import "./../"

Item {
    id: workspaceItem
    property HyprlandWorkspace workspace
    implicitHeight: bar.implicitHeight
    implicitWidth: childrenRect.width
    property var topLevelCount: workspace.toplevels.values.length

    property var groupedToplevels: {
        var _ = topLevelCount;
        var values = workspace.toplevels.values;
        var groups = {};
        var order = [];
        for (var i = 0; i < values.length; i++) {
            var tl = values[i];
            var isActive = tl.activated;
            var aid = (tl.wayland ? tl.wayland.appId : "") || "";
            if (!groups[aid]) {
                groups[aid] = {
                    appId: aid,
                    count: 0,
                    activeTitle: "",
                    active: false
                };
                order.push(aid);
            }
            groups[aid].count++;
            if (isActive) {
                groups[aid].active = true;
            }
        }
        return order.map(function (aid) {
            return groups[aid];
        });
    }

    Rectangle {
        id: rectangle
        implicitHeight: parent.height
        implicitWidth: mainRow.implicitWidth + 12
        color: "blue"

        RowLayout {
            id: mainRow
            anchors.centerIn: parent
            spacing: 0

            Repeater {
                model: workspaceItem.groupedToplevels
                delegate: Item {
                    id: topLevelDelegate
                    Layout.rightMargin: index < workspaceItem.groupedToplevels.length - 1 ? 6 : 0

                    property string appId: modelData.appId
                    property string title: modelData.activeTitle
                    property bool active: modelData.active
                    property int count: modelData.count
                    property string appname
                    property string icon: ""

                    implicitWidth: row.implicitWidth
                    height: rectangle.implicitHeight

                    RowLayout {
                        id: row
                        spacing: 0
                        anchors.centerIn: parent

                        Item {
                            width: 20
                            height: 20

                            IconImage {
                                anchors.fill: parent
                                source: topLevelDelegate.icon ? `image://icon/${topLevelDelegate.icon}` : ""
                                opacity: topLevelDelegate.icon ? 1 : 0
                                Behavior on opacity {
                                    NumberAnimation {
                                        duration: 100
                                        easing.type: Easing.OutCubic
                                    }
                                }
                            }

                            Rectangle {
                                visible: topLevelDelegate.count > 1
                                width: 14
                                height: 14
                                radius: 7
                                color: ThemeSingleton.iris
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom

                                Text {
                                    anchors.centerIn: parent
                                    text: topLevelDelegate.count
                                    color: ThemeSingleton.base
                                    font.family: ThemeSingleton.font
                                    font.pixelSize: 8
                                    font.weight: 600
                                }
                            }
                        }

                        Text {
                            Layout.maximumWidth: topLevelDelegate.active ? implicitWidth : 0
                            Layout.leftMargin: topLevelDelegate.active ? 8 : 0
                            Layout.rightMargin: topLevelDelegate.active ? 8 : 0
                            text: topLevelDelegate.active ? topLevelDelegate.appname.slice(0, 50) : ""
                            color: ThemeSingleton.text
                            font.family: ThemeSingleton.font
                            clip: true
                            opacity: topLevelDelegate.active ? 1 : 0

                            Behavior on Layout.maximumWidth {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.InOutCubic
                                }
                            }
                            Behavior on Layout.leftMargin {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.InOutCubic
                                }
                            }
                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 150
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }
                    }

                    Process {
                        id: resolver
                        running: false
                        command: ["bash", ThemeSingleton.scriptsDir + "/resolveDesktop.sh", topLevelDelegate.appId]
                        stdout: SplitParser {
                            onRead: function (line) {
                                if (line.startsWith("icon="))
                                    topLevelDelegate.icon = line.replace(/^icon=/, "");
                                else if (line.startsWith("appname="))
                                    topLevelDelegate.appname = line.replace(/^appname=/, "");
                            }
                        }
                    }

                    onAppIdChanged: {
                        if (appId !== "") {
                            resolver.command = ["bash", shell.scriptsDir + "/resolveDesktop.sh", appId];
                            resolver.running = true;
                        }
                    }
                }
            }

            Rectangle {
                width: 16
                height: 16
                radius: 10
                Layout.leftMargin: workspaceItem.workspace.active ? 0 : 8
                color: workspaceItem.workspace.active ? ThemeSingleton.iris : ThemeSingleton.muted

                Behavior on color {
                    ColorAnimation {
                        duration: 200
                    }
                }
                Behavior on Layout.leftMargin {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutCubic
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: rectangle
            onClicked: workspaceItem.workspace.activate()
        }
    }
}
