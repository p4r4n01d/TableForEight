var JSONInterface = function(url, jsObj, type, get_status) {
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
		success: function(result, status) {
			if(status=="success" && result.status==get_status) NewjsonObject=result.events.id;
		},
		error:function(xhr, ajaxOptions, thrownError) {
			divResult.html(xhr.status + "<br />" + thrownError);
		}
	});
	return NewjsonObject;
};

window.tableforeight = angular.module('tableforeight', []);