<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th style="width:5%" >S.No</th>
            <th style="width:85%">
                <?php
		getSortLink(array('title'=>'Role','column'=>'role','link'=>$sort_role,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:5%">
                <?php
		getSortLink(array('title'=>'Status','column'=>'status','link'=>$sort_status,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:5%"></th>
	  </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
                    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>">
                <td><?php if($item['id']!=1){if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php }} ?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_role_<?php echo $item['id']; ?>"><?php echo $item['role']; ?></td>
		    <td id="list_status_<?php echo $item['id']; ?>"><?php echo $item['status']==1?'<i class="fa fa-star" aria-hidden="true"></i>':'<i class="fa fa-star-o" aria-hidden="true"></i>'; ?></td>
		     <td><?php if($item['id']!=1){?>
		     <span class="spanEdit" id="list_editbtn_<?php echo $item['id']; ?>" data-fulltext='<?php echo json_encode($item); ?>' ><i class="fa fa-fw fa-edit" ></i></span><?php }?>
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
	$('#permissionsBlock input:checked').each(function() {
		$(this).prop('checked', false);
}	);
	$('#myModal').modal('show');
	$('#btnUpdate').show();
	$('#btnCreate').hide();
	
	$.each(json, function (key, data) {
	    if(key=='status' && data==1){
		$('#field_'+key).prop('checked', true);
		return true;
	    }
	    
	    if(key=='permissions'){
		
		//$('#settings_branches_view').prop('checked',1).val('wow');
		//$('#settings_branches_view').val('wow');
		$.each(data, function (keynum, row) {
		    var modName=row['modulename'].toLowerCase();
		    var view_check=row['view']==1?true:false;
		    var add_check=row['add']==1?true:false;
		    var edit_check=row['edit']==1?true:false;
		    var del_check=row['delete']==1?true:false;
		    $('#'+modName+'_'+row['filename']+'_'+'view').prop('checked',view_check).val(row['view']);
		    $('#'+modName+'_'+row['filename']+'_'+'add').prop('checked',add_check).val(row['add']);
		    $('#'+modName+'_'+row['filename']+'_'+'edit').prop('checked',edit_check).val(row['edit']);
		    $('#'+modName+'_'+row['filename']+'_'+'delete').prop('checked',del_check).val(row['delete']);
		});	
		
		return true;
	    }
	    
	    $('#field_'+key).val(data);
	});
	
	$('#pkey').val(json.id);

});
</script>