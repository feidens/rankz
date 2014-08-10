// function loadUser(user) {
//     var userAlreadyExists = typeof Meteor.users.findOne({ username : user.username }) === 'object';
//
//     if (!userAlreadyExists) {
//         Accounts.createUser(user);
//     }
// }
//
// Meteor.startup(function () {
//     var users = YAML.eval(Assets.getText('users.yml'));
//
//     for (key in users) if (users.hasOwnProperty(key)) {
//         loadUser(users[key]);
//     }
// });


// snake
// 93	184	44	16	52	106	 0 	91	102	102	83	53	43	46	52	63	31
