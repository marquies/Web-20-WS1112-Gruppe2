
var map;
var geocoder = new google.maps.Geocoder();

function codeAddress(address) {
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
                map: map,
                title: "FerUniversität",
                position: results[0].geometry.location
            });
        } else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
}
var previous_infowindow;
function loadUsers() {
    $.ajaxSetup ({  
        cache: false  
    });
    var loadUrl = "/?format=json";  

    $.getJSON(loadUrl, function(data) {
        var items = [];
		var timeToWait = 0;
		
        $.each(data, function(key, val) {
            console.info(val.location);

			if ( items.indexOf(val.location) == -1 ) {
				items.push( val.location );
				
				setTimeout(function() {
		            geocoder.geocode( { 'address': val.location}, function(results, status) {
		                if (status == google.maps.GeocoderStatus.OK) {
		 					$('#maps_logging').append('<span class="log_msg log_success">Geocode was successful (' + status + ')</span>');
		                   var marker = new google.maps.Marker({
		                        map: map,
		                        draggable: false,
		                        title: val.fullName,
		                        animation: google.maps.Animation.DROP,
		                        position: results[0].geometry.location
		                    });

		                    var infowindow = new google.maps.InfoWindow({
		                        content: "<div>Hier wohnt Benutzer: "+val.fullName+
		                        "<p><img style=\"width: 100px; height: 100px;\" src=\""+ val.iconUrl +"\" /></p>" +
								'<p><a href="#" onclick="javascript:flickR.load_photos(' + results[0].geometry.location.lat() + ', ' + results[0].geometry.location.lng() + ');return false;">Bilder aus der Umgebung anzeigen</a>' + "</p></div>"
		                    });
		                    google.maps.event.addListener(marker, 'click', function() {
								if ( previous_infowindow ) {
									previous_infowindow.close();
								}
		                        infowindow.open(map, marker);
								previous_infowindow = infowindow;
		                     });
                     
		                } else {
							$('#maps_logging').append('<span class="log_msg log_failure">Geocode was not successful for the following reason: ' + status + '</span>');
		                    //alert("Geocode was not successful for the following reason: " + status);
		                }
		           });}
				, timeToWait);

				// Ca. nach 14-15 loads gibt Google nur noch eine Auskuft pro Sekunde
				timeToWait += ( timeToWait > 3000 ? 1050 : 250 );
			} else {
				$('#maps_logging').append('<span class="log_msg">Ort "' + val.location + '" mehrfach...</span>');
			}
        });
    });
}

function initialize() {

    var address = "Universitätsstr. 1, Hagen, Germany";
    codeAddress(address);
    var myOptions = {
        zoom: 4,
        mapTypeId: google.maps.MapTypeId.SATELLITE
    };
    map = new google.maps.Map(document.getElementById('map_canvas'),
    myOptions);
}

google.maps.event.addDomListener(window, 'load', initialize);