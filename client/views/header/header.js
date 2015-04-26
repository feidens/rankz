Template['header'].helpers({
  activeRouteClass: function(/*route names */) {
      var args = Array.prototype.slice.call(arguments, 0);

      args.pop();

      var active = _.any(args, function(name) {
        return Router.current() && Router.current().route.name === name;
      });

      return active && 'active';
    },
  username: function() {
    console.log(Meteor.user());
    if(Meteor.user()) {
      return Meteor.user().username;
    }

  }
});

Template['header'].events({
    // 'click .dropdown.item' : function () {
    //     // As long as the new Meteor UI isn't out the whole template will re-render
    //
    //     // $('.demo.sidebar').sidebar('toggle');
    //     $('.header-wrapper').toggleClass('active');
    //     $('.angle.icon').toggleClass('down').toggleClass('up');
    // }
});
Template['header'].rendered = function () {

};
