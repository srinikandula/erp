<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th ><!-- <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /> --></th>
            <th >S.No</th>
            <th >Trip ID</th>
	    <th >Truck No</th>
	    <th >Route</th>
	    <!-- <th >Material</th> -->
            <th >Booking Type</th>
            <th >Trans On</th>
            <th >Dispatch On</th>
            <th >Qty</th>
            <th >Truck Rate</th>
            <th >Freight</th>
            <th >Shortage</th>
            <th >Damage</th>
	    <th >LCharge</th>
	    <th >ULCharge</th>
	    <th >Wait Charge</th>
	    <th >Ext Unloading Charge</th>
            <th >Advance</th>
	    <th >POD Amount</th>
            <th >POD Submit</th>
            <th >POD Receive</th>
            <th >PaymentID</th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {
		    $icon[0]='<i class="fa fa-times" aria-hidden="true"></i>';
		    $icon[1]='<i class="fa fa-check" aria-hidden="true"></i>';
                    $getTruckPayTypes=getTruckPayTypes();
		    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>" <?php if($item['id_truck_payment']){ echo 'class="success"';}?> >
                <td><?php 
	if(!$item['id_truck_payment']){		
		if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } 
	}
	?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_id_trip_<?php echo $item['id']; ?>"><?php echo $item['id_trip']; ?></td>
		    <td id="list_truckno_<?php echo $item['id']; ?>"><?php echo $item['truckno']; ?></td>
                    <td id="list_fromplace_<?php echo $item['id']; ?>"><?php echo $item['fromplace'].' '.$item['toplace']; ?></td>
		    <!-- <td id="list_material_<?php echo $item['id']; ?>"><?php echo $item['material']; ?></td> -->
                    <td id="list_transtype_<?php echo $item['id']; ?>"><?php echo $getTruckPayTypes[$item['transtype']]; ?></td>
		    <td id="list_transactiondate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])); ?></td>
		    <td id="list_dispatchdate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['dispatchdate'])); ?>
		    <span id="hidden_row_data_<?php echo $item['id']; ?>" data-fulltext='<?php echo json_encode($item); ?>' ></span></td>
                    <td id="list_qty_<?php echo $item['id']; ?>"><?php echo $item['qty']; ?></td>
                    <td id="list_truckrate_<?php echo $item['id']; ?>"><?php echo $item['truckrate']; ?></td>
                    <td id="list_freight_<?php echo $item['id']; ?>"><?php echo $item['truckrate']*$item['qty']; ?></td>
                    <td id="list_shortage_<?php echo $item['id']; ?>"><?php echo $item['shortage']; ?></td>
                    <td id="list_damage_<?php echo $item['id']; ?>"><?php echo $item['damage']; ?></td>
		    <td id="list_loadingexp_<?php echo $item['id']; ?>"><?php echo $item['loadingexp']; ?></td>
		    <td id="list_unloadingexp_<?php echo $item['id']; ?>"><?php echo $item['unloadingexp']; ?></td>
		    <td id="list_wait_charges_<?php echo $item['id']; ?>"><?php echo $item['wait_charges']; ?></td>
		    <td id="list_ext_unload_charges_<?php echo $item['id']; ?>"><?php echo $item['ext_unload_charges']; ?></td>
                    <td id="list_driveradvance_<?php echo $item['id']; ?>"><?php echo $item['driveradvance']; ?></td>
                    <td id="list_podamount_<?php echo $item['id']; ?>"><?php echo ($item['truckrate']*$item['qty'])-($item['shortage']+$item['damage']+$item['loadingexp']+$item['unloadingexp']+$item['driveradvance']); ?></td>
		    <td id="list_ispodreceived_<?php echo $item['id']; ?>"><?php echo $icon[$item['ispodreceived']]; ?></td>
                    <td id="list_ispodsubmitted_<?php echo $item['id']; ?>"><?php echo $icon[$item['ispodsubmitted']]; ?></td>
                    <td id="list_id_truck_payment_<?php echo $item['id']; ?>"><?php if($item['id_truck_payment']){ echo '<button type="button" class="btn btn-sm btn-primary" onclick="fnTruckPayment('.$item['id_truck_payment'].')" >'.$item['id_truck_payment'].'</button>';} ?></td>
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
	var nooftrips=0;
	var amount=0;
	var trips="";
	var prefix="";
	$('input:checked').each(function() {
		//alert($(this).attr('value'));
		checkVal=$(this).attr('value');
		trips=trips+prefix+checkVal;
		prefix=",";
		jsn=JSON.parse($('#hidden_row_data_'+checkVal).attr('data-fulltext'));
		//alert(jsn['qty']);alert(jsn['priceperltr']);alert(jsn['amount']);
		nooftrips+=1;
                //alert(jsn['truckrate']+" * "+jsn['qty']+" "+jsn['shortage']+" "+jsn['damage']+" "+jsn['driveradvance']);
		amount+=(parseFloat(jsn['ext_unload_charges'])+parseFloat(jsn['wait_charges']))+(parseFloat(jsn['truckrate'])*parseFloat(jsn['qty']))-(parseFloat(jsn['driveradvance'])+parseFloat(jsn['shortage'])+parseFloat(jsn['damage'])+parseFloat(jsn['loadingexp'])+parseFloat(jsn['unloadingexp']));
	});
        //alert(amount)
	$('#field_nooftrips').val(nooftrips);
	$('#field_totalpayableamount').val(amount);
	$('#field_trips').val(trips);
});
</script>