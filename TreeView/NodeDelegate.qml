import QtQuick 2.0

import "TreeUtils.js" as Utils

Rectangle {
    id: nodeContainer
    width: 350
    height: nodeLabel.height + nodeChildrenView.height

    color: "transparent"

    property string textLabel
    property var folderChildren
    property bool isExpanded: false
    property int childrenHeight

    onChildrenHeightChanged: {
        console.log("Children height changed: " + childrenHeight)
        console.log("Object: " + nodeContainer)
    }

    Image {
        width: 40
        height: 35
        source: "qrc:/folder.svg"
    }

    Text {
        id: nodeLabel
        x: 45
        width: parent.width
        height: 35
        text: textLabel
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea {
        width: parent.width
        height: 35
        onClicked: {
            console.log("Expanding node to " + childrenHeight)
            console.log("Clicked object: " + nodeContainer)
            isExpanded = !isExpanded
        }
    }

    Rectangle {
        height: 1
        width: parent.width
        y: 34
        color: "black"
    }

    ListView {
        id: nodeChildrenView
        visible: isExpanded
        x: 30
        y: nodeLabel.height
        height: isExpanded ? childrenHeight : 0
        model: folderChildren
        delegate:
            Component {
                Loader {
                    width: 350 //parent.width
                    //height: 35
                    source: hasChildren ? "NodeDelegate.qml" : "LeafDelegate.qml"
                    onLoaded: {
                        item.textLabel = label
                        if (hasChildren)
                        {
                            item.folderChildren = childrenModel
                            item.childrenHeight = (childrenModel.rowCount() * 35)
                        }
                        else
                        {
                            item.lCapital = capital
                            item.lCurrency = currency
                        }
                    }
                }
        }
    }
}
