<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalSearchFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Receive Payment  <div style="float:right;padding:0px 2px 2px; 10px"><span class="btn-success btn-xs">Payment Closed</span></div></legend>
	<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-6">Out Trucks<span class="mandatory">*</span> :</label>
    <div class="col-md-6">
        <select name="filter_id_truck" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Tuck" id="filter_id_truck"  data-original-title="Truck" >
        <option value="">Select Truck</option>
	<?php foreach($trucks as $truck){
		echo '<option value="'.$truck['id_truck'].'">'.$truck['truckno']." - ".$truck['contactname']." - ".$truck['contactmobile'].'</option>';
	}?>
        </select>
    </div>
</div>
<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Trips<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <input name="field[nooftrips]" class="form-control" placeholder="Trips" data-toggle="tooltip" data-placement="auto top" title="" id="field_nooftrips"  data-original-title="Trips" type="text" readonly>
	<input type="hidden" name="field_trips" id="field_trips" >
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Amount<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <input name="field[totalpayableamount]" class="form-control" placeholder="Amount" data-toggle="tooltip" data-placement="auto top" title="" id="field_totalpayableamount"  data-original-title="Amount" type="text">
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
        <select name="field[paymentmode]" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Payment Mode" id="field_paymentmode"  data-original-title="Pament Mode" >
	<option value="">Select</option>
        <?php foreach(getPaymentMode() as $k=>$v){
            echo '<option value="'.$k.'">'.$v.'</option>';
        }?>
        </select>
        <input name="field[chequeno]" class="form-control" placeholder="Cheque No" data-toggle="tooltip" data-placement="auto top" title="Cheque No" id="field_chequeno" data-original-title="Cheque No" type="text" style='display:none'>
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-5">Payment Ref :</label>
    <div class="col-md-7">
        <input name="field[paymentref]" class="form-control" placeholder="Payment Ref" data-toggle="tooltip" data-placement="auto top" title="Payment Ref" id="field_paymentref"  data-original-title="Payment Ref" type="text">
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Paid On<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <input name="field[paidon]" class="form-control" placeholder="Paid On" data-toggle="tooltip" data-placement="auto top" title="Paid On" id="field_paidon"  data-original-title="paid On" type="text">
    </div>
</div>

	<!-- <select class="search-input" type="text" name="field[id_fuel_station]" id="field_id_fuel_station">
	<option value="">Select Fuel Station</option>
	<?php foreach($fuelstations as $fuelstation){
		echo '<option value="'.$fuelstation['id_fuel_station'].'">'.$fuelstation['fuelstationname'].'</option>';
	}?>
	</select>
	<input class="search-input" type="text" name="filter_materialcode" placeholder="Material Code"> -->
	<input id="submitFilter" class="sbmt-btn" type="submit" name="submit" value="Submit" onclick="fnSubmit('add');                         return false;">
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

$('#filter_id_truck').on("change",function(e){
	e.preventDefault();
	var data = $('form#horizontalSearchFormFilter').serialize();
	//alert(data);
	getList('index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>&' + data);
});

$('#field_paymentmode').on("change",function(e){
    if($(this).val()=='CQ'){
        $('#field_chequeno').show();
    }else{
        $('#field_chequeno').hide();
    }
});

</script>