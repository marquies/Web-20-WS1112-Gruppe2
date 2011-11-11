
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

function loadUsers() {

    $.ajaxSetup ({  
        cache: false  
    });
    var loadUrl = "/?format=json";  

    $.getJSON(loadUrl, function(data) {
        var items = [];

        $.each(data, function(key, val) {
            console.info(val.location);
            geocoder.geocode( { 'address': val.location}, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    var marker = new google.maps.Marker({
                        map: map,
                        draggable: false,
                        title: val.fullName,
                        animation: google.maps.Animation.DROP,
                        position: results[0].geometry.location
                    });
                    var infowindow = new google.maps.InfoWindow({
                        content: "<div>Hier wohnt Benutzer: "+val.fullName+
                        "<p><img style=\"width: 100px; height: 100px;\" src=\""+ val.iconUrl +"\" /></p></div>"
                    });
                    google.maps.event.addListener(marker, 'click', function() {
                        infowindow.open(map,marker);
                     });
                     
                } else {
                    alert("Geocode was not successful for the following reason: " + status);
                }
           });
           
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