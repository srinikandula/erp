<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <th >S.No</th>
            <th >Settlement Date</th>
	    <th >Payment Date</th>
	    <th >Driver</th>
	    <th >From Date</th>
	    <th >To Date</th>
	    <th >Payment Branch</th>
            <th >Comment</th>
	    <th >Closed</th>
	    <th >Days Paid</th>
            <th >Batta</th>
            <th >Per Trip Freight Percent</th>
	    <th >Per Trip Commission</th>
            <th >Fixed Pay</th>
	    <th >Total Trips</th>
	    <th >Total Freight</th>
	    <th >Total Adv</th>
	    <th >Total Trip Exp</th>
	    <th >Total Shortage</th>
	    <th >Total Damage</th>
	    <th >Total Oil Shortage</th>
	    <th >Total Amount</th>
	</tr>
    </thead>
    <tbody>
        <?php if ($items) {
		    $icon[1]='<i class="fa fa-check" aria-hidden="true"></i>';
		    $icon[0]='<i class="fa fa-times" aria-hidden="true"></i>';
		    foreach ($items as $k => $item) {  ?>
            <tr  >
                    <td><?php echo $item['sno'];?></td>
                    <td ><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['settlementdate'])); ?></td>
		    <td ><?php echo  $item['paidon']!='0000-00-00'?date(FORMAT_DATETIME_FORMAT, strtotime($item['paidon'])):''; ?></td>
                    <td ><?php echo $item['drivername']; ?></td>
		    <td ><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['datefrom'])); ?></td>
                    <td ><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['dateto'])); ?></td>
		    <td ><?php echo $item['branchcity']; ?></td>
		    <td ><?php echo $item['comment']; ?></td>
		    <td ><?php echo $icon[$item['closed']]; ?></td>
		    <td ><?php echo $item['dayspaid']; ?></td>
		    <td ><?php echo $item['batta']; ?></td>
		    <td ><?php echo $item['pertrippercentonfreight']; ?></td>
                    <td ><?php echo $item['pertripcommission']; ?></td>
                    <td ><?php echo $item['fixedpermonth']; ?></td>
		    <td ><?php echo $item['totaltrips']; ?></td>
		    <td ><?php echo $item['totalfreight']; ?></td>
		    <td ><?php echo $item['totaladvance']; ?></td>
		    <td ><?php echo $item['totaltripexp']; ?></td>
		    <td ><?php echo $item['totalshortage']; ?></td>
		    <td ><?php echo $item['totaldamage']; ?></td>
		    <td ><?php echo $item['totaloilshortage']; ?></td>
		    <td ><?php echo $item['totalpayableamount']; ?></td>
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