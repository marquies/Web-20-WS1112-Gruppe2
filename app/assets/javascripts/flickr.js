
var flickR = {
	// http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=7e821c3288da47d4585889fbd53b0bca&lat=48.13913&lon=11.58019&format=json&nojsoncallback=1
	
	api_key : "6d75efb86626ad52325d1b9ce94499ef",
	secret : "f0f3111dbecaeffd",
	
	load_photos: function( lat, lon ) {
		// München:
		// lat: 48.13913
		// lon: 11.58019
		var flickrURL = 'http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=' + this.api_key + '&lat=' + lat + '&lon=' + lon + '&per_page=8&page=0&format=json&nojsoncallback=1';
		//alert(flickrURL);
		$('#flickR-container').html('');
		$('#flickR-container').addClass('flickR-loading');
		
		$.getJSON(flickrURL, function(data) { 
			if ( data.photos ) {
				var total = data.photos.total;
				var items = [];

			    //loop through the results with the following function
			    $.each(data.photos.photo, function(i,item) {
			        //build the url of the photo in order to link to it
			        var photoURL = 'http://farm' + item.farm + '.static.flickr.com/' + item.server + '/' + item.id + '_' + item.secret + '_m.jpg'

			        //turn the photo id into a variable
			        var photoID = item.id;
					
					items.push('<li id="photoID_' + photoID + '" class="flickR-thumb-container"><img class="flickR-thumb" src="' + photoURL + '" alt="" title="' + item.title + '" /></li>');
				});

				$('#flickR-container').html(
					$('<ul/>', {
						'class': 'flickR-photo-list',
						html: items.join('')
					})
				);

				$('li .flickR-thumb').each(function() {
					this.addEventListener('load', flickR.thumb_resize, false);
				});
			}
			
			$('#flickR-container').removeClass('flickR-loading');
		});
		
		return false;
	},
	
	thumb_resize: function ( e ) {
		var el = e.target;
		
		if ( el.width < el.height ) {
			el.height = el.height * ( 100 / el.width );
			el.width = 100;
			el.style.marginTop = ( ( el.height - 100 ) / -2 ) + 'px';
		} else {
			el.width = el.width * ( 100 / el.height );
			el.height = 100;
			el.style.marginLeft = ( ( el.width - 100 ) / -2 ) + 'px';
		}
	},
	
	dump: function(obj, level, ret_result) {
		if ( ! level ) {
			level = 0;
		}

		var prefix = '';
		for ( i = 0; i < level; i++ ) {
			prefix+= '--';
		}
		prefix += ' ';

	    var out = '';
	    for (var i in obj) {
	        out += prefix + i + ": " + obj[i] + " (" + typeof( obj[i] ) + ")\n";
			if ( typeof( obj[i]) == 'object' )
				out += dump(obj[i], level+1, true);
	    }

		if ( ret_result ) {
			return out;		
		}

	    var pre = document.createElement('pre');
	    pre.innerHTML = out;
	    document.body.appendChild(pre);
	}
	
};

flickRinitialize = function() {
	// München:
	// lat: 48.13913
	// lon: 11.58019	
	//flickR.load_photos( 48.13913, 11.58019 );
	
	// Bielefeld
	// lat: 52.020833
	// lon: 8.535
	flickR.load_photos( 52.020833, 8.535333 );
};

function inspect(obj, maxLevels, level)
{
  var str = '', type, msg;

    // Start Input Validations
    // Don't touch, we start iterating at level zero
    if(level == null)  level = 0;

    // At least you want to show the first level
    if(maxLevels == null) maxLevels = 1;
    if(maxLevels < 1)     
        return '<font color="red">Error: Levels number must be > 0</font>';

    // We start with a non null object
    if(obj == null)
    return '<font color="red">Error: Object <b>NULL</b></font>';
    // End Input Validations

    // Each Iteration must be indented
    str += '<ul>';

    // Start iterations for all objects in obj
    for(property in obj)
    {
      try
      {
          // Show "property" and "type property"
          type =  typeof(obj[property]);
          str += '<li>(' + type + ') ' + property + 
                 ( (obj[property]==null)?(': <b>null</b>'):('')) + '</li>';

          // We keep iterating if this property is an Object, non null
          // and we are inside the required number of levels
          if((type == 'object') && (obj[property] != null) && (level+1 < maxLevels))
          str += inspect(obj[property], maxLevels, level+1);
      }
      catch(err)
      {
        // Is there some properties in obj we can't access? Print it red.
        if(typeof(err) == 'string') msg = err;
        else if(err.message)        msg = err.message;
        else if(err.description)    msg = err.description;
        else                        msg = 'Unknown';

        str += '<li><font color="red">(Error) ' + property + ': ' + msg +'</font></li>';
      }
    }

      // Close indent
      str += '</ul>';

    return str;
}

$(document).ready(function() { flickRinitialize(); });
//window.addEventListener("load", flickRinitialize, false);
