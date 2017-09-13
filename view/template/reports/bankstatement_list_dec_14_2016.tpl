<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th >S.No</th>
            <th >Date</th>
	    <th >Type</th>
	    <th >Particulars</th>
	    <th >Narration</th>
	    <th >Branch</th>
            <th >Withdrawal</th>
	    <th >Deposit</th>
        </tr>
    </thead>
    <tbody>
        <?php 
	//echo '<pre>';print_r($items);echo '</pre>';
	if ($items) {  
                    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>"  >
                    <td><?php echo $item['sno']; ?></td>
                    <td><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['transdate'])); ?></td>
		    <td><?php echo $item['transtype']; ?></td>
                    
		    <td><?php echo $item['particulars']; ?></td>
		    <td><?php echo $item['narration']; ?></td>
                    <td><?php echo $branches[$item['id_branch']]['branchcity']; ?></td>
		    <td><?php echo $item['transtype']=='Dr'?$item['amount']:''; ?></td>
                    <td><?php echo $item['transtype']=='Cr'?$item['amount']:''; ?></td>
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