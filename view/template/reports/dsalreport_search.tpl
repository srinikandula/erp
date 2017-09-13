<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalSearchFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Filter<div style="float:right;padding:0px 2px 2px; 10px"><button type="button" class="btn btn-info btn-xs" onclick="fnDownload()"><i class="fa fa-download" aria-hidden="true"></i> Download</button> <!-- <button type="button" class="btn btn-info btn-xs"><i class="fa fa-print" aria-hidden="true"></i> Print</button> --></div></legend>
	<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-5">Driver :</label>
    <div class="col-md-7">
        <select name="filter_id_driver" class="form-control"   title="Driver" id="field_id_driver"   >
        <option value="">Select</option>
	<?php foreach($drivers as $row){
		echo '<option value="'.$row['id_driver'].'">'.$row['drivername'].'</option>';
	}?>
        </select>
    </div>
</div>
        
<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-6">Branch :</label>
    <div class="col-md-6">
        <select name="filter_id_branch" class="form-control" title="Branch" id="field_id_branch" >
        <option value="">Select</option>    
        <?php foreach($branches as $row){
            echo '<option value="'.$row['id_branch'].'">'.$row['branchcity'].'</option>';
        }?>
        </select>
    </div>
</div>

<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-8">Closed</label>
    <div class="col-md-4">
        <input type="checkbox" name="filter_closed" class="form-control"  title="Closed" id="field_closed" >
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
	//alert('index.php?route=reports/dsalreport/download&token=<?php echo $_GET["token"];?>&'+$('form#horizontalSearchFormFilter').serialize());
	//$("#route").val('reports/dsalreport/download');
	location.href='index.php?route=reports/dsalreport/download&token=<?php echo $_GET["token"];?>&'+$('form#horizontalSearchFormFilter').serialize();
}
</script>