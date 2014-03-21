function allowDrop(ev)
{
	ev.preventDefault();
}

function drag(ev)
{
	ev.dataTransfer.setData("Text",ev.target.id);
}

function drop(ev)
{
	ev.preventDefault();
	var data = ev.dataTransfer.getData("Text");
	ev.target.appendChild(document.getElementById(data));
}

function getPage(){
	setInterval(function(){jTimer()},1000);
}

function jTimer()
{
	$.get("tserver.php",function(data,status){
		if(status == "success"){
		  $("#tserver").html(data);
		}
    });
}

function checkUser()
{
	if(typeof(Storage)!=="undefined")
	  {  
		  if(localStorage.getItem("userName")=="Old")
		  {
			  alert("Welcome Back.");
			  $("#buttOne").css("background", "-webkit-linear-gradient( #F00, #900)");
			  $("#buttOne").css("background", "-o-linear-gradient(#F00, #900)");
			  $("#buttOne").css("background", "-moz-linear-gradient(#F00, #900)");
			  $("#buttOne").css("background", "linear-gradient(#F00, #900)");
		  }
		  else{
			  localStorage.setItem("userName", "Old");
			  alert("New User Added!");
			  $("#buttOne").css("background", "-webkit-linear-gradient( #F00, #900)");
			  $("#buttOne").css("background", "-o-linear-gradient(#F00, #900)");
			  $("#buttOne").css("background", "-moz-linear-gradient(#F00, #900)");
			  $("#buttOne").css("background", "linear-gradient(#F00, #900)");
		  }
	  }
	else
	{
		$("#buttonDiv").html("Browser does not support Web Storage.");
	}
}


jQuery(function($){

   $('.nav').bind('Navfit', function(){
            var nav = $(this), items = nav.find('a');
                  
            $('body').removeClass('nav-menu');                    
                  
            // when the nav wraps under the logo, or when options are stacked, display the nav as a menu              
            if ( (nav.offset().top > nav.prev().offset().top) || ($(items[items.length-1]).offset().top > $(items[0]).offset().top) ) {
            
               // add a class for scoping menu styles
               $('body').addClass('nav-menu');
               
            };
         })
      
      // toggle the menu items' visiblity
      .find('#nav-btn').bind('click focus', function(){
            $(this).parent().toggleClass('expanded')
         });  
   
   // ...and update the nav on window events
   $(window).bind('load resize orientationchange', function(){
      $('.nav').trigger('Navfit');
   });
   
});

function restCtrl($scope) {
	$scope.urlTitle = { text0: "Restaurant Title",
						text1: "Restaurant Title ",
						text2: "Restaurant Title ",
						text3: "Restaurant Title ",
						text4: "Restaurant Title ",
	};
	
}

function inviteCtrl($scope) {
	
    $scope.greet = function ()
    { 
		$.get("temp.html",function(data,status){
												 alert("Data:" +data + ", status:" +status);
			if(status == "success"){
				$scope.greeting = "Title: " + $(data).filter('title').text();
			}
		});
		$scope.message = "Hi " + $scope.yourName + "! Welcome!"; 
	};
}
