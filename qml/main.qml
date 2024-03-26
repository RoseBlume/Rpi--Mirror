import QtWebEngine 6.4
import QtQuick 6.6
import QtQuick.Window 6.6
import QtQuick.Controls 6.6
//import MyQmlSingleton 1.0
//import io.qt.examples.backend 1.0
Window {
    id: window
    title: qsTr("Mirror")
    Button {
        id: bar1
        text:"Panels"
        onClicked: {
            boxes.visible = false
        }
    }

    Rectangle {
        id:boxes
        z: 1
        width: parent.width
        height:parent.height * 0.95
        y: parent.height * 0.05
        WebEngineView {
            id:tab1
            url: "qrc:/Plugins/Info/index.html"
            anchors.fill: parent
        }
    }
    ListModel {
            id: plugmodel
            ListElement { name: "Info" }
            ListElement { name: "Disney" }
            ListElement { name: "Netflix" }
            ListElement { name: "Youtube" }
        }
    Component {
        id: optDelegate
        Button {
            required property string name
            text: name
            height:64
            width:parent.width
            font.pixelSize: 24
            onClicked: {
                console.log(" /Plugins/" + name + "/index.html")
                tab1.url = ("qrc:/Plugins/" + name + "/index.html")
                boxes.visible = true
            }
        }
        }
    Rectangle {
        width: parent.width
        height: parent.height * 0.95
        y: parent.height * 0.05
        ListView {
            anchors.fill: parent
            clip: true
            model: plugmodel
            delegate: optDelegate
            header: bannercomponent
            footer: Rectangle {
                width: parent.width; height: 30;
                gradient: clubcolors
            }
            highlight: Rectangle {
                width: parent.width
                color: "lightgray"
            }
        }
        Component {     //instantiated when header is processed
            id: bannercomponent
            Rectangle {
                id: banner
                width: parent.width; height: 50
                gradient: clubcolors
                border {color: "#9EDDF2"; width: 2}
                Text {
                    anchors.centerIn: parent
                    text: "Plugins"
                    font.pixelSize: 32
                }
            }
        }
    }
    Component.onCompleted:{
        width = Screen.width
        height = Screen.height
    }
}
