import QtQuick

Item {
    id: root
    property alias text: key.text

    function shake() {
        shakeAnimator.start()
    }

    function hideAndDestroy() {
        hideAnimator.start()
    }

    Rectangle {
        radius: 8
        anchors.fill: parent
        border.color: "darksalmon"
        border.width: 2
        color: "bisque"

        Text {
            id: key

            anchors.centerIn: parent
            font.bold: false
            font.pixelSize: 32

            color: "saddlebrown"
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
