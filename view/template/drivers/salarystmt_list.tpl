<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th>S.No</th>
            <th>Driver</th>
	    <th>Code</th>
	    <th>Mobile</th>
	    <th>Alt Mobile</th>
	    <th>Date From</th>
	    <th>Date To</th>
	    <th>Settlement Date</th>
	    <th>Paid On</th>
            <th>Total Payable</th>
	    <th></th>
	  </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
                    foreach ($items as $k => $item) {  $trClass= $item['closed']?"class='success'":'';?>
            <tr id="list_<?php echo $item['id']; ?>" <?php echo $trClass;?> >
                <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } ?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_drivername_<?php echo $item['id']; ?>"><?php echo $item['drivername']; ?></td>
		    <td id="list_drivercode_<?php echo $item['id']; ?>"><?php echo $item['drivercode']; ?></td>
		    <td id="list_drivermobile_<?php echo $item['id']; ?>"><?php echo $item['drivermobile']; ?></td>
		    <td id="list_alternateno_<?php echo $item['id']; ?>"><?php echo $item['alternateno']; ?></td>
		    <td id="list_datefrom_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['datefrom'])); ?></td>
		    <td id="list_dateto_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['dateto'])); ?></td>
                    <td id="list_settlementdate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['settlementdate'])); ?></td>
		    <td id="list_paidon_<?php echo $item['id']; ?>"><?php echo $item['paidon']; ?></td>
		    <td id="list_totalpayableamount_<?php echo $item['id']; ?>"><?php echo $item['totalpayableamount']; ?></td>
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
$('.spanEdit').on('click',function(){
	var json=JSON.parse($(this).attr('data-fulltext'));
	$('#myModal').modal('show');
	$('#btnUpdate').removeClass('hidden');
	$('#btnCreate').addClass('hidden');
	$.each(json, function (key, data) {
	    $('#field_'+key).val(data);
	});

	if(json['closed']==1){
		$('#field_close').prop('checked',true);
		 $('#btnUpdate').addClass('hidden');
	}
	var bSel="";
	$('#field_paidby_id_branch').html("");
	$.each(branchesJson, function(key, value) {
		bSel=key==json['paidby_id_branch']?'selected':'';
	     $('#field_paidby_id_branch')
		 .append($("<option "+bSel+" ></option>")
			    .attr("value",value['id_branch'])
			    .text(value['branchcity'])); 
	});
	
	$('#triptotal_totalleaves').val(json['totalleaves']);
	$('#triptotal_totaltrips').val(json['totaltrips']);
	$('#triptotal_totalfreight').val(json['totalfreight']);
	$('#triptotal_totaladv').val(json['totaladvance']);
	$('#triptotal_totaltripexp').val(json['totaltripexp']);
	$('#triptotal_totalshortage').val(json['totalshortage']);
	$('#triptotal_totaldamage').val(json['totaldamage']);
	$('#triptotal_totaloilshortage').val(json['totaloilshortage']);

	$('#field_id_driver').val(JSON.stringify(driversJson[json['id_driver']]));	
	$('#pkey').val(json.id);
	
	if(json['trips'].length>0){
		$('#trip_details_table tbody').html("");
	}

	$.each(json['trips'],function(k,data){
		populateTrips(data);
	});
	
	if($("#field_close").prop('checked')){
		$("#trip_details_table th:last-child, #trip_details_table td:last-child").hide();
	}else{
	$("#trip_details_table th:last-child, #trip_details_table td:last-child").show();
	}

	calPayment();

});
</script>