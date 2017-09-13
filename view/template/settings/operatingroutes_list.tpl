<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th style="width:3%"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th  style="width:6%">S.No</th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Route Code','column'=>'operatingroutecode','link'=>$sort_operatingroutecode,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'From','column'=>'from','link'=>$sort_from,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'To','column'=>'to','link'=>$sort_to,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Distance','column'=>'distance','link'=>$sort_distance,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Toll Charge','column'=>'tollcharge','link'=>$sort_tollcharge,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:10%">
                <?php
		getSortLink(array('title'=>'No Of TollGates','column'=>'status','link'=>$sort_nooftollgates,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
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
                    <td id="list_operatingroutecode_<?php echo $item['id']; ?>"><?php echo $item['operatingroutecode']; ?></td>
                    <td id="list_fromplace_<?php echo $item['id']; ?>"><?php echo $item['fromplace']; ?></td>
		    <td id="list_toplace_<?php echo $item['id']; ?>"><?php echo $item['toplace']; ?></td>
		    <td id="list_distance_<?php echo $item['id']; ?>"><?php echo $item['distance']; ?></td>
		    <td id="list_tollcharge_<?php echo $item['id']; ?>"><?php echo $item['tollcharge']; ?></td>
		    <td id="list_nooftollgates_<?php echo $item['id']; ?>"><?php echo $item['nooftollgates']; ?></td>
		    <td>
                        <span class="spanEdit" id="list_editbtn_<?php echo $item['id']; ?>" data-fulltext='<?php echo json_encode($item); ?>' ><i class="fa fa-fw fa-edit" ></i></span></td>
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
	$.each(json, function (key, data) {
	    $('#field_'+key).val(data);
	});
	$('#pkey').val(json.id);
});
</script>