<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th style="width:3%"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th  style="width:6%">S.No</th>
            <th style="width:20%">
                    Item Name
            </th>
            <th style="width:20%">
                Description
            </th>
	    <th style="width:15%">Make</th>
	    <th style="width:20%">
                Type
            </th>
	    <!-- <th style="width:20%">
                Date Created
            </th> -->
	    <th style="width:3%"></th>
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
                    <td id="list_itemname_<?php echo $item['id']; ?>"><?php echo $item['itemname']; ?></td>
                    <td id="list_description_<?php echo $item['id']; ?>"><?php echo $item['description']; ?></td>
		    <td id="list_make_<?php echo $item['id']; ?>"><?php echo $item['make']; ?></td>
		    <td id="list_type_<?php echo $item['id']; ?>"><?php echo $item['type']; ?></td>
		    <!-- <td id="list_datecreated_<?php echo $item['id']; ?>"><?php echo $item['datecreated']; ?></td> -->
		    
                    <td>
                        <span class="spanEdit" id="list_editbtn_<?php echo $item['id']; ?>" data-fulltext='<?php echo json_encode($item); ?>' ><i class="fa fa-fw fa-edit" ></i></span></td>
                </tr>
        <?php } ?>
        <?php } else { ?>
            <tr>
                <td class="text-center" colspan="6">No Data Available</td>
            </tr>
        <?php } ?>
    </tbody>
</table>
<?php include(DIR_TEMPLATE.'common/_pagination.tpl');?>
<script>
$('.spanEdit').on('click',function(){
    var json=JSON.parse($(this).attr('data-fulltext'));
	$.each(json, function (key, data) {
	    $('#field_'+key).val(data);
	});
	$('#pkey').val(json.id);
});
</script>