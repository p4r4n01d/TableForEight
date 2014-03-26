function JSONInterface(url, jsObj, type, divResult) {
    var resultDiv = divResult;
	var dataSaved = false;
    //alert(JSON.stringify(jsObj));
    $.ajax({
		headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
        'name': 'test',
        'password': 'test1234',
        url: url,
        type: type,
        data: JSON.stringify(jsObj),
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            switch (result) {
                case true:
					dataSaved=true;
                    processResponse(result);
                    //divResult = result;
                    break;
                default:
					dataSaved=true;
                    //divResult = result;
					divResult.html(result);
            }
        },
        error: function (xhr, ajaxOptions, thrownError) {
        //alert(xhr.status);
        //alert(thrownError);
        //divResult = xhr.status + "<br />" + thrownError;
        divResult.html(xhr.status + "<br />" + thrownError + "<br />json OBJECT: " + JSON.stringify(jsObj));
        }
    });
	return dataSaved;
}


function eventCtrl($scope, $http, $templateCache) {
	
	$scope.method = 'GET';
	 
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
	 var jObej = {
	"event": 
	{ "date":"" ,
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
	 "hash":"testhash",
	 "organiser_email":$scope.organiser_email,
	 "organiser_name":$scope.organiser_name }
	 };
	alert(JSON.stringify(jObej));
    var resultDiv = $("#resultDivContainer");
	var emailList = str.split(";");
	if(emailList.length>0)
	{
		JSONInterface("http://localhost:3000/api/events", jObej.event, "POST", resultDiv);
		for(i=0;i<emailList.length;i++)
		{
			alert(emailList);
			//JSONInterface("http://localhost:3000/api/events", jObej.event, "POST", resultDiv);
		}
	}
	};
}




