<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Filter <div style="float:right;padding:0px 2px 2px; 10px"><span class="btn-success btn-xs">Bills Closed</span>  <span class="btn-danger btn-xs">Bills Over Due</span></div></legend>
<div class="form-group col-md-3">
    <label for="accountID" class="col-md-4">Factories :</label>
    <div class="col-md-8">
        <select name="filter_id_factory" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Tuck" id="filter_id_factory"  data-original-title="Truck" >
        <option value="">Select Factory</option>
	<?php foreach($factories as $row){
		echo '<option value="'.$row['id_factory'].'">'.$row['factoryname']." - ".$row['factorycode'].'</option>';
	}?>
        </select>
    </div>
</div>

<div class="form-group col-md-3">
    <label for="accountID" class="col-md-6">Bills Raised :</label>
    <div class="col-md-6">
        <input name="filter_bills_raised" class="form-control" placeholder="Bills Raised" data-toggle="tooltip" data-placement="auto top" title="" id="filter_bills_raised"  data-original-title="Bills Raised" type="checkbox">
    </div>
</div>

<div class="form-group col-md-2">
    <label for="accountID" class="col-md-9">Bills Over Due :</label>
    <div class="col-md-3">
        <input name="filter_over_due" class="form-control" placeholder="Bills Over Due" data-toggle="tooltip" data-placement="auto top" title="" id="filter_over_due"  data-original-title="Bills Over Due" type="checkbox">
    </div>
</div>

<div class="form-group col-md-2">
    <label for="accountID" class="col-md-8">Bills Closed :</label>
    <div class="col-md-4">
        <input name="filter_closed" class="form-control" placeholder="Bills Closed" data-toggle="tooltip" data-placement="auto top" title="" id="filter_closed"  data-original-title="Bills Closed" type="checkbox">
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