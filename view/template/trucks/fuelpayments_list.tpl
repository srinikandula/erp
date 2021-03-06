<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th ><!-- <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /> --></th>
            <th >S.No</th>
            <th >Trip ID</th>
	    <th>Route</th>
	    <th>Truck No</th>
	    <th>Driver Name</th>
	    <th>Driver No</th>
            <th>Transc Date</th>
	    <th>Dispatch Date</th>
	    <th >
		Fuel Station Name
            </th>
	    <th >
		Qty            </th>
	    <th >
		Price Per Liter
            </th>
	    <th >
		Amount
            </th>
	    <th >
		Payment ID
            </th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
                    foreach ($items as $k => $item) { 
		    $trClassClosed=$item['id_fuel_station_payment']?"class='success'":"";
		    ?>
            <tr id="list_<?php echo $item['id']; ?>" <?php echo $trClassClosed;?> >
                <td><?php 
	if(!$item['id_fuel_station_payment']){		
		if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } 
	}
	?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_id_trip_<?php echo $item['id']; ?>"><?php echo $item['id_trip']; ?></td>
		    <td id="list_operatingroutecode_<?php echo $item['id']; ?>"><?php echo $item['operatingroutecode']; ?></td>
		    
			<td id="list_truckno_<?php echo $item['id']; ?>"><?php echo $item['truckno']; ?></td>
			<td id="list_drivername_<?php echo $item['id']; ?>"><?php echo $item['drivername']; ?></td>
			<td id="list_drivermobile_<?php echo $item['id']; ?>"><?php echo $item['drivermobile']; ?></td>
			<td id="list_transactiondate_<?php echo $item['id']; ?>"><?php echo $item['transactiondate']; ?></td>
			<td id="list_dispatchdate_<?php echo $item['id']; ?>"><?php echo $item['dispatchdate']; ?></td>

		    <td id="list_id_fuel_station_<?php echo $item['id']; ?>"><?php echo $item['fuelstation']==""?$item['fuelstationname']:$item['fuelstation']; ?></td>
                    <td id="list_qty_<?php echo $item['id']; ?>"><?php echo $item['qty']; ?></td>
		    <td id="list_priceperltr_<?php echo $item['id']; ?>"><?php echo $item['priceperltr']; ?></td>
		    <td id="list_amount_<?php echo $item['id']; ?>"><?php echo $item['amount']; ?></td>
		    <td id="list_id_fuel_station_payment_<?php echo $item['id']; ?>"><?php if($item['id_fuel_station_payment']){ echo '<button type="button" class="btn btn-sm btn-primary" onclick="fnTrPayment('.$item['id_fuel_station_payment'].')" >'.$item['id_fuel_station_payment'].'</button>';} ?>
		    <input type="hidden" name="hidden_row_data_name" id="hidden_row_data_<?php echo $item['id']; ?>" value='<?php echo json_encode($item);?>'>
		    </td>
                    <!-- <td><i class="fa fa-fw fa-edit <?php echo $editPermClass; ?>" onclick='fnEdit(<?php echo json_encode($item); ?>);'></i></td> -->
                </tr>
        <?php } ?>
        <?php } else { ?>
            <tr>
                <td class="text-center" colspan="8">No Data Available</td>
            </tr>
        <?php } ?>
    </tbody>
</table>
<?php include(DIR_TEMPLATE.'common/_pagination.tpl');?>
<script>
function fnEdit(str) {
	$('#field_material').val(str.material);
	$('#field_materialcode').val(str.materialcode);
	$('#pkey').val(str.id);
}

$("input[type='checkbox']").on("click",function(){
	//alert("hello");
	var checkVal={};
	var jsn={};
	var qty=0;
	var amount=0;
	var trips="";
	var prefix="";
	$('input:checked').each(function() {
		//alert($(this).attr('value'));
		checkVal=$(this).attr('value');
		trips=trips+prefix+checkVal;
		prefix=",";
		jsn=JSON.parse($('#hidden_row_data_'+checkVal).val());
		//alert(jsn['qty']);alert(jsn['priceperltr']);alert(jsn['amount']);
		qty+=parseFloat(jsn['qty']);
		amount+=parseFloat(jsn['amount']);
	});
	$('#field_qty').val(qty);
	$('#field_amount').val(amount);
	$('#field_trips').val(trips);
});
</script>