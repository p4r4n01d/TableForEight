function JSONInterface(url, jsObj, type, get_status) {
	NewjsonObject = null;
    divResult = $("#resultDivContainer");
    $.ajax({
		headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
        url: url,
        type: type,
        data: JSON.stringify(jsObj),
        dataType: "json",
        async: false,
        contentType: "application/json; charset=utf-8",        
		success: function (result, status) {
			if(status=="success" && result.status==get_status) NewjsonObject=result.events.id;
        },
        error: function (xhr, ajaxOptions, thrownError) {
        	divResult.html(xhr.status + "<br />" + thrownError);
        }
    });
	return NewjsonObject;
}


function eventCtrl($scope, $http, $templateCache) {
	
	$scope.method = 'GET';
	 
	$scope.vote_process = function(event_id, vote_id, type, result) {
		VoteJSON = {
		"vote": 
		{ "id":vote_id }
		};
		VoteJSON.vote[type]=result;
		VoteJsonNew = null;
		VoteJsonNew=JSONInterface("http://localhost:3000/api/events/"+event_id+"/"+vote_id+"", VoteJSON, "POST", "ok");
		alert("VoteID:" + VoteJsonNew);
		tempVote_resutl="";
		if(VoteJsonNew!=null) tempVote_resutl = "Thank You for Voting";
		else tempVote_resutl = "Vote Not Set";
		
		switch(type){
			case "link":
				$scope.voteResult_where = tempVote_resutl;
			break;
			case "date":
				$scope.voteResult_when = tempVote_resutl;
			break;
			case "confirmed":
				$scope.voteResult_confirm = tempVote_resutl;
			break;
		}
	};
	 
	$scope.fetch = function(titleURL, restaurantTitle) {
	$scope.code = null;
	$scope.response = null;
	 
	$http({method: $scope.method, url: titleURL, cache: $templateCache}).
	success(function(data, status) {
	var tempdata = $(data).filter("title").text();
	switch(restaurantTitle)
	{
		case 1:
		$scope.name1 = tempdata;
		break;
		case 2:
		$scope.name2 = tempdata;
		break;
		case 3:
		$scope.name3 = tempdata;
		break;
		case 4:
		$scope.name4 = tempdata;
		break;
		case 5:
		$scope.name5 = tempdata;
		break;
	}
	}).
	error(function(data, status) {
	var tempdata = data || "Request failed";
	switch(restaurantTitle)
	{
		case 1:
		$scope.name1 = tempdata;
		break;
		case 2:
		$scope.name2 = tempdata;
		break;
		case 3:
		$scope.name3 = tempdata;
		break;
		case 4:
		$scope.name4 = tempdata;
		break;
		case 5:
		$scope.name5 = tempdata;
		break;
	}
	});
	};
	
	// SENDING INVITATION
	$scope.sendInvite = function() {
	newDate = new Date();
	datetime = "" + newDate.today + " " + newDate.timeNow;
	EventJSON = {
	"event": 
	{ "date":$scope.date1,
	 "cutoff_at":$scope.date4,
	 "link1":$scope.restUrl1,
	 "name1":$scope.name1,
	 "link2":$scope.restUrl2,
	 "name2":$scope.name2,
	 "link3":$scope.restUrl3,
	 "name3":$scope.name3,
	 "link4":$scope.restUrl4,
	 "name4":$scope.name4,
	 "link5":$scope.restUrl5,
	 "name5":$scope.name5,
	 "date1":$scope.date1,
	 "date2":$scope.date2,
	 "date3":$scope.date3,
	 "hash":$scope.organiser_email+datetime,
	 "organiser_email":$scope.organiser_email,
	 "organiser_name":$scope.organiser_name }
	 };
	emailList = $scope.guest_list.split(";");
	if(emailList.length>0)
	{
		
		EventJsonNew=JSONInterface("http://localhost:3000/api/events", EventJSON, "POST", "created");
		if(EventJsonNew!=null)
		{
			DataSaved=false;
			for(i=0;i<=emailList.length;i++)
			{
				alert(emailList[i] + ":::: EventID:" + EventJsonNew);
				VoteJSON = {
				"vote": 
				{ "email":emailList[i],
				 "link1":"-1",
				 "link2":"-1",
				 "link3":"-1",
				 "link4":"-1",
				 "link5":"-1",
				 "date1":"-1",
				 "date2":"-1",
				 "date3":"-1",
				 "confirmed":false }
				};
				//alter votes controller to give out the same format in creating votes
				VoteJsonNew=JSONInterface("http://localhost:3000/api/events/"+EventJsonNew+"/votes", VoteJSON, "POST", "created");
				alert("VoteID:" + VoteJsonNew);
				if(VoteJsonNew!=null) DataSaved=true;
				else DataSaved=false;
			}
			if(DataSaved) $scope.inviteResult = "Email Sent";
			else $scope.inviteResult = "Email Not Sent";
		}
	}
	};
}

$('#popoverRestoYes1').popover();
$('#popoverRestoNo1').popover();
$('#popoverDateYes1').popover();
$('#popoverDateNo1').popover();
$('#popoverDateMaybe1').popover();
$('#popoverRestoYes2').popover();
$('#popoverRestoNo2').popover();
$('#popoverDateYes2').popover();
$('#popoverDateNo2').popover();
$('#popoverDateMaybe2').popover();
$('#popoverRestoYes3').popover();
$('#popoverRestoNo3').popover();
$('#popoverDateYes3').popover();
$('#popoverDateNo3').popover();
$('#popoverDateMaybe3').popover();
$('#popoverRestoYes4').popover();
$('#popoverRestoNo4').popover();
$('#popoverRestoYes5').popover();
$('#popoverRestoNo5').popover();
$('#popoverOption').popover({ trigger: "hover" });



