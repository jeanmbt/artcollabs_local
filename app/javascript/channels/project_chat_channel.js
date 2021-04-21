import consumer from "./consumer";

const initProjectChatCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.projectchatId;

    consumer.subscriptions.create({ channel: "ProjectChatChannel", id: id }, {
      received(data) {
        console.log(data); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('afterbegin', data);
      },
    });
  }
}

export { initProjectChatCable };
