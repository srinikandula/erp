<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
    <title>PHP AJAX Calendar</title>

    <!-- add styles and scripts -->
    <link href="http://www.easygaadi.com/erp/view/calendar/css/styles.css" rel="stylesheet" type="text/css" />
    <!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js"></script> -->
</head>
<body>
    <div id="calendar">
        __calendar__
    </div>
</body>
<script>
function setDate(dt){
	var id_driver=$("#pkey").val();
	$.ajax({
	url: 'index.php?route=drivers/drivers/addleave&token=<?php echo $_GET[token]; ?>',
	type: 'post',
	data: 'leavedate='+dt+'&id_driver='+id_driver,
	dataType: 'json',
	beforeSend: function() {
	  },
	complete: function() {
	  },
	success: function(json) {
		if (json['status']) {
			json['add']==1?$('#'+dt).css('border','solid 3px green'):$('#'+dt).css('border','');
		}
	},
	error: function(xhr, ajaxOptions, thrownError) {
		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	}
});
}
</script>
</html>