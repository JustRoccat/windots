
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root

    anchors {
        left: true
        right: true
        bottom: true
    }

    implicitHeight: 30
    color: "transparent"
    exclusionMode: ExclusionMode.Auto

    Rectangle {
        anchors.fill: parent
        color: "#c0c0c0"


        Rectangle {
            anchors { top: parent.top; left: parent.left; right: parent.right }
            height: 1
            color: "#ffffff"
        }

        RowLayout {
            anchors {
                fill: parent
                leftMargin: 2
                rightMargin: 2
                topMargin: 2
                bottomMargin: 2
            }
            spacing: 2


            StartButton { Layout.fillHeight: true }

            Separator95 {}


            Repeater {
                model: Hyprland.workspaces

                WorkspaceButton {
                    required property var modelData
                    workspace: modelData
                    Layout.fillHeight: true
                }
            }

            Separator95 {}


            Repeater {
                model: ToplevelManager.toplevels

                TaskButton {
                    required property var modelData
                    toplevel: modelData
                    Layout.preferredWidth: 150
                    Layout.fillHeight: true
                }
            }

            Item { Layout.fillWidth: true }

            Separator95 {}


            SysTray { Layout.fillHeight: true }
        }
    }
}
