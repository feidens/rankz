this.isCordova = false;
this.pushNotification = null;

function onDeviceReady() {
  isCordova = true;

  cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
  cordova.plugins.Keyboard.disableScroll(false);


  StatusBar.overlaysWebView(false);
  StatusBar.styleDefault();
  StatusBar.backgroundColorByName("white");
  StatusBar.show();

  navigator.splashscreen.hide();

  pushNotification = window.plugins.pushNotification;

  pushNotification.setApplicationIconBadgeNumber(successCallback, errorCallback, 1);
}

document.addEventListener('deviceready', onDeviceReady, true);


function successCallback (result) {
    alert('result = ' + result);
}

function errorCallback (result) {
    alert('result = ' + result);
}
