<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th style="width:3%"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th  style="width:6%">S.No</th>
            <th style="width:50%">
                <?php
		getSortLink(array('title'=>'Material','column'=>'material','link'=>$sort_material,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
            <th style="width:40%">
                <?php
		getSortLink(array('title'=>'Material Code','column'=>'materialcode','link'=>$sort_materialcode,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
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
                    <td id="list_material_<?php echo $item['id']; ?>"><?php echo $item['material']; ?></td>
                    <td id="list_materialcode_<?php echo $item['id']; ?>"><?php echo $item['materialcode']; ?></td>
                    <td><i class="fa fa-fw fa-edit <?php echo $editPermClass; ?>" onclick='fnEdit(<?php echo json_encode($item); ?>);'></i></td>
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
function fnEdit(str) {
	$('#field_material').val(str.material);
	$('#field_materialcode').val(str.materialcode);
	$('#pkey').val(str.id);
}
</script>