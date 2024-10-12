import QtQuick

Item {
    id: root

    property real value: 0.9
    property int imageWidth: root.width
    property int imageHeight: root.height

    property var states: ["pause", "walk", "run", "bike", "car", "rocket"]
    property string state: root.states[Math.round(root.value * (root.states.length - 1))]

    Image {
        width: root.imageWidth
        height: root.imageHeight

        sourceSize.width: root.imageWidth
        sourceSize.height: root.imageHeight
        source: "qrc:/images/" + root.state + ".svg"
    }
}
