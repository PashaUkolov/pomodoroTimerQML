import QtQuick
import QtQuick.Controls

TabButton {
    id: control
    padding: 0

    contentItem: Text {
        text: control.text
        font: control.font

        color: "#fefefe"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 80
        implicitHeight: 40
        color: control.checked ? "#b72424" : "transparent"
        radius: 5
    }

    // Rectangle {
    //     width: parent.width
    //     height: 3
    //     anchors.bottom: parent.bottom
    //     visible: control.checked
    //     color: "beige"
    // }
}
