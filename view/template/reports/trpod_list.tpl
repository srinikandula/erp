<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <!--<th > <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /> </th>-->
            <th >S.No</th>
            <th >Trip ID</th>
	    <th >Trans Date</th>
	    <th >Truck No</th>
	    <th >Qty</th>
	    <th >Truck Rate</th>
            <th >Freight</th>
	    <th >Shortage</th>
	    <th >Damage</th>
            <th >Transporter</th>
            <th >Route</th>
	    <th >POD Received</th>
            <th >POD Submitted</th>
	    <th >Adv</th>
	    <th >POD Amount</th>
	    <th >Bill Raised</th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {
		    $icon[1]='<i class="fa fa-check" aria-hidden="true"></i>';
		    $icon[0]='<i class="fa fa-times" aria-hidden="true"></i>';
		    foreach ($items as $k => $item) { $truckType=$item['own']==0?'(Out)':''; ?>
            <tr id="list_<?php echo $item['id']; ?>"  >
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_truckno_<?php echo $item['id']; ?>"><?php echo $item['id_trip']; ?></td>
		    <td id="list_dateattached_<?php echo $item['id']; ?>"><?php echo  date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])); ?></td>
                    <td id="list_itemname_<?php echo $item['id']; ?>"><?php echo $item['truckno'].$truckType; ?></td>
		    <td id="list_refno_<?php echo $item['id']; ?>"><?php echo $item['qty']; ?></td>
                    <td id="list_type_<?php echo $item['id']; ?>"><?php echo $item['truckrate']; ?></td>
		    <td id="list_type_<?php echo $item['id']; ?>"><?php echo $item['qty']*$item['truckrate']; ?></td>
		    <td id="list_cmr_<?php echo $item['id']; ?>"><?php echo $item['shortage']; ?></td>
		    <td id="list_cmr_<?php echo $item['id']; ?>"><?php echo $item['damage']; ?></td>
		    <td id="list_cmr_<?php echo $item['id']; ?>"><?php echo $item['transporter']; ?></td>
		    <td id="list_branchcity_<?php echo $item['id']; ?>"><?php echo $item['operatingroutecode']; ?>
		    </td>
                    <td id="list_comment_<?php echo $item['id']; ?>"><?php echo $icon[$item['ispodreceived']]; ?></td>
                    <td id="list_datecreated_<?php echo $item['id']; ?>"><?php echo $icon[$item['ispodsubmitted']]; ?></td>
		    <td id="list_branchcity_<?php echo $item['id']; ?>"><?php echo $item['transporteradvance']; ?>
		    </td>
		    <td id="list_branchcity_<?php echo $item['id']; ?>"><?php echo ($item['qty']*$item['truckrate'])-($item['shortage']+$item['damage']+$item['transporteradvance']); ?>
		    </td>
		    
		    <td id="list_datecreated_<?php echo $item['id']; ?>"><?php echo $item['id_transporter_payment']==0?'No':'#'.$item['id_transporter_payment']; ?></td>
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