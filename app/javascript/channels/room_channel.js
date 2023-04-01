import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("we're connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("we're disconnected")
  },

  received(message) {
    // Called when there's incoming data on the websocket for this channel
    const msgEl = document.getElementById('msg')

    const msgTemplate = document.getElementById("msg-template")
    const newMsgItem = msgTemplate.content.cloneNode(true)
    // const msgItem = msgTemplate.content.querySelector(".msg-container")
    // const newMsgItem = document.importNode(msgItem, true)

    newMsgItem.querySelector(".msg-user-link").href = "users/" + message.content.user.id
    newMsgItem.querySelector(".msg-sender").textContent = message.content.user.username
    newMsgItem.querySelector(".msg-time").textContent = "sent " + message.content.creation_time + " ago"
    newMsgItem.querySelector(".msg-text").textContent = message.content.data

    msgEl.prepend(newMsgItem)

    document.querySelector(".message-form__input").value = ""

    console.log(message.content.data, message.content.user)
  }
});
