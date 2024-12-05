console.log("Auto scroll script loaded");

document.addEventListener('turbo:load', () => {
  scrollToBottom();
});

document.addEventListener('turbo:frame-load', () => {
  scrollToBottom();
});

function scrollToBottom() {
  const messageBox = document.getElementById('messages');
  if (messageBox) {
    messageBox.scrollTop = messageBox.scrollHeight;
    console.log("Scrolled to bottom");
  }
}
