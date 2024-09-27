import QtQuick
import QtQuick.Controls

Window {
    id: window

    width: 1260
    height: 400
    visible: true
    title: qsTr("Typo")

    Component.onCompleted: {
        scene.load("ааа аа а о оо ооо о оо оо оо о")
    }

    GameScene {
        id: scene
        anchors.centerIn: parent
        width: window.width * 0.9
        height: window.height * 0.25

        onFinished: {
            scene.load("ааа аа а о оо ооо о оо оо оо о")
        }
    }
}
