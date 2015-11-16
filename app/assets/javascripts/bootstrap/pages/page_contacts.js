var ContactPage = function () {

    return {
        
    	//Basic Map
        initMap: function () {
			var map;
			$(document).ready(function(){
			  map = new GMaps({
				div: '#map',
				scrollwheel: false,				
				lat: 35.116990,
				lng: 129.092428
			  });
			  
			  var marker = map.addMarker({
				lat: 35.116990,
				lng: 129.092428,
	            title: 'Company, Inc.'
		       });
			});
        },

        //Panorama Map
        initPanorama: function () {
		    var panorama;
		    $(document).ready(function(){
		      panorama = GMaps.createPanorama({
		        el: '#panorama',
		        lat : 35.116990,
		        lng : 129.092428
		      });
		    });
		}        

    };
}();