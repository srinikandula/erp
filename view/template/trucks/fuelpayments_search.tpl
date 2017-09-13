<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalSearchFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Make Payment</legend>
	<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-6">Filling Station<span class="mandatory">*</span> :</label>
    <div class="col-md-6">
        <select name="filter_id_fuel_station" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Fuel Station" id="filter_id_fuel_station"  data-original-title="Fuel Station" >
        <option value="">Select Fuel Station</option>
	<?php foreach($fuelstations as $fuelstation){
		echo '<option value="'.$fuelstation['id_fuel_station'].'">'.$fuelstation['fuelstationname'].'</option>';
	}?>
        </select>
    </div>
</div>
<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Qty<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <input name="field[qty]" class="form-control" placeholder="Qty" data-toggle="tooltip" data-placement="auto top" title="" id="field_qty"  data-original-title="Qty" type="text" readonly>
	<input type="hidden" name="field_trips" id="field_trips" >
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Amount<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <input name="field[amount]" class="form-control" placeholder="Amount" data-toggle="tooltip" data-placement="auto top" title="" id="field_amount"  data-original-title="Amount" type="text" readonly>
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Branch<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <select name="field[id_branch]" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Branch" id="field_id_branch"  data-original-title="Branch" >
        <?php foreach($branches as $branche){
            $hq=$branche['isheadoffice']?"(HQ)":"";
            echo '<option value="'.$branche['id_branch'].'">'.$branche['branchcity'].'-'.$branche['branchcode'].$hq.'</option>';
        }?>
        </select>
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-6">Payment Mode<span class="mandatory">*</span> :</label>
    <div class="col-md-6">
        <select name="field[payment_mode]" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Branch" id="field_payment_mode"  data-original-title="Pament Mode" >
	<option value="">Select</option>
        <?php foreach(getPaymentMode() as $k=>$v){
            echo '<option value="'.$k.'">'.$v.'</option>';
        }?>
        </select>
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-5">Payment Ref :</label>
    <div class="col-md-7">
        <input name="field[paymentref]" class="form-control" placeholder="Payment Ref" title="Payment Ref" id="field_paymentref" type="text">
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Paid On<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <input name="field[paidon]" class="form-control" placeholder="Paid On" data-toggle="tooltip" data-placement="auto top" title="Paid On" id="field_paidon"  data-original-title="Paid On" type="text">
    </div>
</div>
	<!-- <select class="search-input" type="text" name="field[id_fuel_station]" id="field_id_fuel_station">
	<option value="">Select Fuel Station</option>
	<?php foreach($fuelstations as $fuelstation){
		echo '<option value="'.$fuelstation['id_fuel_station'].'">'.$fuelstation['fuelstationname'].'</option>';
	}?>
	</select>
	<input class="search-input" type="text" name="filter_materialcode" placeholder="Material Code"> -->
<div class="form-group col-md-3">
	<input id="submitFilter" class="sbmt-btn" type="submit" name="submit" value="Submit" onclick="fnSubmit('add');                         return false;">
</div>
	</fieldset>
    </form>
</div>
</div>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>    
<script>
$(function() {
	$("#field_paidon").datepicker({dateFormat: 'yy-mm-dd'});
});


/*$("#submitFilter").on("click", function(e) {
	e.preventDefault();
	var data = $('form#horizontalFormFilter').serialize();
	getList('index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>&' + data);
});*/

$('#filter_id_fuel_station').on("change",function(e){
	e.preventDefault();
	var data = $('form#horizontalSearchFormFilter').serialize();
	//alert(data);
	getList('index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>&' + data);
});

</script>