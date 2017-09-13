<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th >S.No</th>
            <th >Date</th>
	    <th >Type</th>
	    <th >Particulars</th>
	    <th >Narration</th>
	    <th >Branch</th>
            <th >Deposit (Cr)</th>
	    <th >Withdrawal (Dr)</th>
	    
        </tr>
    </thead>
    <tbody>
        <?php 
	//echo '<pre>';print_r($items);echo '</pre>';
	if ($items) {  
		    $totalCr=0;
		    $totalDr=0;
                    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>"  >
                    <td><?php echo $item['sno']; ?></td>
                    <td><?php echo date(FORMAT_DATETIME_FORMAT, strtotime($item['transdate'])); ?></td>
		    <td><?php echo $item['transtype']; ?></td>
                    
		    <td><?php echo $item['particulars']; ?></td>
		    <td><?php echo $item['narration']; ?></td>
                    <td><?php  if($item['id_branch']=='-1'){
			echo 'considered as advance given to driver by HQ Branch';
                    }else{
		    echo isset($branches[$item['id_branch']]['branchcity'])?$branches[$item['id_branch']]['branchcity']:''; } ?></td>
		    <td><?php if(strtolower($item['transtype'])=='cr'){echo $item['amount']; $totalCr+=$item['amount'];}else{ echo '';}; ?></td>
		    <td><?php if(strtolower($item['transtype'])=='dr'){echo $item['amount']; $totalDr+=$item['amount'];}else{ echo '';};//echo strtolower($item['transtype'])=='dr'?$item['amount']:''; ?></td>
                </tr>
        <?php } ?>
		<tr><td colspan="6" class="btn-info">Total</td><td class="btn-success"><?php echo number_format($totalCr,2);?></td><td class="btn-danger"><?php echo number_format($totalDr,2);?></td></tr>
		<tr><td colspan="6"  class="btn-info">Available</td><td colspan="2" class="btn-warning"><?php echo number_format($totalCr-$totalDr,2);?></td></tr>
        <?php } else { ?>
            <tr>
                <td class="text-center" colspan="8">No Data Available</td>
            </tr>
        <?php } ?>
    </tbody>
</table>
<?php include(DIR_TEMPLATE.'common/_pagination.tpl');?>