<?php echo $header;?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">
    <div class="row">
        <div class="col-md-12">
            <?php //include 'otherpayments_add.tpl';
            include 'bankstatement_search.tpl';?>
            <!--<div class="row">
                <div class="search-container search-row col-md-2">
                    <div class="btn-group btn-group-justified">
                        <a href="#" class="btn btn-danger <?php echo $deletePermClass; ?>" id="btnDelete"><i class="fa fa-trash-o fa-lg"></i> Delete</a>
                    </div>
                </div> 
            </div>-->
        </div>
    </div>

    <div class="row" >
        <form id="horizontalFormList" class="form-horizontal-list" method="post" >
            <h4><?php echo $page['title']; ?></h4>
            <div class="col-md-12" id="idGridContainer">
                <!-- grid -->
            </div>
        </form>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.css"/>
<script src="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.js"></script>
<script type="text/javascript">
$('#field_transactiondate').datetimepicker({
	dayOfWeekStart: 1,
	lang: 'en',
	format: 'Y-m-d H:i',
	startDate: '<?php echo date("Y/m/d H:i"); ?>'	//'2015/09/01'
});

    $("#idGridContainer").on("click", "a", function(e) {
        e.preventDefault();
        getList(this.href);
    });

    $("#btnDelete").on("click", function(e) {
/*	$('#listMasterTable').find('tr').each(function(){

		console.log($(this).attr('id'))

})*/
	/*var ids=[];
        $('.mtable table table-striped table-bordered table-responsive table-condensed table-hover').each(function(){
          ids.push($(this).find('tr').attr('id'))
        })
	alert(ids)
	    return false;*/
        e.preventDefault();
        var data = $('form#horizontalFormList').serialize();
        if (data != "") {
            fnBulkAction('index.php?route=<?php echo $route;?>/delete&token=<?php echo $token; ?>', 'index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>', data);
        }else{
		removeFlashLoading()
		getFlashWrapper('danger','No rows selected,Please select atleast one!')

	}
    });

   // $("#idGridContainer").load("index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>");
 </script>
<?php echo $footer; ?>