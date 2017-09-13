<?php 
echo $header;
//echo '<pre>';print_r($data['groups']);print_r($data['devices']);
//exit("here");
?>
<style>
#googleMap:-webkit-full-screen {
  width: 100%;
  height: 100%;
}
</style>

<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">

                                    <div class="col-lg-9"><div id="googleMap" style="width:100%;height:540px;margin:auto;border:2px solid black"></div>
                                        
                                    </div>
                                    <div class="col-lg-3">
                                        <form method="post" action="index.php?route=gps/trackvehicles&token=<?php echo $token; ?>">
                                        <div class="filter_div_main">
                                            <input class="form-control" type="text" onkeydown="fnKeyDown('deviceID')"  id="deviceID" name="deviceID"  placeholder="Device ID" required value="<?php echo $_POST['deviceID'];?>"/><br>
                                            <input class="form-control datetimepicker" type="text" id="from_date" name="from_date"  placeholder="From date" required value="<?php echo $_POST['from_date'];//$data['dystday'];?>" /><br>
                                            <input class="form-control datetimepicker" type="text" id="to_date" name="to_date"  placeholder="To date" required value="<?php echo $_POST['to_date'];//$data['dtoday'];?>" /><br/><button type="submit" class="btn btn-success" aria-label="Request">Submit </button>
											<div><label>Only Stops :</label>
											<input type="checkbox" name="showOnlyStops" id="showOnlyStops" onchange="fnShowOnlyStops()"> </div>
                                        </div></form>

 
                                        <div class="filter_div_main ">
                                            <ul class="list-group">
                                                <li class="list-group-item"><strong>Summary</strong></li>
                                                <li class="list-group-item">Distance Travelled : <b><?php echo (int)$data['track']['distanceTravelled'];?> Km</b></li>
                                                <li class="list-group-item">Time Travelled : <b><?php echo (int)$data['track']['timeTravelled'];?> Hours</b></li>
                                                <li class="list-group-item">Average Speed : <b><?php echo (int)$data['track']['averageSpeed'];?> Km/Hr</b></li>

                                            </ul>
                                        </div>
                                        <div class="filter_div_main ">
                                                                                    <ul class="list-group" >
                                         <li  class="list-group-item" ><strong >Pushpin Legend</strong></li>
                                         <li class="list-group-item" ><img src="http://www.easygaadi.com/images/markers/current.png" style="width:15px; height: 20px;">  Current Position</li>
                                         <li class="list-group-item"><img src="http://www.easygaadi.com/images/markers/start.png" style="width:15px; height: 20px;">  Start Position</li>
                                         <li class="list-group-item"><img src="http://www.easygaadi.com/images/markers/stop.png" style="width:15px; height: 20px;">  Stop Position</li>
                                        </ul>
                                        </div>
                                    </div>
                                

</div>
<!-- /#page-wrapper -->

<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.css"/>
<script src="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.js"></script>

<script type="text/javascript">
    $('.datetimepicker').datetimepicker({
        dayOfWeekStart: 1,
        lang: 'en',
        format: 'Y-m-d H:i',
        startDate: '<?php echo date("Y/m/d 23:59"); ?>'	//'2015/09/01'
    });
</script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" /> 
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript">
    //function fnKeyDownCustTruck(id){
