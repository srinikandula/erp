<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <!--<th > <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /> </th>-->
            <th >S.No</th>
	    <th >Payment ID</th>
            <th >Owner</th>
            <th >Truck No</th>
            <th >Paid On</th>
            <th >Payment Mode</th>
            <th >Amount</th>
            <th >Trips</th>
            <th >Branch</th>
            <th >Date Created</th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {
		foreach ($items as $k => $item) {  //echo '<pre>';print_r($item); echo '</pre>';?>
            <tr id="list_<?php echo $item['id']; ?>" >
                <!--<td>
		<?php
		if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
        <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
        <?php } ?></td>-->
            <td><?php echo $item['sno'];//$k + $page; ?></td>
            <td id="list_id_truck_payment_<?php echo $item['id']; ?>"><?php echo $item['id_truck_payment']; ?></td>
	    <td id="list_contactname_<?php echo $item['id']; ?>"><?php echo $item['contactname']."/".$item['contactmobile']; ?></td>
            <td id="list_truckno_<?php echo $item['id']; ?>"><?php echo $item['truckno']; ?></td>
            <td id="list_paidon_<?php echo $item['id']; ?>"><?php echo $item['paidon']; ?></td>
            <td id="list_paymentmode_<?php echo $item['id']; ?>"><?php echo $item['paymentmode']; if($item['paymentmode']=='CQ'){ echo "<br/>#".$item['chequeno'];}?></td>
            <td id="list_totalpayableamount_<?php echo $item['id']; ?>"><?php echo $item['totalpayableamount']; ?></td>
            <td id="list_nooftrips_<?php echo $item['id']; ?>"><?php echo $item['nooftrips']; ?>
            <!--<input type="hidden" name="hidden_row_data_name" id="hidden_row_data_<?php echo $item['id']; ?>" value='<?php echo json_encode($item);?>'>-->
            </td>
            <td id="list_id_branch_<?php echo $item['id']; ?>"><?php echo $item['branchcity']; ?></td>
            <td id="list_datecreated_<?php echo $item['id']; ?>"><?php echo $item['datecreated']; ?></td>
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