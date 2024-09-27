import QtQuick

Item {
    id: root
    property alias text: key.text
    property bool isActive: false

    function shake() {
        shakeAnimator.start()
    }

    function hideAndDestroy() {
        hideAnimator.start()
    }

    Rectangle {
        radius: 8
        anchors.fill: parent
        border.color: root.isActive ? "darkorange": "darksalmon"
        border.width: 2
        color: root.isActive ? "moccasin" : "bisque"

        Text {
            id: key

            anchors.centerIn: parent
            font.bold: false
            font.pixelSize: 32

            color: root.isActive ? "chocolate": "saddlebrown"
        }
    }

    ParallelAnimation {
        id: hideAnimator

        OpacityAnimator {
            target: root
            from: 1
            to: 0
            duration: 200
        }
        ScaleAnimator {
            target: root
            from: 1.0
            to: 0
            duration: 200
            easing.type: Easing.InBack
        }
        onStopped: {
            root.destroy()
        }
    }

    SequentialAnimation {
        id: shakeAnimator

        RotationAnimator {
            target: root
            from: 0
            to: 20
            duration: 100
            easing.type: Easing.OutInBounce
        }
        RotationAnimator {
            target: root
            from: 20
            to: -20
            duration: 100
            easing.type: Easing.OutInBounce
        }
        RotationAnimator {
            target: root
            from: -20
            to: 0
            duration: 100
            easing.type: Easing.OutInBounce
        }
    }
}
