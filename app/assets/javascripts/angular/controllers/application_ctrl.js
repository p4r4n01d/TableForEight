

tableforeight.controller('eventCtrl', ['$scope', '$http', '$templateCache', function ($scope, $http, $templateCache) {
	
	$scope.method = 'GET';
	 
	$scope.vote_process = function(event_id, vote_id, type, result) {
		VoteJSON = {
		"vote": 
		{ "id":vote_id }
		};
		VoteJSON.vote[type]=result;
		VoteJsonNew = null;
		VoteJsonNew=JSONInterface("/api/event/"+event_id+"/"+vote_id+"", VoteJSON, "POST", "ok");
		tempVote_resutl="";
		if(VoteJsonNew!=null) tempVote_resutl = "Thank you for voting";
		else tempVote_resutl = "Vote not set";
		
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
	 
	$scope.selection = function(name, url, type) {
		if(type=="date"){
			$scope["selected"+type]= name;
		}
		else{
			$scope["selected"+type]= name;
			$scope["selected"+type+"Url"]= url;
		}
	};
	 
	$scope.confirmation = function(event_id) {
		EventJSON = {
		"event": 
		{ "id":event_id,
		 "date":$scope.selectedDate,
		 "link1":$scope.selectedRestaurantUrl,
		 "name1":$scope.selectedRestaurant }
		 };
		Event_JsonNew=JSONInterface("/api/events/"+event_id+"", EventJSON, "PUT", "ok");
		Event_JsonNew=JSONInterface("/email/"+event_id+"", EventJSON, "POST", "ok");
		tempVote_resutl = "Event not confirmed";
		if(Event_JsonNew!=null) tempVote_resutl = "Event confirmation sent";
		$scope.email_status = tempVote_resutl;
	};
	
	$scope.results = function(event_id) {
		Result_json = "";
		$http.get('/api/get/'+event_id).
		success(function(response) {
			Result_json=response;
			if(Result_json!=""){
				for(link_count=1;link_count<6;link_count++)
				{
					link_title="link"+link_count;
					for(b = 0; b < 2; b++)
					{
						tempObj=null;
						tempObj1=null;
						scopeCount="";
						divPlace="";
						switch(b){
							case 0:
							tempObj= Result_json.voting[link_title].going.count;
							tempObj1= Result_json.voting[link_title].going.emails;
							scopeCount=link_title+'going';
							divPlace="#linkbtnyes"+link_count;
							break;
							case 1:
							tempObj= Result_json.voting[link_title].notgoing.count;
							tempObj1= Result_json.voting[link_title].notgoing.emails;
							scopeCount=link_title+'notgoing';
							divPlace="#linkbtnno"+link_count;
							break;
						}
						for(i = 0; i < tempObj.length; i++)
						{
							objYes = tempObj[i];
							$scope[scopeCount] = objYes.Counts;
							if(objYes.Counts>0)
							{
								var tempDate="";
								divDetails=$(divPlace);
								for(a=0; a<tempObj1.length;a++){
									object4 = tempObj1[a];
									tempDate+=object4.email+" ";
								}
								divDetails.attr("data-content",tempDate);
							}
						}
					}
				}
				for(link_count=1;link_count<4;link_count++)
				{
					link_title="date"+link_count;
					for(b = 0; b < 3; b++)
					{
						tempObj=null;
						tempObj1=null;
						scopeCount="";
						divPlace="";
						switch(b){
							case 0:
							tempObj= Result_json.voting[link_title].going.count;
							tempObj1= Result_json.voting[link_title].going.emails;
							scopeCount=link_title+'going';
							divPlace="#datebtnyes"+link_count;
							break;
							case 1:
							tempObj= Result_json.voting[link_title].notgoing.count;
							tempObj1= Result_json.voting[link_title].notgoing.emails;
							scopeCount=link_title+'notgoing';
							divPlace="#datebtnno"+link_count;
							break;
							case 2:
							tempObj= Result_json.voting[link_title].maybe.count;
							tempObj1= Result_json.voting[link_title].maybe.emails;
							scopeCount=link_title+'maybe';
							divPlace="#datebtnmaybe"+link_count;
							break;
						}
						for(i = 0; i < tempObj.length; i++)
						{
							objYes = tempObj[i];
							$scope[scopeCount] = objYes.Counts;
							if(objYes.Counts>0)
							{
								var tempDate="";
								divDetails=$(divPlace);
								for(a=0; a<tempObj1.length;a++){
									object4 = tempObj1[a];
									tempDate+=object4.email+" ";
								}
								divDetails.attr("data-content",tempDate);
							}
						}
					}
				}
			}
		}).
		error(function(data, status) {
			$scope.selectedRestaurant= data || "Request failed";
		});
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
	var tempdata = "Temp Title";
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
	
	 
	$scope.get_restaurants = function(type) {
	$scope.code = null;
	$scope.response = null;
	 
	$http({method: 'GET', url: '/api/places/'+type, cache: $templateCache}).
	success(function(data, status) {
			alert(JSON.stringify(data));
	}).
	error(function(data, status) {
			alert(JSON.stringify(data));
	});
	};
	
	// SENDING INVITATION
	$scope.sendInvite = function() {
		var d = new Date();
		var sent_email="NO";
		var month = d.getMonth()+1;
		var day = d.getDate();
		var datetime = d.getFullYear() + '/' +
			(month<10 ? '0' : '') + month + '/' +
			(day<10 ? '0' : '') + day;
		var who_error="";
		var restaurant_error="";
		var date_error="";
		var ErrorString="";
		for(i=1;i<=5;i++)
		{
			if($scope['date'+i]=="undefined");
		}
		if(ErrorString=="" && sent_email=="NO"){
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
			 "organiser_email":$scope.organiser_email,
			 "organiser_name":$scope.organiser_name }
			 };
			emailList = $scope.guest_list.split(";");
			if($scope.guest_list.split("\n").length>1){
				emailList = $scope.guest_list.split("\n");
			}
			if($scope.guest_list.split(",").length>1){
				emailList = $scope.guest_list.split("\n");
			}
			if($scope.guest_list.split(" ").length>1){
				emailList = $scope.guest_list.split(" ");
			}
			if(emailList.length>1)
			{
				EventJsonNew="";
				EventJsonNew=JSONInterface("/api/events", EventJSON, "POST", "created");
				if(EventJsonNew!=null)
				{
					DataSaved=false;
					for(i=0;i<emailList.length;i++)
					{
						VoteJSON = {
						"vote": 
						{ "email":emailList[i].replace(";","").replace("\n","").replace(" ","").replace("<","").replace(">",""),
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
						VoteJsonNew="";
						VoteJsonNew=JSONInterface("/api/events/"+EventJsonNew+"/votes", VoteJSON, "POST", "created");
						if(VoteJsonNew!=null) DataSaved=true;
						else DataSaved=false;
					}
					if(DataSaved) 
					{
						sent_email="YES";
						$scope.inviteResult = "Email sent";
					}
					else $scope.inviteResult = "Email not sent";
				}
			}
		}
		else $scope.inviteResult = "Email sent";
	};
}]);

$('.btn').popover();


