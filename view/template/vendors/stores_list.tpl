<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th>S.No</th>
            <th>Vendor</th>
            <th>Code</th>
            <th>Contact Name</th>
            <th>Contact Mobile</th>
            <th>City</th>
            <th>Address</th>
            <th>Bank</th>
            <th>Account No</th>
            <th>Branch</th>
            <th>IFSC Code</th>
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
                    <td><?php echo $item['sno']; ?></td>
                    <td id="list_vendorname_<?php echo $item['id']; ?>"><?php echo $item['vendorname']; ?></td>
		    <td id="list_vendorcode_<?php echo $item['id']; ?>"><?php echo $item['vendorcode']; ?></td>
		    <td id="list_contactname_<?php echo $item['id']; ?>"><?php echo $item['contactname']; ?></td>
		    <td id="list_contactmobile_<?php echo $item['id']; ?>"><?php echo $item['contactmobile']; ?></td>
                    <td id="list_city_<?php echo $item['id']; ?>"><?php echo $item['city']; ?></td>
		    <td id="list_address_<?php echo $item['id']; ?>"><?php echo $item['address']; ?></td>
		    <td id="list_bankname_<?php echo $item['id']; ?>"><?php echo $item['bankname']; ?></td>
                    <td id="list_accountno_<?php echo $item['id']; ?>"><?php echo $item['accountno']; ?></td>
		    <td id="list_bankbranch_<?php echo $item['id']; ?>"><?php echo $item['bankbranch']; ?></td>
		    <td id="list_bankifsccode_<?php echo $item['id']; ?>"><?php echo $item['bankifsccode']; ?></td>
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
	//$('#btnUpdate').removeClass('hidden');
	$('#btnUpdate').show();
	$('#btnCreate').hide();
	$.each(json, function (key, data) {
	    if(key=='oil' && data==1){
		$('#field_'+key).prop('checked', true);
		return true;
	    }
            if(key=='tyres' && data==1){
		$('#field_'+key).prop('checked', true);
		return true;
	    }
            if(key=='spares' && data==1){
		$('#field_'+key).prop('checked', true);
		return true;
	    }
	    $('#field_'+key).val(data);
	});
	
	$('#pkey').val(json.id);

});
</script>