import consumer from "./consumer"

consumer.subscriptions.create("MessagesChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    const messagesContainer = document.getElementById('messages');
    messagesContainer.innerHTML += data.message;
  }
});

document.addEventListener('turbolinks:load', () => {
  const form = document.getElementById('new_message');
  if (form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      const input = document.getElementById('message_content');
      
      fetch('/messages', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
          message: { content: input.value }
        })
      });

      input.value = '';
    });
  }
});