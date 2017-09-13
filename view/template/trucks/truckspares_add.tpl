<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalAddFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Attache Item</legend>
	<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Truck No<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <select name="field[id_truck]" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Tuck" id="field_id_truck"  data-original-title="Truck" >
        <option value="">Select Truck</option>
	<?php foreach($trucks as $truck){
		echo '<option value="'.$truck['id_truck'].'">'.$truck['truckno'].'</option>';
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

<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Item<span class="mandatory">*</span> :</label>
    <div class="col-md-8">
        <select name="field[id_store_item]" class="form-control"  data-toggle="tooltip" data-placement="auto top" title="Item" id="field_id_store_item"  data-original-title="Item" >
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

<?php getInputText(array("col"=>"refno","title"=>"Refno","required"=>0,"mainDivClass"=>"form-group col-md-3"));
getInputText(array("divClass"=>"col-md-8 position","col"=>"position","title"=>"Position","required"=>0,"mainDivClass"=>"form-group col-md-3"));
getInputText(array("col"=>"dateattached","title"=>"Date Inst","required"=>1,"mainDivClass"=>"form-group col-md-3"));
getInputText(array("col"=>"cmr","title"=>"CMR","required"=>1,"mainDivClass"=>"form-group col-md-3"));
getInputTextArea(array("col"=>"comment","title"=>"Comment","required"=>0,"mainDivClass"=>"form-group col-md-3","rows"=>2,"cols"=>20));
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

$('#field_id_store_item').on('change',function(){
	var label=$('#field_id_store_item :selected').parent().attr('label');
	//alert(label);
	if(label=='TY'){
	$('.position').html('<select name="field[position]" class="form-control"  title="Position" id="field_position"><option value="">Select Tyre Position</option><optgroup label="Left"><option value="L1">L1</option><option value="L21">L21</option><option value="L22">L22</option><option value="L31">L31</option><option value="L32">L32</option><option value="L41">L41</option><option value="L42">L42</option><option value="L51">L51</option><option value="L52">L52</option></optgroup><optgroup label="Right"><option value="R1">R1</option><option value="R21">R21</option><option value="R22">R22</option><option value="R31">R31</option><option value="R32">R32</option><option value="R41">R41</option><option value="R42">R42</option><option value="R51">R51</option><option value="R52">R52</option></optgroup></select>');
	}else{
	$('.position').html('<input name="field[position]" class="form-control" placeholder="Position"  title="Position" id="field_position" type="text">');
	}
});
</script>