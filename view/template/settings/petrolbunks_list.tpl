<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th style="width:3%"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th  style="width:6%">S.No</th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Name','column'=>'fuelstationname','link'=>$sort_fuelstationname,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Code','column'=>'fuelstationcode','link'=>$sort_fuelstationcode,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:15%">
                <?php
		getSortLink(array('title'=>'City','column'=>'city','link'=>$sort_city,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Contact Name','column'=>'fuelpersonname','link'=>$sort_fuelpersonname,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Contact Mobile','column'=>'fuelpersonmobile','link'=>$sort_fuelpersonmobile,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:15%">Address</th>
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
                    <td id="list_fuelstationname_<?php echo $item['id']; ?>"><?php echo $item['fuelstationname']; ?></td>
                    <td id="list_fuelstationcode_<?php echo $item['id']; ?>"><?php echo $item['fuelstationcode']; ?></td>
		    <td id="list_city_<?php echo $item['id']; ?>"><?php echo $item['city']; ?></td>
		    <td id="list_fuelpersonname_<?php echo $item['id']; ?>"><?php echo $item['fuelpersonname']; ?></td>
		    <td id="list_fuelpersonmobile_<?php echo $item['id']; ?>"><?php echo $item['fuelpersonmobile']; ?></td>
		    <td id="list_address_<?php echo $item['id']; ?>"><?php echo $item['address']; ?></td>
                    <!-- <td><i class="fa fa-fw fa-edit <?php echo $editPermClass; ?>" onclick='fnEdit(<?php echo json_encode($item); ?>);'></i></td> -->
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