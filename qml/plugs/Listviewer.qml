import QtQuick 6.6
import QtQuick.Window 6.6
import QtQuick.Controls 6.6
import "qrc:/qml/plugs" 1.0
/*
Plugins {
    id:plugmodel
}
*/
Item{
    width:parent.width
    height:parent.height
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
                border {color: "#9EDDF2"; width: 2}
                Text {
                    anchors.centerIn: parent
                    text: "Plugins"
                    font.pixelSize: 32
                }
            }
        }
    }
}
