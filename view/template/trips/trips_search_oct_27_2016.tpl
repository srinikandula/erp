<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Filter <div style="float:right;padding:0px 2px 2px; 10px"><span class="btn-success btn-xs">Factory Payment Closed</span> <span class="btn-warning btn-xs">TR Pending Bill</span> <span class="btn-danger btn-xs">O/S Trips</span></div></legend>
<div class="form-group col-md-3">
    <label for="accountID" class="col-md-6">Transporters :</label>
    <div class="col-md-6">
        <select name="filter_id_transporter" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Transporter" id="filter_id_transporter"  data-original-title="Transporter" >
        <option value="">Select Transporter</option>
	<?php foreach($transporters as $row){
		echo '<option value="'.$row['id_transporter'].'">'.$row['transporter']." - ".$row['transportercode'].'</option>';
	}?>
        </select>
    </div>
</div>

<div class="form-group col-md-2">
    <label for="accountID" class="col-md-6">Drivers :</label>
    <div class="col-md-6">
        <select name="filter_id_driver" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Driver" id="filter_id_driver"  data-original-title="Driver" >
        <option value="">Select Driver</option>
	<?php foreach($drivers as $row){
		echo '<option value="'.$row['id_driver'].'">'.$row['drivername']." - ".$row['drivercode'].'</option>';
	}?>
        </select>
    </div>
</div>

<div class="form-group col-md-3">
    <label for="accountID" class="col-md-6">Factories :</label>
    <div class="col-md-6">
        <select name="filter_id_factory" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Tuck" id="filter_id_factory"  data-original-title="Truck" >
        <option value="">Select Factory</option>
	<?php foreach($factories as $row){
		echo '<option value="'.$row['id_factory'].'">'.$row['factoryname']." - ".$row['factorycode'].'</option>';
	}?>
        </select>
    </div>
</div>

<div class="form-group col-md-2">
    <label for="accountID" class="col-md-10">Factory O/S Trips :</label>
    <div class="col-md-2">
        <input name="filter_factory_os" class="form-control" placeholder="Factory O/S Trips" data-toggle="tooltip" data-placement="auto top" title="" id="filter_factory_os"  data-original-title="Factory O/S Trips" type="checkbox">
    </div>
</div>

<div class="form-group col-md-2">
    <input id="submitFilter" class="sbmt-btn" type="submit" name="search" value="Search">
</div>

	</fieldset>
    </form>
</div>
</div>
<script>
$("#submitFilter").on("click", function(e) {
	e.preventDefault();
	var data = $('form#horizontalFormFilter').serialize();
	getList('index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>&' + data);
});
</script>