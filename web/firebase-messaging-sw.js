importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js');

const firebaseConfig = {
  apiKey: "AIzaSyBcRqArOcVOV1yGzhFyB40JHkd62o9TisU",
  authDomain: "axlerate-customer-portal.firebaseapp.com",
  projectId: "axlerate-customer-portal",
  storageBucket: "axlerate-customer-portal.appspot.com",
  messagingSenderId: "960448262830",
  appId: "1:960448262830:web:3ed95b8161df59afc5f33f",
  measurementId: "G-DX2QLY0GEB"
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// messaging.onBackgroundMessage(function (payload) {
//   console.log("Received background message ", payload);
// ​
//   const notificationTitle = payload.notification.title;
//   const notificationOptions = {
//     body: payload.notification.body,
//     Image: payload.notification.Image,
//   };
// ​
//   self.registration.showNotification(notificationTitle, notificationOptions);
// });

messaging.setBackgroundMessageHandler(function (payload) {
  const promiseChain = clients
    .matchAll({
      type: "window",
      includeUncontrolled: true
    })
    .then(windowClients => {
      for (let i = 0; i < windowClients.length; i++) {
        const windowClient = windowClients[i];
        windowClient.postMessage(payload);
      }
    })
    .then(() => {
      const title = payload.notification.title;
      const options = {
        body: payload.notification.score
      };
      return registration.showNotification(title, options);
    });
  return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
  console.log('notification received: ', event)
});