import QtQuick
import QtQuick.Controls

Window {
    id: window

    width: 1260
    height: 400
    visible: true
    title: qsTr("Typo")

    function generate_text(symbols, length) {
        var result = ''
        for(let i = 0; i < length; ++i) {
            result += symbols[Math.floor(Math.random() * symbols.length)]
        }
        return result
    }

    Component.onCompleted: {
        // scene.load(generate_text(['а', 'о', ' '], 30))
    }

    StatView {

    }

    // GameScene {
    //     id: scene
    //     anchors.centerIn: parent
    //     width: window.width * 0.9
    //     height: window.height * 0.25

    //     onFinished: (elapsedTime, mistakes, size) => {
    //         console.log(elapsedTime, mistakes, size)
    //         scene.load(generate_text(['а', 'о', ' '], 30))
    //     }
    // }
}
