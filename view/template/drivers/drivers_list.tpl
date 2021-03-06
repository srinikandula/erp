<table class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th style="width:3%"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></th>
            <th  style="width:6%">S.No</th>
            <th style="width:20%">
                <?php
		getSortLink(array('title'=>'Name','column'=>'drivername','link'=>$sort_drivername,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
            <th style="width:10%">
                <?php
		getSortLink(array('title'=>'Code','column'=>'drivercode','link'=>$sort_drivercode,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:10%">
                <?php
		getSortLink(array('title'=>'Mobile','column'=>'drivermobile','link'=>$sort_drivermobile,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:10%">Alt Mobile</th>
	    <th style="width:15%">
                <?php
		getSortLink(array('title'=>'Doj','column'=>'doj','link'=>$sort_doj,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?>
            </th>
	    <th style="width:10%">                <?php
		getSortLink(array('title'=>'Licence Valid Date','column'=>'licencevalidtilldate','link'=>$sort_licencevalidtilldate,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?></th>
	    <th style="width:10%"><?php
		getSortLink(array('title'=>'Fixed Per Month','column'=>'fixedpermonth','link'=>$sort_fixedpermonth,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?></th>
	    <!--<th style="width:10%"><?php
		getSortLink(array('title'=>'Batta','column'=>'batta','link'=>$sort_batta,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?></th>-->
	    <th style="width:10%"><?php
		getSortLink(array('title'=>'Per Trip Percent on Freight','column'=>'pertrippercentonfreight','link'=>$sort_pertrippercentonfreight,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?></th>
	    <th style="width:10%"><?php
		getSortLink(array('title'=>'Per Trip Commission','column'=>'pertripcommission','link'=>$sort_pertripcommission,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?></th>
            <th>Active</th>
	    <!-- <th style="width:10%"><?php
		getSortLink(array('title'=>'Status','column'=>'status','link'=>$sort_status,'sortedBy'=>$sort,'orderTypeIcon'=>$order));?></th> -->

	    <th style="width:3%"></th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
                    foreach ($items as $k => $item) { $status=$item['status']==1?'<i class="fa fa-star" aria-hidden="true"></i>':'<i class="fa fa-star-o" aria-hidden="true"></i>'; ?>
            <tr id="list_<?php echo $item['id']; ?>">
                <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } ?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_drivername_<?php echo $item['id']; ?>"><?php echo $item['drivername']; ?></td>
                    <td id="list_drivercode_<?php echo $item['id']; ?>"><?php echo $item['drivercode']; ?></td>
		    <td id="list_drivermobile_<?php echo $item['id']; ?>"><?php echo $item['drivermobile']; ?></td>
		    <td id="list_alternateno_<?php echo $item['id']; ?>"><?php echo $item['alternateno']; ?></td>
		    <td id="list_doj_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['doj'])); ?></td>
		    <td id="list_licencevalidtilldate_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['licencevalidtilldate'])); ?></td>
		    <td id="list_fixedpermonth_<?php echo $item['id']; ?>"><?php echo $item['fixedpermonth']; ?></td>
			<!--<td id="list_batta_<?php echo $item['id']; ?>"><?php echo $item['batta']; ?></td>-->
			<td id="list_pertrippercentonfreight_<?php echo $item['id']; ?>"><?php echo $item['pertrippercentonfreight']; ?></td>
			<td id="list_pertripcommission_<?php echo $item['id']; ?>"><?php echo $item['pertripcommission']; ?></td>
		    <!-- <td id="list_status_<?php echo $item['id']; ?>"><?php echo $item['status']; ?></td> -->
		    <td id="list_status_<?php echo $item['id']; ?>"><?php echo $status; ?></td>
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
	$('#myModal').modal('show');
	$('#btnUpdate').show();
        $('#btnCreate').hide();
	$.each(json, function (key, data) {
	    $('#field_'+key).val(data);
	});

	$('#field_calendar').load("index.php?route=drivers/drivers/calendar&token=<?php echo $_GET['token']; ?>&id_driver="+json.id);
	$('#pkey').val(json.id);
	//id_driver="+json['id_driver']+"&
});


</script>