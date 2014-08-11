Template.home.helpers
  feature: ->
    [
      {
        text: "Elo point system ranking"
        icon: "tasks"
        path: "#packages"
      }
      {
        text: "Compete in several Groups"
        icon: "users"
        path: "#console-tool"
      }
      {
        text: "Creat an account and jump in"
        icon: "user"
        color: "hover-orange"
        path: "#html5"
      }
    ]

  package: ->
    [
      {
        name: "Start value 1000"
        path: "https://github.com/EventedMind/iron-router"
      }
      {
        name: "k1 = 25"
        path: "https://github.com/aldeed/meteor-collection2"
      }
      {
        name: "k2 = 800"
        path: "http://semantic-ui.com/"
      }
      {
        name: "We play darts"
        path: "http://lesscss.org/"
      }
    ]

  


Template.home.events {}


# // Template.home.rendered = function () {
# //     // @see: http://stackoverflow.com/questions/5284814/jquery-scroll-to-div
# //     $('a[href*=#]:not([href=#])').click(function () {
# //         if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
# //             var target = $(this.hash);
# //             target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
# //             if (target.length) {
# //                 $('html, body').animate({
# //                     scrollTop: target.offset().top
# //                 }, 1000);
# //                 return false;
# //             }
# //         }
# //
# //         return true;
# //     });
# // };
