<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th>S.No</th>
            <th>
	    Bill No               
            </th>
	    <th>
	    Factory               
            </th>
	    <th>
	    Date From
	    </th>
	    <th>
	    Date To
	    </th>
	    <th>
	    Bill Date
	    </th>
            <th>
	    Due Date
	    </th>
            <th>
	    Total Trips
	    </th>
            <th>
	    Freight
	    </th>
            <th>
            Total Receivable
            </th>
            <th>
            Paid Amount
            </th>
            <th>Payments</th>
            <th>
	    Date Created
	    </th>
	    <th></th>
	  </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
                    foreach ($items as $k => $item) {  $bal=$item['totalreceivableamount']-$item['paidamount']; 
		    $overdue=((strtotime($item['duedate'])<strtotime('now')) && $bal)?1:0;
		    //echo "((".strtotime($item['duedate'])."<".strtotime('now').") && ".$bal.")"."<br/>val of ".$overdue."<br/>";
		    ?>
            <tr id="list_<?php echo $item['id']; ?>" <?php if(!$bal){ echo 'class="success"';}?> <?php if($overdue){ echo 'class="danger"';}?> >
                <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } ?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_id_factory_payment_<?php echo $item['id']; ?>"><?php echo $item['id_factory_payment']; ?></td>
		    <td id="list_factoryname_<?php echo $item['id']; ?>"><?php echo $item['factoryname']; ?></td>
		    <td id="list_datefrom_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['datefrom'])); ?></td>
		    <td id="list_dateto_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['dateto'])); ?></td>
                    <td id="list_billgendate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['billgendate'])); ?></td>
                    <td id="list_duedate_<?php echo $item['id']; ?>"><?php echo $item['duedate']; ?></td>
                    <td id="list_totaltrips_<?php echo $item['id']; ?>"><?php echo $item['totaltrips']; ?></td>
		    <td id="list_freight_<?php echo $item['id']; ?>"><?php echo $item['freight']; ?></td>
                    <td id="list_totalreceivableamount_<?php echo $item['id']; ?>"><?php echo $item['totalreceivableamount']; ?></td>
                    <td id="list_paidamount_<?php echo $item['id']; ?>"><?php echo $item['paidamount']; ?></td>
                    <td><button type="button" class="btn btn-sm btn-primary addFactoryPayment" id="payment_<?php echo $item['id'];?>">Payment</button></td>
                    <td id="list_datecreated_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['datecreated'])); ?></td>
		    <td>
		    <span class="spanEdit" id="list_editbtn_<?php echo $item['id']; ?>" data-fulltext='<?php echo json_encode($item); ?>' ><i class="fa fa-fw fa-edit" ></i></span>
		     </td>
		    
                </tr>
        <?php } ?>
        <?php } else { ?>
            <tr>
                <td class="text-center" colspan="9">No Data Available</td>
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
        //alert(json['closed'])
	/*if(json['closed']==1){
            //$('#myModal input[type="text"],select').attr('readonly',true);
            $('#btnUpdate').addClass('hidden');
	    $('#field_close').prop('checked',true);
        }else{
		$('#field_close').prop('checked',false);
	}*/
        $('#span_id_factory_payment').html('Bill No:'+json['id_factory_payment']);
        if(json['totalreceivableamount']==json['paidamount']){
            $('#btnUpdate').hide();
        }else{
            $('#btnUpdate').show();
	}
        

	
	$('#trip_details_table tbody').html("");

        if(json['trips'].length>0){
            $('#row_trip_no').remove();
        }
        
	$.each(json, function (key, data) {
            //alert(key+" "+data);
            if(key=='trips'){
                $.each(json['trips'],function(k,d){
                    populateTrips(d);
                });
            }else{
                $('#field_'+key).val(data);
            }
	});
        
	$('#span_tdsamount').html(json['tdsamount']);
        $('#span_vatamount').html(json['vatamount']);
	$('#pkey').val(json.id);
	if(json['totalreceivableamount']==json['paidamount']){
		//alert("in ");
		$("#trip_details_table th:last-child, #trip_details_table td:last-child").hide();
	}

});

$('.addFactoryPayment').on('click',function(){
	rowPartyNum=0;
	var div_id=$(this).attr('id');
	split_div_id=div_id.split("_");
	id=split_div_id[1];
	//alert(id_factory)
	
	var json=JSON.parse($("#list_editbtn_"+id).attr('data-fulltext'));
	//alert(json);
	//alert(json['factoryParties']);
        var bal=parseFloat(json['totalreceivableamount'])-parseFloat(json['paidamount']);
	$("#td_factoryname").html(json['factoryname']);
        $("#td_billgendate").html(json['billgendate']);
        $("#td_totalreceivableamount").html(json['totalreceivableamount']);
        $("#td_paidamount").html(parseFloat(json['paidamount']));
        $("#td_balanceamount").html(bal);
        $("#td_id_factory_payment").html(json['id']);
        
	$("#field_id_factory_payment").val(json['id']);
	
        $('#factory_payment_table tbody').html("");
	$.each(json['payments'],function(key,data){
			fnPopulatePData(data);
                        //alert("inside")
	});
        closePaymentHistory();
        $('#myModalSub').modal('show');
});

