<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th>S.No</th>
	    <th>Trip ID</th>
            <th>From-To</th>
	    <th>OnWards</th>
	    <th>Material</th>
	    <th>Freight</th>
	    <th>Transc Date</th>
	    <th>Dispatch Date</th>
	    <th>Truck No</th>
	    <th>Own</th>
	    <th>Booked To</th>
	    <th>Company</th>
	    <th>Driver</th>
	    <th>Driver ADV</th>
	    <!-- <th>Date Created</th> -->
      	    <th></th>
	  </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
		    $own[1]='<i class="fa fa-check" aria-hidden="true"></i>';
		    $own[0]='<i class="fa fa-times" aria-hidden="true"></i>';
                    foreach ($items as $k => $item) {  
		    $freight=$item['loadprovider']=='TR'?$item['truckrate']*$item['qty']:$item['billrate']*$item['qty'];
		    $trBillClass=($item['loadprovider']=='TR' && $item['ispodsubmitted'] && !$item['id_transporter_payment'])?'class="warning"':'';
		    $ftidClass= ($item['totalreceivableamount'] && $item['paidamount']) && ($item['totalreceivableamount']==$item['paidamount'])?'class="success"':'';//factory payment balance closed
		    
		    $trClass="";   if($item['id_factory'] && !$item['id_factory_payment']){ 
		    $trClass=strtotime(date('Y-m-d', strtotime($item['transactiondate']. $item['paymentcycle'].'  day')))<strtotime('now')?'class="danger"':"";}  ?>
            <tr id="list_<?php echo $item['id']; ?>" <?php echo $trClass;?> > 
                <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } ?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
		    <td id="list_id_trip_<?php echo $item['id']; ?>" <?php echo $ftidClass;?> ><?php echo $item['id_trip']; ?></td>
                    <td id="list_fromplace_<?php echo $item['id']; ?>"><?php echo $item['fromplace']."-".$item['toplace']; ?></td>
		    <td id="list_traveltype_<?php echo $item['id']; ?>"><?php echo $own[$item['traveltype']]; ?></td>
		    <td id="list_material_<?php echo $item['id']; ?>"><?php echo $item['material']; ?></td>
		    <td id="list_qty_<?php echo $item['id']; ?>"><?php echo $freight; ?></td>
		    <td id="list_transactiondate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])); ?></td>
		    <td id="list_dispatchdate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['dispatchdate'])); ?></td>
		    <td id="list_truckno_<?php echo $item['id']; ?>"><?php echo $item['truckno']; ?></td>
		    <td id="list_own_<?php echo $item['id']; ?>"><?php echo $own[$item['own']]; ?></td>
		    <td id="list_loadprovider_<?php echo $item['id']; ?>" <?php echo $trBillClass;?> ><?php echo $item['loadprovider']=='FT'?"Factory":"Transporter"; ?></td>
		    <td id="list_transporter_<?php echo $item['id']; ?>"><?php echo $item['loadprovider']=='FT'?$item['factoryname']:$item['transporter']; ?></td>
		    <td id="list_drivername_<?php echo $item['id']; ?>"><?php echo $item['drivername']; ?></td>
		    <td id="list_driveradvance_<?php echo $item['id']; ?>"><?php echo $item['driveradvance']; ?></td>
		    <!-- <td id="list_datecreated_<?php echo $item['id']; ?>"><?php echo $item['datecreated']; ?></td> -->
		    <td>
		     <span class="spanEdit" id="list_editbtn_<?php echo $item['id']; ?>" data-fulltext='<?php echo json_encode($item); ?>' ><i class="fa fa-fw fa-edit" ></i></span>
		     </td>
		    
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


/*$(".editHref").on("click", function(this) {
        alert("click")
	//alert($(e).data('fullText'))
	alert($(this).attr('data-fullText'))
	//e.preventDefault();
	
        
    });*/

$('.spanEdit').on('click',function(){
	//e.preventDefault();

	var json=JSON.parse($(this).attr('data-fulltext'));
	$('#myModal').modal('show');
	$('#btnUpdate').removeClass('hidden');
	$('#btnCreate').addClass('hidden');
	//alert("value of "+json['traveltype']);
	//alert("value of "+json['id_driver']);
	//alert(driversJson[json['id_driver']]['id_driver']);
	
	$("#tripCode").html(json['id_trip']);
	$("#field_loadprovider").val(json['loadprovider']);
	if(json['traveltype']==0){
		$('#field_traveltype').prop('checked',true);
	
	}

	$('span_id_truck').html("");
	if(json['own']==0){
		$('#field_own').prop('checked',false);
		$('#span_id_truck').html('<a href="<?php echo getLinkTruckDocs()?>'+json['rc_file']+'" target="_blank">Rc</a> | <a href="<?php echo getLinkTruckDocs()?>'+json['pancard_file']+'" target="_blank">Pan Card</a>');
	
	}

	if(json['ispodreceived']==1){
		$('#field_ispodreceived').prop('checked',true);
	}

	if(json['ispodsubmitted']==1){
		$('#field_ispodsubmitted').prop('checked',true);
	}

	loadprovider();
	
	var regfst=3;
	var unregfst=1;
	$.each(json['fstations'],function(key,data){
		if(data['id_fuel_station']!=0 ){
			$('#fuel_'+regfst+'_id_fuel_station').val(data['id_fuel_station']);
			$('#fuel_'+regfst+'_qty').val(data['qty']);
			$('#fuel_'+regfst+'_priceperltr').val(data['priceperltr']);
			$('#fuel_'+regfst+'_amount').val(data['amount']);
			regfst+=1;
		}else{
			$('#fuel_'+unregfst+'_fuelstationname').val(data['fuelstationname']);
			$('#fuel_'+unregfst+'_qty').val(data['qty']);
			$('#fuel_'+unregfst+'_priceperltr').val(data['priceperltr']);
			$('#fuel_'+unregfst+'_amount').val(data['amount']);
			unregfst+=1;
		}
	
	});

	$.each(json, function (key, data) {
	    if(key=='own' && data==1){
		$('#field_'+key).prop('checked', true);
		return true;
	    }
	    $('#field_'+key).val(data);
	});

	travelType();
		
	own();
	//id_operating_route();
	qty();
	bags();
	
	//id_factory_route_material();
	rate();
	//id_driver();
	if(json['id_transporter']!=0){ //for transporter
		//alert(json['transporter']+"#"+json['id_transporter']);
		$('#field_id_transporter').val(json['transporter']+"#"+json['id_transporter']);
		$('#field_id_material').val(json['material']+"#"+json['id_material']+"#"+json['materialcode']);

		
		$('#field_id_operating_route').val(JSON.stringify(operatingroutesJson[json['id_operating_route']]));
		$('#field_id_driver').val(JSON.stringify(driversJson[json['id_driver']]));
	}else{ //facory
		id_factory();
		//alert(json['id_factory_rate']);

 		$('#field_id_factory_route_material').val(JSON.stringify(fratesJson[json['id_factory_rate']]));
	}
	
	if($('#field_own').val()==1){
		$('#field_id_driver').val(JSON.stringify(driversJson[json['id_driver']]));
	}else{
		$('#field_id_driver_text').val(json['drivername']);
		$('#div_loadingexp #field_loadingexp').val(json['loadingexp']);
		$('#div_unloadingexp #field_unloadingexp').val(json['unloadingexp']);
	}
	//alert("value of "+json['id']);
	$('#pkey').val(json['id']);
	$('#field_id_truck').val(json['id_truck']+'#'+json['truckno']);

});
</script>