Template.home.helpers
  feature: ->
    [
      {
        text: "Elo system ranking"
        icon: "tasks"
        path: "http://en.wikipedia.org/wiki/Elo_rating_system"
      }
      {
        text: "Create a group, invite your friends..."
        icon: "plus"
        path: "#console-tool"
      }
      {
        text: "Compete with your friends in group rankings"
        icon: "users"
        path: "#console-tool"
      }
      {
        text: "Create an account and jump in"
        icon: "user"
        color: "hover-orange"
        path: "#html5"
      }
    ]

  package: ->
    [
      {
        name: "Elo system: Start value 1000"
        path: "http://en.wikipedia.org/wiki/Elo_rating_system"
      }
      {
        name: "Play a competitive game elsewhere and create a ranking on rankz"
        path: "http://en.wikipedia.org/wiki/Elo_rating_system"
      }
      {
        name: "More to come in the future"
        path: "https://github.com/feidens/rankz"
      }
      {
        name: "Improvement or questions? Than go to github!"
        path: "https://github.com/feidens/rankz"
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