function fnKeyDown(id){
//alert(id)
$(function() {
var availableTags = [
<?php 
foreach($_SESSION['device'] as $device){ echo $pre.'"'.$device['deviceID'].'"';$pre=",";}?>
];
function split( val ) {
return val.split( /,\s*/ );
}
function extractLast( term ) {
return split( term ).pop();
}
$( "#"+id )
// don't navigate away from the field on tab when selecting an item
.bind( "keydown", function( event ) {

//alert(event.keyCode +'==='+$.ui.keyCode.TAB)
if ( event.keyCode === $.ui.keyCode.TAB &&
$( this ).data( "ui-autocomplete" ).menu.active ) {
event.preventDefault();
}
})
.autocomplete({
minLength: 0,
source: function( request, response ) {
//	alert(extractLast( request.term ))
//stop concatination after ,
if(extractLast( request.term )=="")
{
	return false;
}
//stop concatination after ,

// delegate back to autocomplete, but extract the last term
response( $.ui.autocomplete.filter(
availableTags, extractLast( request.term ) ) );
},
focus: function() {
// prevent value inserted on focus
return false;
},

});
});
}
</script>
<script src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js"></script>-->
<script>
	var urlPrefix="http://www.easygaadi.com/";	
	var stopicon = new google.maps.MarkerImage(urlPrefix+"images/markers/stop.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

        var currenticon = new google.maps.MarkerImage(urlPrefix+"images/markers/current.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

	var starticon = new google.maps.MarkerImage(urlPrefix+"images/markers/start.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

	var h0 = new google.maps.MarkerImage(urlPrefix+"images/markers/h0.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));
		
	var h1 = new google.maps.MarkerImage(urlPrefix+"images/markers/h1.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

	var h2 = new google.maps.MarkerImage(urlPrefix+"images/markers/h2.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

	var h3 = new google.maps.MarkerImage(urlPrefix+"images/markers/h3.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

	var h4 = new google.maps.MarkerImage(urlPrefix+"images/markers/h4.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

	var h5 = new google.maps.MarkerImage(urlPrefix+"images/markers/h5.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

	var h6 = new google.maps.MarkerImage(urlPrefix+"images/markers/h6.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

		var h7 = new google.maps.MarkerImage(urlPrefix+"images/markers/h7.png",
        new google.maps.Size(32, 43), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

        var map;
var markersArray = [];
var markers = []; //for hide,show
var image = 'img/';
var bounds = new google.maps.LatLngBounds();
var loc;
var data=[];//new Array();
var iw = new google.maps.InfoWindow(); // Global declaration of the infowindow
       function init(){
    var mapOptions = { mapTypeId: google.maps.MapTypeId.ROADMAP };
    map =  new google.maps.Map(document.getElementById("googleMap"), mapOptions);
    <?php $rows1=$data['track']['points'];
            $size=sizeof($data['track']['points'])-1;
        if(is_array($rows1)){			
        for($i=0;$i<count($rows1);$i++) { //you could replace this with your while loop query?>
                
    loc = new google.maps.LatLng("<?php echo $rows1[$i]['latitude']?>","<?php echo $rows1[$i]['longitude']?>");
    data[<?php echo $i;?>]=  loc;
	bounds.extend(loc);
    addMarker(loc, <?php if($i==0){ echo 'starticon'; }else if ($i==$size){echo "currenticon";} else {getMapIcon($rows1[$i]['speed'],$rows1[$i]['heading']);} ?>,"<?php echo $rows1[$i]['date_time'] ?>","<?php echo round($rows1[$i]['speed']) ?>","<?php echo round($rows1[$i]['odometerKM']); ?>","<?php echo $rows1[$i]['latitude'];?>,<?php echo $rows1[$i]['longitude'];?>");
        <?php }}?>
    map.fitBounds(bounds);
    map.panToBounds(bounds);    

	    var flightPath = new google.maps.Polyline({
    path: data,
    geodesic: true,
    strokeColor: '#118900',
    strokeOpacity: 1.0,
    strokeWeight: 2
  });

  flightPath.setMap(map);
}

function addMarker(location,icon,  date_time,speed,odo,latLng) {          
    var marker = new google.maps.Marker({
        position: location,
        icon:icon,
        map: map,
        status: "active"
    });

	/*var infowindow = new google.maps.InfoWindow({
    content: content
  });*/

  if(speed!=0){
		markers.push(marker);
	}

	 marker.addListener('click', function() {
        //infowindow.open(map, marker);
        iw.setContent('Loading..');
					iw.open(map, marker);
    $.ajax({
	url: "http://www.easygaadi.com/index.php/site/getGMapContent?latlng=" +latLng,
	success: function(data) {
		//iw.setContent(date_time+"</b>,<b>"+speed+"Km/Hr</b>,<b>"+odo+"Km</b>,<b>"+data+"</b>");
			iw.setContent(date_time+"</b>,<b>"+speed+"Km/Hr</b>,<b>"+data+"</b>");
		//iw.open(map, marker);
	}
	});
    });
}

$(function(){ init(); }); 

function fnShowOnlyStops(){
	
	var checkFlag=$("#showOnlyStops").prop("checked");
	if(checkFlag){
		var varmap=null;
	}else{
		var varmap=map;
	}
	for (var i = 0; i < markers.length; i++) {
          markers[i].setMap(varmap);
    }
}

</script>
<?php
function getMapIcon($speed,$heading){
	if($speed>0){
		if($heading>=0 && $heading<25){
			$pic="h0";
		} else if($heading>=25 && $heading<70){
			$pic="h1";
		} else if($heading>=70 && $heading<110){
			$pic="h2";
		} else if($heading>=110 && $heading<160){
			$pic="h3";
		} else if($heading>=160 && $heading<200){
			$pic="h4";
		} else if($heading>=200 && $heading<240){
			$pic="h5";
		} else if($heading>=240 && $heading<290){
			$pic="h6";
		} else if($heading>=290 && $heading<330){
			$pic="h7";
		} else if($heading>=330 && $heading<390){
			$pic="h0";
		}  else if($heading>=390 && $heading<420){
			$pic="h1";
		} else if($heading>=420 && $heading<450){
			$pic="h2";
		} else if($heading>=450 && $heading<500){
			$pic="h3";
		}
	}else{
		$pic="stopicon";
	}
	echo $pic;
}
?>

<script>
  var videoElement = document.getElementById("googleMap");
    
  function toggleFullScreen() {
    if (!document.mozFullScreen && !document.webkitFullScreen) {
      if (videoElement.mozRequestFullScreen) {
        videoElement.mozRequestFullScreen();
      } else {
        videoElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
      }
    } else {
      if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
      } else {
        document.webkitCancelFullScreen();
      }
    }
  }
  
  document.addEventListener("keydown", function(e) {
    if (e.keyCode == 13) {
      toggleFullScreen();
    }
  }, false);
</script>

<?php echo $footer; ?>