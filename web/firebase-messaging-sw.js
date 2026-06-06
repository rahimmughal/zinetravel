importScripts('https://www.gstatic.com/firebasejs/9.6.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.6.1/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyDekCofR1DY86ntvclJ28rq9xkAsIXE_Vc",
  authDomain: "zinetravel-753be.firebaseapp.com",
  projectId: "zinetravel-753be",
  storageBucket: "zinetravel-753be.firebasestorage.app",
  messagingSenderId: "174014631748",
  appId: "1:174014631748:web:c933e28e5fd1065bb3d111",
  measurementId: "G-JTR5N9N2QD"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  const notificationTitle = payload.notification.title || 'Zine Travel';
  const notificationOptions = {
    body: payload.notification.body || '',
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-maskable-192.png'
  };
  return self.registration.showNotification(notificationTitle, notificationOptions);
});

self.addEventListener('notificationclick', function(event) {
  event.notification.close();
  event.waitUntil(
    clients.openWindow('/')
  );
});
