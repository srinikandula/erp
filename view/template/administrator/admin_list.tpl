<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th style="width:3%"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th  style="width:6%">S.No</th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Name','column'=>'adminname','link'=>$sort_adminname,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Email','column'=>'adminemail','link'=>$sort_adminemail,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Mobile','column'=>'adminmobile','link'=>$sort_adminmobile,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Username','column'=>'username','link'=>$sort_username,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">Branch</th>
	    <th style="width:10%">Role</th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Status','column'=>'status','link'=>$sort_status,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:3%"></th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
		    //echo '<pre>';print_r($branches);print_r($roles);echo '</pre>';
		    $gIcon[0]='<i class="fa fa-star-o" aria-hidden="true"></i>';
		    $gIcon[1]='<i class="fa fa-star" aria-hidden="true"></i>';
                    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>">
                <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } ?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_adminname_<?php echo $item['id']; ?>"><?php echo $item['adminname']; ?></td>
                    <td id="list_adminemail_<?php echo $item['id']; ?>"><?php echo $item['adminemail']; ?></td>
		    <td id="list_adminmobile_<?php echo $item['id']; ?>"><?php echo $item['adminmobile']; ?></td>
		    <td id="list_username_<?php echo $item['id']; ?>"><?php echo $item['username']; ?></td>
		    <td id="list_id_branch_<?php echo $item['id']; ?>"><?php echo $item['branchcity']; ?></td>
		    <td id="list_id_admin_role_<?php echo $item['id']; ?>"><?php echo $item['role']; ?></td>
		    <td id="list_status_<?php echo $item['id']; ?>"><?php echo $gIcon[$item['status']]; ?></td>
		    <td><i class="fa fa-fw fa-edit <?php echo $editPermClass; ?>" onclick='fnEdit(<?php echo json_encode($item); ?>);'></i></td>
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
function fnEdit(json) {
	//alert(json);
	//var json=$.parseJSON(json);
	$.each(json, function (key, data) {
	    //alert(key+"=>"+data)
	    /*console.log(key)
	    $.each(data, function (index, data) {
		console.log('index', data)
	    })*/
	    if(key=='password'){
		return;
	    }

	    $('#field_'+key).val(data);
	});
	/*$('#field_trucktype').val(str.trucktype);
	$('#field_tons').val(str.tons);
	$('#field_tyres').val(str.tyres);
	*/
	//$('#field_password').val("");
	$('#pkey').val(json.id);
}
</script>