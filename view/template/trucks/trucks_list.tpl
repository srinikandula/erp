<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th>S.No</th>
            <th>
                <?php
		getSortLink(array('title'=>'Truck No','column'=>'truckno','link'=>$sort_truckno,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
	    Truck Type
	    </th>
	    <th>
	    Engine No
	    </th>
	    <th>
	    Chessis No
	    </th>
            <th>
                <?php
		getSortLink(array('title'=>'Own','column'=>'own','link'=>$sort_own,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Make','column'=>'make','link'=>$sort_make,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Make Year','column'=>'makeyear','link'=>$sort_makeyear,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Model','column'=>'model','link'=>$sort_model,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Date In Service','column'=>'dateinservice','link'=>$sort_dateinservice,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    
	    <th>
                <?php
		getSortLink(array('title'=>'Fitness Exp Date','column'=>'fitnessexpdate','link'=>$sort_fitnessexpdate,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'HUB Exp Date','column'=>'hubservicedate','link'=>$sort_hubservicedate,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Insurance Exp Date','column'=>'insuranceexpdate','link'=>$sort_insuranceexpdate,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'N Permit Exp Date','column'=>'nationalpermitexpdate','link'=>$sort_nationalpermitexpdate,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Pollution Exp Date','column'=>'pollutionexpdate','link'=>$sort_pollutionexpdate,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th>
                <?php
		getSortLink(array('title'=>'Tax Payable Date','column'=>'taxpayabledate','link'=>$sort_taxpayabledate,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
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
                    <td id="list_truckno_<?php echo $item['id']; ?>"><?php echo $item['truckno']; ?></td>
		    <td id="list_id_truck_type_<?php echo $item['id']; ?>"><?php echo $item['trucktype']; ?></td>
		    <td id="list_engineno_<?php echo $item['id']; ?>"><?php echo $item['engineno']; ?></td>
		    <td id="list_chessisno_<?php echo $item['id']; ?>"><?php echo $item['chessisno']; ?></td>
                    <td id="list_own_<?php echo $item['id']; ?>"><?php echo $item['own']?'<i class="fa fa-check" aria-hidden="true"></i>':'<i class="fa fa-times" aria-hidden="true"></i>'; ?></td>
		    <td id="list_make_<?php echo $item['id']; ?>"><?php echo $item['make']; ?></td>
		    <td id="list_makeyear_<?php echo $item['id']; ?>"><?php echo $item['makeyear']; ?></td>
		    <td id="list_model_<?php echo $item['id']; ?>"><?php echo $item['model']; ?></td>
		    <td id="list_dateinservice_<?php echo $item['id']; ?>"><?php echo $item['dateinservice']=='0000-00-00'?'':date(FORMAT_DATE_FORMAT, strtotime($item['dateinservice'])); ?></td>
		    <td id="list_fitnessexpdate_<?php echo $item['id']; ?>"><?php echo $item['fitnessexpdate']=='0000-00-00'?'':date(FORMAT_DATE_FORMAT, strtotime($item['fitnessexpdate'])); ?></td>
		    <td id="list_hubservicedate_<?php echo $item['id']; ?>"><?php echo $item['hubservicedate']=='0000-00-00'?'':date(FORMAT_DATE_FORMAT, strtotime($item['hubservicedate'])); ?></td>
		    <td id="list_insuranceexpdate_<?php echo $item['id']; ?>"><?php echo $item['insuranceexpdate']=='0000-00-00'?'':date(FORMAT_DATE_FORMAT, strtotime($item['insuranceexpdate'])); ?></td>
		    <td id="list_nationalpermitexpdate_<?php echo $item['id']; ?>"><?php echo $item['nationalpermitexpdate']=='0000-00-00'?'':date(FORMAT_DATE_FORMAT, strtotime($item['nationalpermitexpdate'])); ?></td>
		    <td id="list_pollutionexpdate_<?php echo $item['id']; ?>"><?php echo $item['pollutionexpdate']=='0000-00-00'?'':date(FORMAT_DATE_FORMAT, strtotime($item['pollutionexpdate'])); ?></td>
		    <td id="list_taxpayabledate_<?php echo $item['id']; ?>"><?php echo $item['taxpayabledate']=='0000-00-00'?'':date(FORMAT_DATE_FORMAT, strtotime($item['taxpayabledate'])); ?></td>
		    <!-- <td id="list_dateinservice_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['dateinservice'])); ?></td>
		    <td id="list_fitnessexpdate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['fitnessexpdate'])); ?></td>
		    <td id="list_hubservicedate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['hubservicedate'])); ?></td>
		    <td id="list_insuranceexpdate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['insuranceexpdate'])); ?></td>
		    <td id="list_nationalpermitexpdate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['nationalpermitexpdate'])); ?></td>
		    <td id="list_pollutionexpdate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['pollutionexpdate'])); ?></td>
		    <td id="list_taxpayabledate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['taxpayabledate'])); ?></td> -->
		    <!-- <td id="list_editbtn_<?php echo $item['id']; ?>"><i class="fa fa-fw fa-edit" onclick='fnEdit(<?php echo json_encode($item); ?>);'></i></td> -->
		     <!-- <td id="list_editbtn_<?php echo $item['id']; ?>"><span class="editHref" data-fullText='hell'><i  class="fa fa-fw fa-edit"  ></i></span></td> -->	
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

	//alert($(this).attr('data-fulltext'));
	//var json=$(this).attr('data-fulltext');
	var json=JSON.parse($(this).attr('data-fulltext'));
	//alert(typeof(json))
	//
	//var json={"id":"1","truckno":"AP36K7273","trucktype":"10 Tyre-16 Ton","id_truck_type":"2","own":"1","make":"TATA","makeyear":"2010","model":"Open Body","engineno":"54656464","chessisno":"6465465","omr":"1000","cmr":"2500","dateinservice":"2016-08-30","fitnessexpdate":"2016-09-30","hubservicedate":"2016-10-30","insuranceexpdate":"2016-11-30","nationalpermitexpdate":"2016-12-30","pollutionexpdate":"2016-12-30","taxpayabledate":"2016-12-30","datecreated":"2016-07-30 00:00:00","datemodified":"2016-08-10 23:29:44","edit":"http:\/\/sun-network\/truckerp\/index.php?route=trucks\/trucks\/getlist\/edit&token=mG22zOB0XyBbso09Az4gq0B2X3I18EyS&id=1","sno":1};
	//alert(json['truckno']);
	$('#myModal').modal('show');
	$('#btnUpdate').removeClass('hidden');
	//alert(json);
	//var json=$.parseJSON(json);
	//alert("value of "+json['own']);
	$('#span_rc_file').html("");
	$('#span_pancard_file').html("");
	if(json['own']==0){
		$('#div_field_contactmobile').show();
		$('#div_field_contactname').show();
		$('#div_field_pancard_file').show();
		$('#div_field_rc_file').show();
		$('#field_own').prop('checked', false);
		//alert(json['rc_file']+ " " +json['pancard_file'])
		if(json['rc_file']!=""){
			$('#span_rc_file').html('<a href="<?php echo getLinkTruckDocs(); ?>'+json['rc_file']+'" target="_blank">View RC</a>');
		}

		if(json['pancard_file']!=""){
			$('#span_pancard_file').html('<a href="<?php echo getLinkTruckDocs(); ?>'+json['pancard_file']+'" target="_blank">View Pan Card</a>');
		}

		$('#prev_rc_file').val(json['rc_file']);	
		$('#prev_pancard_file').val(json['pancard_file']);	

	}else{
		$('#field_own').prop('checked', true);
		$('#div_field_contactmobile').hide();
		$('#div_field_contactname').hide();
		$('#div_field_pancard_file').hide();
		$('#div_field_rc_file').hide();
	}

	//alert("value of "+json.id);
	$('#pkey').val(json.id);
	$.each(json, function (key, data) {
	   /* if(key=='own' && data==1){
		$('#field_'+key).prop('checked', true);
		return true;
	    }*/
	    $('#field_'+key).val(data);
	});
	
	

});
/*function fnEdit(id) {
	
	//alert($('#list_editbtn_'+json).data('fulltext'));
	//alert($('#list_editbtn_'+json).attr('data-fullText'));
	var json=$('#list_editbtn_'+id).data('fulltext');
	alert(json['truckno']);
	$('#myModal').modal('show');
	$('#btnUpdate').removeClass('hidden');
	//alert(json);
	//var json=$.parseJSON(json);
	$.each(json, function (key, data) {
	    //alert(key+"=>"+data)
	    if(key=='own' && data==1){
		$('#field_'+key).prop('checked', true);
		return true;
	    }
	    $('#field_'+key).val(data);
	});
	
	$('#pkey').val(json.id);
}*/

</script>