function fnPopulatePData(data){
	/*if (typeof(data)=="undefined")
	{
		data={"id_factory_party":"","id_factory":"","partyname":"","contactname":"1","contactmobile":"","partycode":""};
	}*/
	//alert("in data");
	var branch=data['isheadoffice']==1?"(HQ)":"";
	paymentMode
	$('#factory_payment_table tbody').append('<tr id="row'+data['id_factory_payment_history']+'"><td>'+data['paymenttype']+'</td><td>'+data['amount']+'</td><td>'+data['datereceived']+'</td><td>'+paymentMode[data['paymentmode']]+'</td><td>'+data['branchcity']+branch+'</td><td>'+data['paymentref']+'</td><td><i class="fa fa-remove"  onclick="fnPaymentDelete('+data['id_factory_payment']+','+data['id_factory_payment_history']+','+data['amount']+')"></td></tr>');
}

function closePaymentHistory(){
    var td_balanceamount=parseFloat($("#td_balanceamount").html());
    if(td_balanceamount==0){
            $("#input_payment_history").hide();
            $("#factory_payment_table th:last-child, #factory_payment_table td:last-child").hide();
    }else{
        $("#input_payment_history").show();
        $("#factory_payment_table th:last-child, #factory_payment_table td:last-child").show();
    }
}

function fnPaymentDelete(id,idh,amount){
    if(confirm("Are you sure.Do you want to delete?")){
        var paidamount= parseFloat(parseFloat($("#td_paidamount").html())-amount);
        //alert(paidamount);
        $.ajax({
                url: 'index.php?route=factories/paymentstmt/deletehistory&token=<?php echo $_GET["token"];?>',
                type: 'post',
                data: 'id='+id+'&idh='+idh+'&paidamount='+paidamount,
                dataType: 'json',
                beforeSend: function() {
                },
                complete: function() {
                },
                success: function(json) {
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        $('#row'+id).remove();
    }
}

function fnAddRecord(){
    if(confirm("Are you sure.You want to add?")){
        var flag=1;
        var field="";
        
        field='#field_amount';
        if ($(field).val() == "") {
            $(field).css('border-color','red');
            flag = 0;
        } else {
            $(field).css('border-color','');
        }

        field='#field_paymenttype';
        if ($(field).val() == "") {
                $(field).css('border-color','red');
                flag = 0;
        } else {
                $(field).css('border-color','');
        }

        field='#field_datereceived';
        if ($(field).val() == "") {
                $(field).css('border-color','red');
                flag = 0;
        } else {
                $(field).css('border-color','');
        }

        field='#field_paymentmode';
        if ($(field).val() == "") {
                $(field).css('border-color','red');
                flag = 0;
        } else {
                $(field).css('border-color','');
        }

        field='#field_id_branch';
        if ($(field).val() == "") {
                $(field).css('border-color','red');
                flag = 0;
        } else {
                $(field).css('border-color','');
        }
        
        //var paidamount= parseFloat(parseFloat($("#td_paidamount").html())-amount);
        //alert(paidamount);
        if(flag){
        $.ajax({
                url: 'index.php?route=factories/paymentstmt/addhistory&token=<?php echo $_GET["token"];?>',
                type: 'post',
                data: $('#horizontalSubForm').serialize(),
                dataType: 'json',
                beforeSend: function() {
                },
                complete: function() {
                },
                success: function(json) {
                    if(json['status']){
                        var parseJsonData=JSON.parse(json['data']);
                        $("#factory_payment_table input[type='text']").val("");
                        var td_paidamount=parseFloat($("#td_paidamount").html())+parseFloat(parseJsonData['amount']);
                        $("#td_paidamount").html(td_paidamount);
                        var td_balanceamount=parseFloat($("#td_totalreceivableamount").html())-td_paidamount;
                        $("#td_balanceamount").html(td_balanceamount);
                        fnPopulatePData(parseJsonData);
                        closePaymentHistory();
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });
        }
            
        
    }
}

$("#field_paymenttype").on('change',function(){
    var ptype=$(this).val();
    var Bal=parseFloat($("#td_balanceamount").html());
    $('#field_amount').val(Bal);
    if(ptype=='Full'){
        $('#field_amount').attr('readonly',true);
    }else{
      $('#field_amount').attr('readonly',false);
    
    }
});
//$('#myModal input[type="text"],select').attr('readonly',true);
</script>