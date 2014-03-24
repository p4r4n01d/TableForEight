function JSONParse(url, jsObj, type, divResult) {
    var resultDiv = divResult;
	var dataSaved = false;
    //alert(JSON.stringify(jsObj));
    $.ajax({
		headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
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

function eventCtrl($scope) {
	$scope.urlTitle = { text0: "Restaurant Title",
						text1: "Restaurant Title ",
						text2: "Restaurant Title ",
						text3: "Restaurant Title ",
						text4: "Restaurant Title ",
	};
	
    $scope.getTitle = function (restUrl)
    { 
		$.get("restUrl"+restUrl,function(data,status){
												 alert("Data:" +data + ", status:" +status);
			if(status == "success"){
				var Url_title= $(data).filter('title').text();
				switch(restUrl)
				{
					case 0:
					$scope.urlTitle.text0 = Url_title; 
					  break;
					case 1:
					$scope.urlTitle.text1 = Url_title;
					  break;
					case 2:
					$scope.urlTitle.text2 = Url_title;
					  break;
					case 3:
					$scope.urlTitle.text3 = Url_title;
					  break;
					case 4:
					$scope.urlTitle.text4 = Url_title;
					  break;
					default:
					$scope.urlTitle.text = Url_title;
				}
			}
		});
	};
	
	$scope.sendInvite = function() {
	 var jObej = {
	"event": 
	{ "date":"" ,
	 "cutoff_at":"2014,03,31",
	 "link1":$scope.restUrl0,
	 "name1":$scope.urlTitle.text0,
	 "link2":$scope.restUrl1,
	 "name2":$scope.urlTitle.text1,
	 "link3":$scope.restUrl2,
	 "name3":$scope.urlTitle.text2,
	 "link4":$scope.restUrl3,
	 "name4":$scope.urlTitle.text3,
	 "link5":$scope.restUrl4,
	 "name5":$scope.urlTitle.text4,
	 "date1":$scope.date1,
	 "date2":$scope.date2,
	 "date3":$scope.date2,
	 "hash":"testhash",
	 "organiser_email":$scope.organiser_email,
	 "organiser_name":$scope.organiser_name }
	 };
	 
    var resultDiv = $("#resultDivContainer");
	JSONParse("http://localhost:3000/api/events", jObej.event, "POST", resultDiv);
	};
}



