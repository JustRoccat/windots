
import QtQuick
import QtQuick.Layouts
import Quickshell.Wayland

Item {
    id: root


    required property var toplevel

    implicitWidth: 150
    implicitHeight: parent ? parent.height : 26


    property bool isActive: ToplevelManager.activeToplevel !== null &&
                             ToplevelManager.activeToplevel === root.toplevel
    property bool pressed:  false
    property bool sunken:   isActive || pressed

    Rectangle {
        anchors.fill: parent
        color: "#c0c0c0"
        clip: true


        Rectangle { x: 0;                y: 0;                width: parent.width;  height: 1;             color: sunken ? "#808080" : "#ffffff" }
        Rectangle { x: 0;                y: 0;                width: 1;             height: parent.height;  color: sunken ? "#808080" : "#ffffff" }
        Rectangle { x: 0;                y: parent.height - 1;width: parent.width;  height: 1;             color: sunken ? "#ffffff" : "#000000" }
        Rectangle { x: parent.width - 1; y: 0;                width: 1;             height: parent.height;  color: sunken ? "#ffffff" : "#000000" }

        Rectangle { x: 1;                y: 1;                width: parent.width - 2; height: 1;              color: sunken ? "#404040" : "#dfdfdf" }
        Rectangle { x: 1;                y: 1;                width: 1;                height: parent.height - 2; color: sunken ? "#404040" : "#dfdfdf" }
        Rectangle { x: 1;                y: parent.height - 2;width: parent.width - 2; height: 1;              color: sunken ? "#dfdfdf" : "#808080" }
        Rectangle { x: parent.width - 2; y: 1;                width: 1;                height: parent.height - 2; color: sunken ? "#dfdfdf" : "#808080" }


        Row {
            id: content
            x: 6 + (sunken ? 1 : 0)
            y: (parent.height - height) / 2 + (sunken ? 1 : 0)
            spacing: 4
            width: parent.width - 10


            Image {
                id: appIcon
                width: 16; height: 16
                sourceSize.width: 16
                sourceSize.height: 16
                anchors.verticalCenter: parent.verticalCenter
                source: root.toplevel.appId
                    ? ("image://icon/" + resolveIcon(root.toplevel.appId))
                    : ""
                smooth: false
                onStatusChanged: {
                    if (status === Image.Error)
                        source = "image://icon/application-x-executable"
                }
            }

            Text {
                width: content.width - appIcon.width - content.spacing
                anchors.verticalCenter: parent.verticalCenter

                text:  root.toplevel.title || root.toplevel.appId || "Okno"
                font.family:   "Tahoma, Arial, sans-serif"
                font.pixelSize: 11
                color: "#000000"
                elide: Text.ElideRight
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onPressed:  root.pressed = true
        onReleased: root.pressed = false
        onClicked: {
            root.toplevel.activate()
        }
    }

    function resolveIcon(appId) {
        const map = {
            "thunar":                  "Thunar",
            "org.xfce.thunar":         "Thunar",
            "nautilus":                "org.gnome.Nautilus",
            "pcmanfm":                 "pcmanfm",
            "vesktop":                 "discord",
            "vencorddesktop":          "discord",
            "discord":                 "discord",
            "kitty":                   "utilities-terminal",
            "alacritty":               "utilities-terminal",
            "foot":                    "utilities-terminal",
            "wezterm":                 "utilities-terminal",
            "org.wezfurlong.wezterm":  "utilities-terminal",
            "firefox":                 "firefox",
            "chromium":                "chromium-browser",
            "google-chrome":           "google-chrome",
        }
        return map[appId.toLowerCase()] ?? appId.toLowerCase()
    }
}
