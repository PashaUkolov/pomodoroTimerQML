import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Shapes

Window {
    width: 400
    height: 600
    visible: true
    title: qsTr("Pomodoro timer")
    color: "#fff04042"

    property int currentRotation: 0
    property int currentTimeMinutes: 0
    property int currentTimeSeconds: 0


    function deg2rad(degrees) {
        return degrees * (Math.PI / 180);
    }

    function deg2minutes(degrees) {
        return degrees * 60 / 360;
    }

    function minutes2deg(minutes) {
        return minutes * 360 / 60
    }

    function seconds2deg(seconds) {
        return seconds * 360 / 3600
    }

    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            console.log(currentTimeSeconds)
            currentTimeSeconds -= 1
            if(currentTimeSeconds % 60 == 0) {
                currentTimeMinutes -= 1
            }

            shapeDial.clockRotation = seconds2deg(currentTimeSeconds)
            if(currentTimeSeconds <= 0) {
                currentTimeSeconds = 0
                timer.running = false
            }
        }
    }

    // SoundEffect {
    //      id: playSound
    //      source: "soundeffect.wav"
    // }

    ColumnLayout {
        anchors.fill: parent
        TabBar {
            //Material.accent: Material.Red
            background: Rectangle {
                color: "#fff04042"
            }

            id: bar

            //width: parent.width
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            CTabButton {
                text: qsTr("Pomodoro")
            }
            CTabButton {
                text: qsTr("Short Break")
            }
            CTabButton {
                text: qsTr("Long Break")
            }
        }

        Item {
            id: timeDial
            x: 0; y: 0
            width: 200; height: 200

            Layout.alignment: Qt.AlignCenter

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent
                onPressed:(mouse) => {
                    shapeDial.clickPos = mouse.y
                    currentRotation = shapeDial.clockRotation;
                }
                onPositionChanged:(mouse) => {
                    var offset = shapeDial.clickPos - mouse.y
                    shapeDial.clockRotation = currentRotation + offset
                    if(shapeDial.clockRotation < 0) {
                        shapeDial.clockRotation = 0
                    }

                    if(shapeDial.clockRotation > 360) {
                      shapeDial.clockRotation = 360
                    }
                    currentTimeMinutes = deg2minutes(shapeDial.clockRotation)
                    currentTimeSeconds = currentTimeMinutes*60
                }
            }

            Shape {
                id: shapeDial

                anchors.fill: parent
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                property var center : verticalCenter

                property int clickPos : 0;
                property int clockRotation : 0;
                property int pathWidth : 10

                //dial bg path
                ShapePath {
                    strokeWidth: shapeDial.pathWidth
                    strokeColor: "#ffffffff"
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap
                    PathAngleArc {
                        centerX: shapeDial.width / 2
                        centerY: shapeDial.height / 2
                        radiusX: 100
                        radiusY: 100
                        startAngle: 0
                        sweepAngle: 360
                    }
                }

                //dial path
                ShapePath {
                    strokeWidth: shapeDial.pathWidth
                    strokeColor: "#b72424"
                    fillColor: "transparent"
                    capStyle: ShapePath.RoundCap
                    PathAngleArc {
                        centerX: shapeDial.width / 2
                        centerY: shapeDial.height / 2
                        radiusX: 100
                        radiusY: 100
                        startAngle: -90
                        sweepAngle: shapeDial.clockRotation
                    }
                }

                // dial tip
                Rectangle {
                    width: 20; height: 20
                    radius: 30
                    x: {
                        Math.cos(deg2rad(shapeDial.clockRotation - 90)) * 100 + parent.width / 2 - width/2
                    }
                    y: {
                        Math.sin(deg2rad(shapeDial.clockRotation - 90)) * 100 + parent.height / 2 - width /2
                    }
                }

            }

            ColumnLayout {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    Layout.alignment: Qt.AlignCenter
                    text: currentTimeMinutes
                    color: "white"
                    font.pointSize: 24
                }
                Text {
                    Layout.alignment: Qt.AlignCenter
                    text: "minutes"
                    color: "white"
                    font.pointSize: 18
                }
            }
        }

        Rectangle {
            width: 200
            height: 60
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            radius: 10
            color: "#fff0f0f0"
            Button {
                property bool isPressed: false
                id: startButton

                x: 0; y: -8
                flat: true
                down: false
                highlighted: false

                contentItem: Text {
                    text: startButton.isPressed ? "Stop" : "Start"
                    font.pointSize: 18
                    opacity: enabled ? 1.0 : 0.3
                    color: "#fff04042"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                onClicked: {
                    isPressed = !isPressed
                    if(isPressed) {
                        startButton.y = -4
                        timer.start()
                    } else {
                        startButton.y = -8
                        timer.stop()
                    }
                }

                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 60
                    radius: 10
                }
            }
        }
    }
}
