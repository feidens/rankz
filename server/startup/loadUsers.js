function loadUser(user) {
    var userAlreadyExists = typeof Meteor.users.findOne({ username : user.username }) === 'object';

    if (!userAlreadyExists) {
        Accounts.createUser(user);
    }
}

Meteor.startup(function () {
    //var users = YAML.eval(Assets.getText('users.yml'));
    users = []
    user = {}
    user.username = 'feidens'
    user.password = 'Source000'
    users[0] = user
    user = {}
    user.username = 'snake'
    user.password = 'Source000'
    users[1] = user
    user = {}
    user.username = 'blub'
    user.password = 'Source000'
    users[2] = user

    for (key in users){
        loadUser(users[key]);
    };
});


// snake
// 93	184	44	16	52	106	 0 	91	102	102	83	53	43	46	52	63	31
