<?php 
echo $header;
//echo '<pre>';print_r($data['groups']);print_r($data['devices']);
//exit("here");
?>
<style>
.labels {
    color: black;
    background-color: white;
    font-family:"Lucida Grande", "Arial", sans-serif;
    font-size: 10px;
    text-align: center;
	font-weight:bold;
    width: 65px;
    white-space: nowrap;
}
#googleMapDiv:-webkit-full-screen {
  width: 100%;
  height: 100%;
}
</style>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">
   <div id="locationListDiv" style="width:20%;height:540px;margin:0px;padding:0px;overflow:scroll;clear:both">
									<table class="table table-bordered table-condensed table-striped table-hover" id="requests">
                                            <thead>
                                                <tr class="col_head">
                                                    <th width="35%"> Truck No <!-- <br><input id="overspeedalarm" name="overspeedalarm" type="checkbox">Stop Alarm --></th>
                                                    <th width="65%"> Speed <select name="groupListSelect" id="groupListSelect" onchange="fnGetGroupId(this)" class="col-md-4 form-control pull-right serch_span_dibss" ><option value="0" >All</option>
                                            <?php
                                            foreach ($data['groups'] as $k => $group) {
                                                $selected = $group['groupID'] == $_GET[gid] ? 'selected' : '';
                                                echo '<option value="' . $group['groupID'] . '"  ' . $selected . ' >' . $group['displayName'] . '</option>';
                                            }
                                            ?>
                                        </select></th>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php 
												$date=date('Y-m-d');
												foreach($data['devices'] as $device){ 
												$todayODO=$device['lastOdometerKM']-$_SESSION[$date][$device['deviceID']];
												$addr=getGPBYLATLNGDetails($device["lastValidLatitude"].",".$device["lastValidLongitude"]);
												if((substr(trim($addr['address']),0,5)=='NH16,') && $_SESSION['gps_account_id']=='skmastanvali'){ //using googlemaps api for skmastanvali
													$loc=getGPBYLATLNGDetailsGoogle($device["lastValidLatitude"].",".$device["lastValidLongitude"]);
													$addr['address']=$loc['address']!=""?$loc['address']:$addr['address'];
												}
												?>
                                                <tr <?php if($device['lastGPSTimestamp']+5400<strtotime('now')){?>style="background-color:#ed2b37;"<?php }?>>
												<td><a href="javascript:fnSearch('<?php echo $device['deviceID'];?>')" ><strong><?php echo $device['deviceID'];?></strong></a><br><small><?php echo $device['date_time'];?></small></td> 
												
												<td <?php if(floor($device['lastValidSpeedKPH'])>0 && floor($device['lastValidSpeedKPH'])<$_SESSION['overSpeedLimit']){ echo 'class="success"';} else if(floor($device['lastValidSpeedKPH'])>=$_SESSION['overSpeedLimit']){ 'style:background-color:maroon'; } else { echo 'class="danger"'; }?>> <small><a href="javascript:fnShowMarkerAddress('<?php echo $device['deviceID'];?>','<?php echo floor($device['lastValidSpeedKPH']);?>','<?php echo $device["lastValidLatitude"].",".$device["lastValidLongitude"];?>','<?php echo $device['lastOdometerKM'];?>')" ><?php echo floor($device['lastValidSpeedKPH']);?> Km/Hr</a> - 
												<span id="today"><a href="javascript:fnShowMarker('<?php echo $device['deviceID'];?>');"><?php echo $todayODO; ?> Km</span></small></td></tr>
                                                <?php }?>
                                            </tbody>
                                        </table>
									</div>
									<div id="googleMapDiv" style="right:0px;display:inline-block; width: 80%; height: 540px;top: 90px; border: 1px solid black; position: absolute; overflow: hidden;"></div>
									<table class="table">
									<tr><td >Truck No</td><td>Speed</td><td>Address</td><td>Total ODO</td></tr>
									<tr><td id="idtruckno"></td><td  id="idtruckspeed" ></td><td  id="idtruckaddr"></td><td  id="totalodo"></td></tr>
									</table> 

</div>

