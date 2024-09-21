import QtQuick
import QtQuick.Controls

Window {
    id: window

    width: 800
    height: 400
    visible: true
    title: qsTr("Typo")

    Component.onCompleted: {
        window.makeTask(window.task)
    }

    Component {
        id: keyViewComponent
        KeyView {
            width: 40
            height: 40
        }
    }

    property string task: "ааа аа а о оо ооо"
    property var keyViews: []

    function makeTask(task) {
        task.split("").forEach((item, index) => {
            let keyView = keyViewComponent.createObject(scene, {x: index * (40 + 2), y: 0, text: item})
            window.keyViews.push(keyView)
        })
    }

    Item {
        id: scene
        anchors.fill: parent
        focus: true

        Keys.onPressed: (event)=> {
            if (keyViews.length != 0) {
                var keyView = keyViews[0]
                if (keyView.text === event.text) {
                    keyView = keyViews.shift()
                    keyView.hideAndDestroy()
                } else {
                    keyView.shake()
                }
            }
        }

        Keys.onReleased: (event)=> {
        }
    }
}
