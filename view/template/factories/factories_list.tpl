<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th>S.No</th>
            <th>
                <?php
		getSortLink(array('title'=>'Name','column'=>'factoryname','link'=>$sort_factoryname,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
	    <?php
		getSortLink(array('title'=>'Code','column'=>'factorycode','link'=>$sort_factorycode,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
	    </th>
	    <th>
	    <?php
		getSortLink(array('title'=>'Contact Name','column'=>'factorycontactname','link'=>$sort_factorycontactname,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
	    </th>
	    <th>
	    <?php
		getSortLink(array('title'=>'Contact Mobile','column'=>'factorycontactmobile','link'=>$sort_factorycontactmobile,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
	    </th>
            <th>
                <?php
		getSortLink(array('title'=>'Email','column'=>'factoryemail','link'=>$sort_factoryemail,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Biller Name','column'=>'billingpersonname','link'=>$sort_billingpersonname,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Biller Mobile','column'=>'billingpersonmobile','link'=>$sort_billingpersonmobile,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Payment Cycle','column'=>'paymentcycle','link'=>$sort_paymentcycle,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Payment Mode','column'=>'paymentmode','link'=>$sort_paymentmode,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    
	    <th>
                <?php
		getSortLink(array('title'=>'City','column'=>'city','link'=>$sort_city,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>Address</th>
	    <th>Add Party</th>
	    <th>
                <?php
		getSortLink(array('title'=>'Status','column'=>'status','link'=>$sort_status,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th></th>
	  </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
                    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>">
                <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } ?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_factoryname_<?php echo $item['id']; ?>"><?php echo $item['factoryname']; ?></td>
		    <td id="list_factorycode_<?php echo $item['id']; ?>"><?php echo $item['factorycode']; ?></td>
		    <td id="list_factorycontactname_<?php echo $item['id']; ?>"><?php echo $item['factorycontactname']; ?></td>
		    <td id="list_factorycontactmobile_<?php echo $item['id']; ?>"><?php echo $item['factorycontactmobile']; ?></td>
                    <td id="list_factoryemail_<?php echo $item['id']; ?>"><?php echo $item['factoryemail']; ?></td>
		    <td id="list_billingpersonname_<?php echo $item['id']; ?>"><?php echo $item['billingpersonname']; ?></td>
		    <td id="list_billingpersonmobile_<?php echo $item['id']; ?>"><?php echo $item['billingpersonmobile']; ?></td>
		    <td id="list_paymentcycle_<?php echo $item['id']; ?>"><?php echo $item['paymentcycle']; ?></td>
		    <td id="list_paymentmode_<?php echo $item['id']; ?>"><?php echo $item['paymentmode']; ?></td>
		    <td id="list_city_<?php echo $item['id']; ?>"><?php echo $item['city']; ?></td>
		    <td id="list_address_<?php echo $item['id']; ?>"><?php echo $item['address']; ?></td>
		    <td ><button  type="button" class="btn btn-primary addFactoryTrip" id="party_<?php echo $item['id']; ?>">Add Party</button></td>
		    <td id="list_status_<?php echo $item['id']; ?>"><?php echo $item['status']==1?'<i class="fa fa-star" aria-hidden="true"></i>':'<i class="fa fa-star-o" aria-hidden="true"></i>'; ?></td>
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
<?php 
//echo '<pre>';print_r($materials);echo '</pre>';
//$optionMaterial="";
//foreach($materials as $k=>$material){ $optionMaterial.="<option value='".$material["id_material"]."'>".$material["material"]."</option>";}

$optionORoute="";
foreach($oRoutes as $k=>$oRoute){ $optionORoute.="<option value='".$oRoute["id_operating_route"]."'>".$oRoute["operatingroutecode"]."</option>";}

/*$optionParty="<option value='0'>None</option>";
foreach($parties as $k=>$party){ $optionParty.="<option value='".$party["id_factory_party"]."'>".$party["partyname"]."</option>";}*/
?>

<script>

var rowNum=0; 
var rowPartyNum=0;
//var optionMaterial="<?php echo $optionMaterial;?>";
var optionORoute="<?php echo $optionORoute;?>";
//var optionParties="<?php echo $optionParty;?>";
var optionParties;

$('.spanEdit').on('click',function(){
	rowNum=0;
	$('#factory_rates_table tbody').html("");
	var json=JSON.parse($(this).attr('data-fulltext'));
	$('#myModal').modal('show');
	$('#btnUpdate').removeClass('hidden');
	
	optionParties="<option value='0'>None</option>";
	$.each(json['factoryParties'],function(ind,val){
		optionParties+="<option value='"+val['id_factory_party']+"'>"+val['partyname']+"</option>";
	});
	
	$.each(json, function (key, data) {
	    if(key=='status' && data==1){
		$('#field_'+key).prop('checked', true);
		return true;
	    }
	    if(key=='factoryRates'){
		
		$.each(data,function(no,rate){
			fnRates(rate);
		});
	    }	

	    $('#field_'+key).val(data);
	});
	
	$('#pkey').val(json.id);


});


function fnRates(rate){
	rowNum=rowNum+1;
	//alert(rowNum)
	if (typeof(rate)=="undefined")
	{
		rate={"id_factory_rate":"","id_factory":"","material":"","id_operating_route":"1","operatingroutecode":"","priceperton":"","loadingpoint":"","unloadingpoint":"","loadingcharge":"","unloadingcharge":"","tollcharge":"","id_material":"1","loadingperson":"","loadingpersonmobile":""};
	}
	//<select  name="row['+rowNum+'][id_material]" id="row_'+rowNum+'_id_material" class="form-control">'+optionMaterial+'</select>
	$('#factory_rates_table tbody').append('<tr id="'+rowNum+'"><td><input name="row['+rowNum+'][material]" type="text" class="form-control" placeholder="Material" data-toggle="tooltip" data-placement="auto top" title="Material" id="row_'+rowNum+'_material"  value="'+rate['material']+'"  data-original-title="Material" required></td><td><select  name="row['+rowNum+'][id_operating_route]" id="row_'+rowNum+'_id_operating_route" class="form-control">'+optionORoute+'</select></td><td><input name="row['+rowNum+'][priceperton]" type="text" class="form-control" placeholder="Price Per Ton" data-toggle="tooltip" data-placement="auto top" title="Price Per Ton"  value="'+rate['priceperton']+'"   id="row_'+rowNum+'_priceperton"  data-original-title="Price Per Ton" required></td><td><input name="row['+rowNum+'][loadingperson]" type="text" class="form-control" placeholder="Loading Person" data-toggle="tooltip" data-placement="auto top" title="Loading Person" id="row_'+rowNum+'_loadingperson"  value="'+rate['loadingperson']+'"   data-original-title="Loading Person" required></td><td><input name="row['+rowNum+'][loadingpersonmobile]" type="text" class="form-control" placeholder="Loading Person Mobile"  value="'+rate['loadingpersonmobile']+'"  data-toggle="tooltip" data-placement="auto top" title="Loading Person Mobile" id="row_'+rowNum+'_loadingpersonmobile"  data-original-title="Loading Person Mobile" required></td><td><input name="row['+rowNum+'][loadingpoint]" type="text" class="form-control" placeholder="Loading Point" data-toggle="tooltip" data-placement="auto top" title="Loading Point"  value="'+rate['loadingpoint']+'"  id="row_'+rowNum+'_loadingpoint"  data-original-title="Loading Point" required></td><td><input name="row['+rowNum+'][unloadingpoint]" type="text" class="form-control" placeholder="UnLoading Point" data-toggle="tooltip" data-placement="auto top" title="UnLoading Point"  value="'+rate['unloadingpoint']+'"  id="row_'+rowNum+'_unloadingpoint"  data-original-title="UnLoading Point" required></td><td><input name="row['+rowNum+'][loadingcharge]" type="text" class="form-control" placeholder="Loading charge" data-toggle="tooltip" data-placement="auto top" title="Loading charge" id="row_'+rowNum+'_loadingcharge"  value="'+rate['loadingcharge']+'"  data-original-title="Loading charge" required></td><td><input name="row['+rowNum+'][unloadingcharge]" type="text" class="form-control" placeholder="UnLoading charge" data-toggle="tooltip" data-placement="auto top" title="UnLoading charge"  value="'+rate['unloadingcharge']+'"  id="row_'+rowNum+'_unloadingcharge"  data-original-title="UnLoading charge" required></td><td><input name="row['+rowNum+'][tollcharge]" type="text" class="form-control" placeholder="Toll Charge" data-toggle="tooltip" data-placement="auto top" title="Toll Charge"  value="'+rate['tollcharge']+'"  id="row_'+rowNum+'_tollcharge"  data-original-title="Toll Charge" required></td><td><select  name="row['+rowNum+'][id_factory_party]" id="row_'+rowNum+'_id_factory_party" class="form-control">'+optionParties+'</select></td><td><i class="fa fa-remove"  onclick="$(this).parent().parent().remove()"></td></tr>');

	$('#row_'+rowNum+'_id_material').val(rate['id_material']);
	$('#row_'+rowNum+'_id_operating_route').val(rate['id_operating_route']);
	$('#row_'+rowNum+'_id_factory_party').val(rate['id_factory_party']);
	//alert("id_factory_party "+rate['id_factory_party']);
}

function fnParties(party){
	rowPartyNum=rowPartyNum+1;
	//alert(rowPartyNum)
	if (typeof(party)=="undefined")
	{
		party={"id_factory_party":"","id_factory":"","partyname":"","contactname":"1","contactmobile":"","partycode":""};
	}
	
	$('#factory_parties_table tbody').append('<tr id="'+rowPartyNum+'"><td><input name="row['+rowPartyNum+'][id_factory_party]" type="hidden" value="'+party['id_factory_party']+'"   id="row_'+rowPartyNum+'_id_factory_party"><input name="row['+rowPartyNum+'][partyname]" type="text" class="form-control" placeholder="Party Name" data-toggle="tooltip" data-placement="auto top" title="Party Name"  value="'+party['partyname']+'"   id="row_'+rowPartyNum+'_partyname"  data-original-title="Party Name" required></td><td><input name="row['+rowPartyNum+'][partycode]" type="text" class="form-control" placeholder="Party Code" data-toggle="tooltip" data-placement="auto top" title="Party Code"  value="'+party['partycode']+'"  id="row_'+rowPartyNum+'_partycode"  data-original-title="Party Code" required></td><td><input name="row['+rowPartyNum+'][contactname]" type="text" class="form-control" placeholder="Contact Name" data-toggle="tooltip" data-placement="auto top" title="Contact Name" id="row_'+rowPartyNum+'_contactname"  value="'+party['contactname']+'"   data-original-title="Contact Name" required></td><td><input name="row['+rowPartyNum+'][contactmobile]" type="text" class="form-control" placeholder="Contact Mobile"  value="'+party['contactmobile']+'"  data-toggle="tooltip" data-placement="auto top" title="Contact Mobile" id="row_'+rowPartyNum+'_contactmobile"  data-original-title="Contact Mobile" required></td><td><i class="fa fa-remove"  onclick="$(this).parent().parent().remove()"></td></tr>');
}

$('.addFactoryTrip').on('click',function(){
	rowPartyNum=0;
	var party_div_id=$(this).attr('id');
	split_party_div_id=party_div_id.split("_");
	id_factory=split_party_div_id[1];
	//alert(id_factory)
	
	var json=JSON.parse($("#list_editbtn_"+id_factory).attr('data-fulltext'));
	//alert(json);
	//alert(json['factoryParties']);
	$("#party_factory_name").html(json['factoryname']);
	$("#field_id_factory_factory_party").val(json['id']);
	$('#factory_parties_table tbody').html("");
	$.each(json['factoryParties'],function(key,party){
			fnParties(party);
	});
	    
	$('#myModalSub').modal('show');
});

</script>