<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th ><!-- <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /> --></th>
            <th >S.No</th>
            <th >Particulars</th>
	    <th >Narration</th>
	    <th >Transaction Date</th>
	    <th >Transaction Type</th>
	    <th >Payment Mode</th>
            <th >Payment Ref</th>
            <th >Branch</th>
            <th >Amount</th>
            <th >Date Created</th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
                    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>"  >
                    <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
                    <?php }	?></td>
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_truckno_<?php echo $item['id']; ?>"><?php echo $item['particulars']; ?></td>
		    <td id="list_dateattached_<?php echo $item['id']; ?>"><?php echo $item['narration']; ?></td>
                    
		    <td id="list_itemname_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])); ?></td>
		    <td id="list_refno_<?php echo $item['id']; ?>"><?php echo $item['transactiontype']; ?></td>
                    <td id="list_type_<?php echo $item['id']; ?>"><?php echo $item['paymentmode']; ?></td>
		    <td id="list_cmr_<?php echo $item['id']; ?>"><?php echo $item['paymentref']; ?></td>
		    <td id="list_branchcity_<?php echo $item['id']; ?>"><?php echo $item['branchcity']; ?></td>
                    <td id="list_comment_<?php echo $item['id']; ?>"><?php echo $item['amount']; ?></td>
                    <td id="list_datecreated_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['datecreated'])); ?></td>
                    <!-- <td><i class="fa fa-fw fa-edit <?php echo $editPermClass; ?>" onclick='fnEdit(<?php echo json_encode($item); ?>);'></i></td> -->
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