import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "components"

Item {
    id: root

    height: Screen.height
    width: Screen.width

    Image {
        id: background

        anchors.fill: parent
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectCrop

        source: config.Background

        asynchronous: false
        cache: true
        mipmap: true
        clip: true
    }

    Item {
        id: contentPanel

        anchors {
            fill: parent
            topMargin: config.Padding
            rightMargin: config.Padding
            bottomMargin:config.Padding
            leftMargin: config.Padding
        }

        DateTimePanel {
            id: dateTimePanel

            anchors {
                top: parent.top
                right: parent.right
            }
        }

        LoginPanel {
            id: loginPanel

            anchors.fill: parent
        }
    }
    SessionMemory {
        user: {
            if (loginPanel.user !== undefined) return loginPanel.user;
            if (loginPanel.selectedUser !== undefined) return loginPanel.selectedUser;
            if (typeof userModel !== "undefined" && userModel.lastUser) return userModel.lastUser;
            return "";
        }
        onMatched: {
            if (loginPanel.sessionIndex !== undefined) {
                loginPanel.sessionIndex = index;
            } else if (loginPanel.session !== undefined) {
                loginPanel.session = index;
            } else if (loginPanel.sessionSelect !== undefined) {
                loginPanel.sessionSelect.currentIndex = index;
            }
        }
    }
    
}
