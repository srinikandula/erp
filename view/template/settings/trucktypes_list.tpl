<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th style="width:3%"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th  style="width:6%">S.No</th>
            <th style="width:50%">
                <?php
		getSortLink(array('title'=>'Truck Type','column'=>'trucktype','link'=>$sort_trucktype,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Tons','column'=>'tons','link'=>$sort_tons,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">Batta</th>
	    <th style="width:40%">
                <?php
		getSortLink(array('title'=>'Tyres','column'=>'tyres','link'=>$sort_tyres,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
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
                    <td id="list_trucktype_<?php echo $item['id']; ?>"><?php echo $item['trucktype']; ?></td>
                    <td id="list_tons_<?php echo $item['id']; ?>"><?php echo $item['tons']; ?></td>
		    <td id="list_batta_<?php echo $item['id']; ?>"><?php echo $item['batta']; ?></td>
		    <td id="list_tyres_<?php echo $item['id']; ?>"><?php echo $item['tyres']; ?></td>
                    <td><span class="spanEdit" id="list_editbtn_<?php echo $item['id']; ?>" data-fulltext='<?php echo json_encode($item); ?>' ><i class="fa fa-fw fa-edit <?php echo $editPermClass; ?>"></i></td>
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
//e.preventDefault();

	var json=JSON.parse($(this).attr('data-fulltext'));
	$('#btnUpdate').hide();
	$.each(json, function (key, data) {
	    $('#field_'+key).val(data);
	});
	
	$('#pkey').val(json.id);

});
</script>