<div class="modal" id="searchDevice" role="dialog">
<div class="modal-dialog modal-lg">
    <div class="modal-content">
	<div class="modal-header">
	    <button type="button" class="close" id="close_CP" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	    <h4 class="modal-title text-center" id="myModalLabel">Track Vehicle - <span id="search_device_title"></span></h4>
	</div>
	<div class="modal-body">
	    <form method="post" action="index.php?route=gps/trackvehicles&token=<?php echo $token; ?>">
		<div class="form_spaceing">
		    <input type="id" class="form-control datetimepicker" name="from_date" id="from_date" placeholder="From Date" required value="<?php echo gmdate('Y-m-d', strtotime('now')-86400);?>" >
		    <input type="hidden" class="form-control" id="device_id" name="deviceID" >
		</div>
		<div class="form_spaceing">
		    <input type="id" class="form-control datetimepicker" name="to_date" id="to_date" placeholder="To Date" value="<?php echo date('Y-m-d');?>" required>
		</div>
		<div class="col-sm-12 text-center">
		    <button type="submit" class="btn btn-success" aria-label="Request">Submit </button>
		</div>
	    </form>
	    <div class="clearfix"></div>
	</div>
	<div class="clearfix"></div>
    </div>
    <div class="clearfix"></div>
</div>
</div>
<!-- /#page-wrapper -->


<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.css"/>
<script src="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.js"></script>

<!-- <link rel="stylesheet" type="text/css" href="<?php //echo Yii::app()->baseUrl; ?>/js/datetime/jquery.datetimepicker.css"/>
<script src="<?php //echo Yii::app()->baseUrl; ?>/js/datetime/jquery.datetimepicker.js"></script> -->
<script type="text/javascript">
$('#idViewType').on('change',function(){
	if($(this).val()=='googleMapDiv'){
		$('#locationListDiv').css('display','none');
		$('#googleMapDiv').css('display','');
	}else if($(this).val()=='locationListDiv'){
		$('#googleMapDiv').css('display','none');
		$('#locationListDiv').css('display','');
	}
});   

function fnSearch(deviceID){
    $('#searchDevice').modal('show');
    $('#device_id').val(deviceID);
    $('#search_device_title').html(deviceID);
    
    $('.datetimepicker').datetimepicker({
        dayOfWeekStart: 1,
        lang: 'en',
        format: 'Y-m-d H:i',
        startDate: '<?php echo date('Y/m/d'); ?>'	//'2015/09/01'
    });
}

</script>

<script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=geometry,places&ext=.js"></script>
<script src="https://cdn.rawgit.com/googlemaps/v3-utility-library/master/markerwithlabel/src/markerwithlabel.js"></script>
<script>
var urlPrefix="http://www.easygaadi.com/";	

var sst = new google.maps.MarkerImage(urlPrefix+"images/markers/car/sst.png",
        new google.maps.Size(32, 32), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));


var map;
var markersArray = [];
var image = 'img/';
var bounds = new google.maps.LatLngBounds();
var loc;
var markers = []; //for hide,show
var urlPrefix="http://www.easygaadi.com/";	
var currenticon = new google.maps.MarkerImage(urlPrefix+"images/markers/current.png",
new google.maps.Size(32, 43), new google.maps.Point(0, 0),
new google.maps.Point(16, 32));
var iw = new google.maps.InfoWindow(); // Global declaration of the infowindow
function init(){
    var mapOptions = { mapTypeId: google.maps.MapTypeId.ROADMAP };
    map =  new google.maps.Map(document.getElementById("googleMapDiv"), mapOptions);
    
    <?php
	$rows = $data['devices'];
for ($i = 0; $i < count($rows); $i++) {
    if ($rows[$i]['lastValidLatitude'] == "" || $rows[$i]['lastValidLongitude'] == "") {
        continue;
    }
    ?>
    loc = new google.maps.LatLng("<?php echo $rows[$i]['lastValidLatitude'];?>","<?php echo $rows[$i]['lastValidLongitude'];?>");
    bounds.extend(loc);
    addMarker("<?php echo $rows[$i]['lastValidHeading'] ?>",loc,"<?php echo $rows[$i]['deviceID'] ?>","<?php echo $rows[$i]['date_time'] ?>","<?php echo round($rows[$i]['lastValidSpeedKPH']) ?>","<?php echo round($rows[$i]['lastOdometerKM']); ?>","<?php echo $rows[$i]['lastValidLatitude'];?>,<?php echo $rows[$i]['lastValidLongitude'];?>" );
<?php }?>
	

	<?php /*if('sstravels'==$_SESSION['account']['accountID']){ ?>
	//sst start
	sstloc = new google.maps.LatLng(17.46148,78.45579);
	var markersst = new MarkerWithLabel({
        position: sstloc,
        map: map,
        draggable: true,
        raiseOnDrag: true,
        labelContent: 'SS Travels',
        labelAnchor: new google.maps.Point(30, 0),
        labelClass: "labels", // the CSS class for the label
        labelInBackground: false,
        //icon: pinSymbol(speed)
		icon: sst
    });

	bounds.extend(sstloc);

	//sst end
	<?php }*/?>

    map.fitBounds(bounds);
    map.panToBounds(bounds);    
}

