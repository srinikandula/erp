<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th style="width:3%"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th  style="width:6%">S.No</th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Code','column'=>'branchcode','link'=>$sort_branchcode,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'City','column'=>'branchcity','link'=>$sort_branchcity,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:15%">Address</th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Contact Name','column'=>'branchcontactname','link'=>$sort_branchcontactname,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Contact Mobile','column'=>'branchcontactmobile','link'=>$sort_branchcontactmobile,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:15%">Head Office</th>
            <th style="width:3%"></th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {
		    $iconCheck[1]='<i class="fa fa-check" aria-hidden="true"></i>';
		    $iconCheck[0]='<i class="fa fa-times" aria-hidden="true"></i>';
                    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>">
                <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } ?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_branchcode_<?php echo $item['id']; ?>"><?php echo $item['branchcode']; ?></td>
                    <td id="list_branchcity_<?php echo $item['id']; ?>"><?php echo $item['branchcity']; ?></td>
		    <td id="list_branchaddress_<?php echo $item['id']; ?>"><?php echo $item['branchaddress']; ?></td>
		    <td id="list_branchcontactname_<?php echo $item['id']; ?>"><?php echo $item['branchcontactname']; ?></td>
		    <td id="list_branchcontactmobile_<?php echo $item['id']; ?>"><?php echo $item['branchcontactmobile']; ?></td>
		    <td id="list_isheadoffice_<?php echo $item['id']; ?>"><?php echo $iconCheck[$item['isheadoffice']]; ?></td>
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