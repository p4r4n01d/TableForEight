var votes_data = [{"id":1,"email":"ju1@jsthink.com","link1":null,"link2":null,"link3":null,"link4":null,"link5":null,"date1":null,"date2":null,"date3":null,"confirmed":null,"unique_id":"0747251897b155a8f0938e02781b2e1bb9332e37","event_id":1,"created_at":"2014-04-04T03:14:26.654Z","updated_at":"2014-04-04T03:14:26.654Z"},{"id":2,"email":"ju2@jsthink.com","link1":null,"link2":null,"link3":null,"link4":null,"link5":null,"date1":null,"date2":null,"date3":null,"confirmed":null,"unique_id":"5e8b991f26739cd18062938090e59ed71810d588","event_id":1,"created_at":"2014-04-04T03:14:26.917Z","updated_at":"2014-04-04T03:14:26.917Z"}];


function testValue(){
	alert('test');

	alert('null test: ' + votes_data[0].confirmed);
	alert(JSON.stringify(get_votes(votes_data)));
}

// Creates the votes result details for angular result.html view (Lists 5 Restaurants and 3 Dates)
var get_votes = function(votes_json){
	var _voting = { 
		restaurants:{},
		dates:{}
	};
	var votes = JSON.stringify(votes_json);
	for(i = 1; i < 6; i++)
	{
		if(i > 0 && i < 4) {
			for(a = -1; a < 3; a++) {
				if(a > 1) _voting.dates['date' + i + 'didnotvote'] = get_votes_count(votes, null, 'date' + i);
				else {
					var voting_type = "yes";
					switch(a){
						case 1:
						voting_type = "yes";
						break;
						case -1:
						voting_type = "no";
						break;
						case 0:
						voting_type = "maybe";
						break;
					}
					_voting.dates['date' + i + voting_type] = get_votes_count(votes, a, 'date' + i);
				}
			}
		}
		for(b = -1; b < 2; b++) {
			if(b == 0) _voting.restaurants['link' + i + 'didnotvote'] = get_votes_count(votes, null, 'link' + i);
			else {
				var voting_type = "yes";
				switch(b){
					case 1:
					voting_type = "yes";
					break;
					case -1:
					voting_type = "no";
					break;
				}
				_voting.restaurants['link' + i + voting_type] = get_votes_count(votes, b, 'link' + i);
			}
		}
	}
	return _voting;
};

// Gets the count & email list of a specific column having a certain value (example: count & email list of who is going to Restaurant 1)
var get_votes_count = function(votes, vote_value, type){
	var _vote_return = {};
	var _email_list = [];
	var _vote_count = 0;
	for(q = 0; q < votes.length; q++)
	{
		var vote = votes[q];
		if(vote[type] == vote_value) {
			_email_list[_vote_count] = vote.email;
			_vote_count++;
		}
	}
	_vote_return.count = _vote_count;
	_vote_return.emails = _email_list;
	return _vote_return;
};