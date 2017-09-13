<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalSearchFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Filter</legend>
	<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Truck No :</label>
    <div class="col-md-8">
        <select name="filter_id_truck" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Tuck" id="field_id_truck"  data-original-title="Truck" >
        <option value="">Select Truck</option>
	<?php foreach($trucks as $truck){
		echo '<option value="'.$truck['id_truck'].'">'.$truck['truckno'].'</option>';
	}?>
        </select>
    </div>
</div>
        
<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Branch :</label>
    <div class="col-md-8">
        <select name="filter_id_branch" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Branch" id="field_id_branch"  data-original-title="Branch" >
        <option value="">Select Store Branch</option>    
        <?php foreach($branches as $branche){
            $hq=$branche['isheadoffice']?"(HQ)":"";
            echo '<option value="'.$branche['id_branch'].'">'.$branche['branchcity'].'-'.$branche['branchcode'].$hq.'</option>';
        }?>
        </select>
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Item :</label>
    <div class="col-md-8">
        <select name="filter_id_store_item" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Item" id="field_id_store_item"  data-original-title="Item" >
        <option value="">Select Item</option>
	<?php foreach($storeItems as $k=>$array){
                echo '<optgroup label="'.$k.'">';
                foreach($array as $data){
                    echo '<option value="'.$data['id_store_item'].'">'.$data['itemname']." - ".$data['make'].'</option>';
                }
                echo '</optgroup>';
	}?>
        </select>
    </div>
</div>

<div class="form-group col-md-3 required">
	<label for="accountID" class="col-md-4">Fr Date :</label>
	<div class="col-md-8">
		<input name="filter_fromdate" class="form-control" placeholder="Fr Date" data-toggle="tooltip" data-placement="auto top" title="Fr Date" id="field_fromdate" value="" type="text">
	</div>
</div>
<div class="form-group col-md-3 required">
	<label for="accountID" class="col-md-4">To Date :</label>
	<div class="col-md-8">
		<input name="filter_todate" class="form-control" placeholder="To Date" data-toggle="tooltip" data-placement="auto top" title="To Date" id="field_todate" value="" type="text">
	</div>
</div>

	<input id="submitFilter" class="sbmt-btn" type="submit" name="submit" value="Submit" >
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
</script>