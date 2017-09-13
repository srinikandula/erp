<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalSearchFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Filter<div style="float:right;padding:0px 2px 2px; 10px"><button type="button" class="btn btn-info btn-xs" onclick="fnDownload()"><i class="fa fa-download" aria-hidden="true"></i> Download</button> <!-- <button type="button" class="btn btn-info btn-xs"><i class="fa fa-print" aria-hidden="true"></i> Print</button> --></div></legend>
	<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-6">Truck No :</label>
    <div class="col-md-6">
        <select name="filter_id_truck" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Tuck" id="field_id_truck"  data-original-title="Truck" >
        <option value="">All Trucks</option>
	<?php foreach($trucks as $truck){
		$out=$truck['own']==0?"(Out)":"";
		echo '<option value="'.$truck['id_truck'].'">'.$truck['truckno'].$out.'</option>';
	}?>
        </select>
    </div>
</div>
        
<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-6">Factory :</label>
    <div class="col-md-6">
        <select name="filter_id_factory" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Factory" id="field_id_factory"  data-original-title="Factory" >
        <option value="">All Factories</option>    
        <?php foreach($factories as $row){
            echo '<option value="'.$row['id_factory'].'">'.$row['factoryname'].'</option>';
        }?>
        </select>
    </div>
</div>

<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-7">Own Truck</label>
    <div class="col-md-5">
        <select name="filter_own" class="form-control"  title="Own" id="field_own" >
        <option value="">All</option>    
	<option value="1">Own Truck</option>    
	<option value="0">Out Truck</option>    
        </select>
    </div>
</div>

<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-8">POD Received</label>
    <div class="col-md-4">
        <!-- <input type="checkbox" name="filter_ispodreceived" class="form-control"  title="POD Received" id="field_ispodreceived" > -->
	<select name="filter_ispodreceived" class="form-control"  title="POD Received" id="field_ispodreceived" >
        <option value="">All</option>    
	<option value="1">Yes</option>    
	<option value="0">No</option>    
        </select>
    </div>
</div>

<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-8">POD Submitted</label>
    <div class="col-md-4">
        <!-- <input type="checkbox" name="filter_ispodsubmitted" class="form-control"  title="POD Submitted" id="field_ispodsubmitted" > -->
	<select name="filter_ispodsubmitted" class="form-control"  title="POD Submitted" id="field_ispodsubmitted" >
        <option value="">All</option>    
	<option value="1">Yes</option>    
	<option value="0">No</option>    
        </select>
    </div>
</div>

<div class="form-group col-md-2 required">
	<label for="accountID" class="col-md-6">Fr Date :</label>
	<div class="col-md-6">
		<input name="filter_fromdate" class="form-control" placeholder="Fr Date" data-toggle="tooltip" data-placement="auto top" title="Fr Date" id="field_fromdate" value="" type="text">
	</div>
</div>
<div class="form-group col-md-2 required">
	<label for="accountID" class="col-md-6">To Date :</label>
	<div class="col-md-6">
		<input name="filter_todate" class="form-control" placeholder="To Date" data-toggle="tooltip" data-placement="auto top" title="To Date" id="field_todate" value="" type="text">
	</div>
</div>

	<input id="submitFilter" class="sbmt-btn btn-xs" type="submit" name="submit" value="Submit" >
	</fieldset>
    </form>
</div>
</div>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>    
<script>
$(function() {
	$("#field_dateattached, #field_fromdate, #field_todate").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>
<script>
$("#submitFilter").on("click", function(e) {
	e.preventDefault();
	var data = $('form#horizontalSearchFormFilter').serialize();
	getList('index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>&' + data);
});

function fnDownload(){
	location.href='index.php?route=reports/factorypod/download&token=<?php echo $_GET["token"];?>&'+$('form#horizontalSearchFormFilter').serialize();
}
</script>