function addMarker(heading,location, deviceID,date_time,speed,odo,latLng) {          
    
var car=getMapIcon(speed,heading);
//alert(car);
var marker = new MarkerWithLabel({
        position: location,
        map: map,
        draggable: false,
        raiseOnDrag: true,
        labelContent: deviceID,
        labelAnchor: new google.maps.Point(30, 56),
        labelClass: "labels", // the CSS class for the label
        labelInBackground: false,
        //icon: pinSymbol(speed)
		icon: car
    });

		
markers[deviceID]=marker;
  
	
}

function pinSymbol(speed) {
    var color=speed>0?'green':'red';
	return {
        path: 'M 0,0 C -2,-20 -10,-22 -10,-30 A 10,10 0 1,1 10,-30 C 10,-22 2,-20 0,0 z',
        fillColor: color,
        fillOpacity: 1,
        strokeColor: '#000',
        strokeWeight: 1,
        scale: 1
    };
}

function getMapIcon($speed,$heading){
	if($speed>0){
		if($heading>=0 && $heading<25){
			//$pic="h0";
			$pic=new google.maps.MarkerImage(urlPrefix+"images/markers/car/h0.png",
        new google.maps.Size(15, 30), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));

		} else if($heading>=25 && $heading<70){
			$pic="h1";
			$pic= new google.maps.MarkerImage(urlPrefix+"images/markers/car/h1.png",
	new google.maps.Size( 25, 30), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		} else if($heading>=70 && $heading<110){
			//$pic="h2";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h2.png",
	new google.maps.Size(25,30), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));

		} else if($heading>=110 && $heading<160){
			//$pic="h3";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h3.png",
	new google.maps.Size(39,29), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		} else if($heading>=160 && $heading<200){
			//$pic="h4";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h4.png",
	new google.maps.Size(21,41), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		} else if($heading>=200 && $heading<240){
			//$pic="h5";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h5.png",
	new google.maps.Size(39,26), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		} else if($heading>=240 && $heading<290){
			//$pic="h6";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h6.png",
	new google.maps.Size(41,21), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		} else if($heading>=290 && $heading<330){
			//$pic="h7";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h7.png",
	new google.maps.Size(40,28), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		} else if($heading>=330 && $heading<390){
			//$pic="h0";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h0.png",
        new google.maps.Size(15, 30), new google.maps.Point(0, 0),
        new google.maps.Point(16, 32));
		
		}  else if($heading>=390 && $heading<420){
			//$pic="h1";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h1.png",
	new google.maps.Size( 25, 30), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		} else if($heading>=420 && $heading<450){
			//$pic="h2";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h2.png",
	new google.maps.Size(25,30), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		} else if($heading>=450 && $heading<500){
			//$pic="h3";
			$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/h3.png",
	new google.maps.Size(39,29), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
		
		}
	}else{
		//$pic="stopicon";
		$pic = new google.maps.MarkerImage(urlPrefix+"images/markers/car/stop.png",
	new google.maps.Size(39,29), new google.maps.Point(0, 0),
	new google.maps.Point(16, 32));
	}
	return $pic;
}

