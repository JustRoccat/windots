
import QtQuick
import QtQuick.Layouts

Item {
    implicitWidth:  6
    Layout.fillHeight: true


    Rectangle {
        x:      2
        y:      2
        width:  1
        height: parent.height - 4
        color:  "#808080"
    }

    Rectangle {
        x:      3
        y:      2
        width:  1
        height: parent.height - 4
        color:  "#ffffff"
    }
}
