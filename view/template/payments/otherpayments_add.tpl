<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalAddFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Other Payments</legend>
<?php 
getInputTextArea(array("divClass"=>"col-md-7","labelClass"=>"col-md-5","col"=>"particulars","title"=>"Particulars","required"=>1,"mainDivClass"=>"form-group col-md-3"));
getInputTextArea(array("divClass"=>"col-md-7","labelClass"=>"col-md-5","col"=>"narration","title"=>"Narration","required"=>1,"mainDivClass"=>"form-group col-md-3"));
getInputText(array("divClass"=>"col-md-7","labelClass"=>"col-md-5","col"=>"transactiondate","title"=>"Trans Date","required"=>1,"mainDivClass"=>"form-group col-md-3"));
?>
<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-5">Trans Type<span class="mandatory">*</span> :</label>
    <div class="col-md-7">
        <select name="field[transactiontype]" class="form-control"  title="Payment Mode" id="field_transactiontype">
        <?php foreach(getTransactionTypes() as $k=>$v){
		echo '<option value="'.$k.'">'.$v.'</option>';
	}?>
        </select>
    </div>
</div>

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-6">Payment Mode<span class="mandatory">*</span> :</label>
    <div class="col-md-6">
        <select name="field[paymentmode]" class="form-control"  title="Payment Mode" id="field_paymentmode">
        <?php foreach(getPaymentMode() as $k=>$v){
		echo '<option value="'.$k.'">'.$v.'</option>';
	}?>
        </select>
    </div>
</div>
        
<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Branch<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <select name="field[id_branch]" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Branch" id="field_id_branch"  data-original-title="Branch" >
        <option value="">Select Store Branch</option>    
        <?php foreach($branches as $branche){
            $hq=$branche['isheadoffice']?"(HQ)":"";
            echo '<option value="'.$branche['id_branch'].'">'.$branche['branchcity'].'-'.$branche['branchcode'].$hq.'</option>';
        }?>
        </select>
    </div>
</div>



<?php 
getInputText(array("divClass"=>"col-md-6","labelClass"=>"col-md-6","col"=>"paymentref","title"=>"Payment Ref","required"=>0,"mainDivClass"=>"form-group col-md-3"));
getInputText(array("col"=>"amount","title"=>"Amount","required"=>1,"mainDivClass"=>"form-group col-md-3"));
?>
	<!-- <select class="search-input" type="text" name="field[id_fuel_station]" id="field_id_fuel_station">
	<option value="">Select Fuel Station</option>
	<?php foreach($fuelstations as $fuelstation){
		echo '<option value="'.$fuelstation['id_fuel_station'].'">'.$fuelstation['fuelstationname'].'</option>';
	}?>
	</select>
	<input class="search-input" type="text" name="filter_materialcode" placeholder="Material Code"> -->
	<input id="submitAdd" class="sbmt-btn" type="submit" name="submit" value="Submit" onclick="fnSubmit('add');                         return false;">
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