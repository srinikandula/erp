<?php $icon[1]='<i class="fa fa-check" aria-hidden="true"></i>';   $icon[0]='<i class="fa fa-times" aria-hidden="true"></i>';?>
<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
	<?php if($truckdata=='T' || $truckdata==''){?>
            <th >S.No</th>
	    <th >Date</th>
	    <th >Truck No</th>
            <th >Trip ID</th>
	    <th >Load Provider</th>
	    <th >Company</th>
	    <th >Route</th>
	    <th >Driver</th>
            <th >Freight</th>
	    <th >Diesel</th>
	    <th >Repairs</th>
	    <th >Repair Comment</th>
	<?php }?>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {
		    foreach ($items as $k => $item) { $truckType=$item['own']==0?'(Out)':''; ?>
		<tr >
                    <td><?php echo $item['sno'];?></td>
                    <td ><?php echo  date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])); ?></td>
                    <td ><?php echo $item['truckno']; ?></td>
		    <td ><?php echo $item['id_trip']; ?></td>
		    <td ><?php echo $item['loadprovider']=='TR'?'Transporter':'Factory'; ?></td>
		    <td ><?php echo $item['loadprovider']=='TR'?$item['transporter']:$item['factoryname']; ?></td>
                    <td ><?php echo $item['operatingroutecode']; ?></td>
		    <td ><?php echo $item['drivername'].'/'.$item['drivermobile']; ?></td>
		    <td ><?php echo $item['loadprovider']=='TR'?$item['qty']*$item['truckrate']:$item['qty']*$item['billrate']; ?></td>
		    <td ><?php echo $item['dieselexp']; ?></td>
		    <td ><?php echo $item['repairexp']; ?></td>
		    <td ><?php echo $item['repairexpcomment']; ?></td>
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