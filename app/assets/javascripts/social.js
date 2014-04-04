hello.init({ 
    facebook: 327986827326660,
}, {
    scope: 'email, user_friends'
});

hello.on('auth.login', function(auth) {
    // call user information, for the given network
    hello( auth.network ).api( '/me' ).success(function(r) {
       $url = "http://graph.facebook.com/" + r.username + '/picture'
       $("#organiser_name").val(r.name);
       $("#organiser_email").val(r.email);
       // Set the profile picture of the user that just logged in
       var $icon = $("#organiser_name_container span");
       $icon.removeClass("glyphicon-user").addClass("glyphicon-" + $icon);
    });

    /* TODO: We should not be using the guest_list text area directly.
     *  Instead, we want to put them all into a list where the user can select
     *  some of them. Could use checkboxes next to each 'friend' and will need
     *  JS to restrict the user from adding to many people to the guest list.
     *  Should mark which social network they are on as well.
     */
    var $guests_field = $("#guest_list");

    $guests_list = $guests_field.after('<table id="friend_list"></table>');

    hello( auth.network ).api( '/me/friends' ).success(function(friends) {
        $.each(friends, function(friend) {
            // See https://developers.facebook.com/docs/graph-api/reference/user/ for attributes
            $guests_list.html($guests_list.html + '<tr><td>' + friend.name + "</td></tr>\n");
        });
    });
});