function fnShowMarkerAddress(d,s,a,totalodo){
	var dis="";
	<?php /*if($_SESSION['account']['accountID']=='sstravels'){ ?>
	var ll=a.split(",");
	//alert(ll[0]);
	//alert(ll[1]);
	var distance=fnDistance(17.46148,78.45579,ll[0],ll[1], 'K');
	dis=". <b>"+parseFloat(distance).toFixed(2)+" KM's away from Office.</b>";
	//alert(dis);	
	<?php }*/?>
	//alert("hello"+a);
	$.ajax({
	type: "GET",
	url: "http://www.easygaadi.com/index.php/site/getGMapContent?latlng=" +a,
	success: function(data) {
			$('#idtruckno').html(d);
			$('#idtruckspeed').html(s+" Km/Hr");
			$('#idtruckaddr').html(data+" "+dis);
			$('#totalodo').html(totalodo);
		}
});
	
}

$(function(){ init(); });
</script>
<script>

function fnGetGroupId(id) {
	
	window.location = 'index.php?route=<?php echo $route; ?>&token=<?php echo $token; ?>&gid='+ id.value;
}


<?php //if($_SESSION['gps_account_id']=='sstravels'){
	if(1){?>
setInterval(function(){ 
$.ajax({
	type: "GET",
	url: 'index.php?route=<?php echo $route; ?>/getajaxgroupmap&token=<?php echo $token; ?>&gid=<?php echo $_GET["gid"]; ?>',
	//data: "addr="+encodeURI("{{ company.getAddress }}, {{ company.getZipCode }} {{ company.getCity }}"),
	dataType:"json",
	success: function(data) {
			//alert(data)
			var tr;
			var speedAlarm=false;
			var topSpeed=70;//<?php //echo $_SESSION['account']['overSpeedLimit'];?>;
			$.each(data['devices'],function(k,d){
            //alert(d['lastGPSTimestamp']);
				if(topSpeed<d['lastValidSpeedKPH']){ speedAlarm=true;}	
				markers[d['deviceID']].setMap(null);
				var loc=new google.maps.LatLng(d['lastValidLatitude'],d['lastValidLongitude']);
				addMarker(d['lastValidHeading'],loc, d['deviceID'],d['date_time'],d['lastValidSpeedKPH'],d['lastOdometerKM'],d['lastValidLatitude']+","+d['lastValidLongitude']);
				//alert(d['tr']);
				tr+=d['tr'];
			});
			if(speedAlarm==true &&  $('#overspeedalarm').prop('checked')==false){
				audioElement.play();
			}
			$('#requests tbody').html("");
			$('#requests tbody').append(tr);
		}
});
	}, 60000);

<?php } ?>

function fnShowMarker(d){
	//alert(d);
	map.setCenter(markers[d].getPosition());
	map.setZoom(22);
	//audioElement.play();
}


 function fnDistance(lat1, lon1, lat2, lon2, unit) {
	var radlat1 = Math.PI * lat1/180
	var radlat2 = Math.PI * lat2/180
	var theta = lon1-lon2
	var radtheta = Math.PI * theta/180
	var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
	dist = Math.acos(dist)
	dist = dist * 180/Math.PI
	dist = dist * 60 * 1.1515
	if (unit=="K") { dist = dist * 1.609344 }
	if (unit=="N") { dist = dist * 0.8684 }
	return dist
}


    var audioElement = document.createElement('audio');
    audioElement.setAttribute('src', 'http://www.soundjay.com/misc/sounds/bell-ringing-01.mp3');
    
    audioElement.addEventListener('ended', function() {
        this.play();
    }, false);

	$('#overspeedalarm').on('change',function(){
	var yes=$('#overspeedalarm').prop('checked');
	if(yes){
		//audioElement.play();
		audioElement.pause();
	}
})

   //end audio

</script>
<script>
  var videoElement = document.getElementById("googleMapDiv");
    
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