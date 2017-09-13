<?php echo $header;?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $info['page']['title']; ?></span>
</div>

<div id="page-wrapper">
    <div class="row">
        <div class="col-md-12">
            <?php include 'truckreport_search.tpl';?>
        </div>
    </div>

    <div class="row" >
        <form id="horizontalFormList" class="form-horizontal-list" method="post" >
            <h4><?php echo $info['page']['title']; ?></h4>
            <div class="col-md-12" id="idGridContainer">

	    <!-- start -->
<?php $icon[1]='<i class="fa fa-check" aria-hidden="true"></i>';   $icon[0]='<i class="fa fa-times" aria-hidden="true"></i>';?>
<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
	<th >S.No</th>
	<?php if($truckdata=='T' || $truckdata==''){?>
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
	<?php }else if($truckdata=='D'){?>
	    <th >Date</th>
	    <th >Truck No</th>
            <th >Trip ID</th>
	    <th >Load Provider</th>
	    <th >Company</th>
	    <th >Route</th>
	    <th >Driver</th>
            <th >Freight</th>
	    <th >Fuel Station</th>
	    <th >Diesel Qty</th>
	    <th >Pricer Per Ltr</th>
	    <th >Amount</th>
	<?php }else if($truckdata=='M'){?>
	    <th >Date</th>
	    <th >Truck No</th>
            <th >Price</th>
	    <th >Description</th>
	<?php }?>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {
		    foreach ($items as $k => $item) { //$truckType=$item['own']==0?'(Out)':''; ?>
		<tr >
                    <td><?php echo $item['sno'];?></td>
                    <?php if($truckdata=='' || $truckdata=='T'){?>
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
		    <?php }if($truckdata=='D'){?>
		    <td ><?php echo  date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])); ?></td>
                    <td ><?php echo $item['truckno']; ?></td>
		    <td ><?php echo $item['id_trip']; ?></td>
		    <td ><?php echo $item['loadprovider']=='TR'?'Transporter':'Factory'; ?></td>
		    <td ><?php echo $item['loadprovider']=='TR'?$item['transporter']:$item['factoryname']; ?></td>
                    <td ><?php echo $item['operatingroutecode']; ?></td>
		    <td ><?php echo $item['drivername'].'/'.$item['drivermobile']; ?></td>
		    <td ><?php echo $item['loadprovider']=='TR'?$item['qty']*$item['truckrate']:$item['qty']*$item['billrate']; ?></td>
		    <td ><?php echo $item['fuelstationname']==""?$item['regfuelstation']:$item['fuelstationname']; ?></td>
		    <td ><?php echo $item['fuelqty']; ?></td>
		    <td ><?php echo $item['priceperltr']; ?></td>
		    <td ><?php echo $item['amount']; ?></td>
		    <?php }else if($truckdata=='M'){?>
		    <td ><?php echo  date(FORMAT_DATETIME_FORMAT, strtotime($item['dateon'])); ?></td>
                    <td ><?php echo $item['truckno']; ?></td>
		    <td ><?php echo $item['price']; ?></td>
		    <td ><?php echo $item['description']; ?></td>
		    <?php }?>
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
	    <!-- end -->
                <!-- grid -->
            </div>
        </form>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>
    /*$("#idGridContainer").on("click", "a", function(e) {
        e.preventDefault();
        getList(this.href);
    });*/

    $("#btnDelete").on("click", function(e) {
        e.preventDefault();
        var data = $('form#horizontalFormList').serialize();
        if (data != "") {
            fnBulkAction('index.php?route=<?php echo $route;?>/delete&token=<?php echo $token; ?>', 'index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>', data);
        }else{
		removeFlashLoading()
		getFlashWrapper('danger','No rows selected,Please select atleast one!')

	}
    });

    //$("#idGridContainer").load("index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>");
 </script>
<?php echo $footer; ?>