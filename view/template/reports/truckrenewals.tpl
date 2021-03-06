<?php echo $header;?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">
    <div class="row">
        <div class="col-md-12">
            <?php include 'truckrenewals_search.tpl';?>
            <div class="row">
                <div class="search-container search-row col-md-2">
                    <div class="btn-group btn-group-justified">
                        <a href="#" class="btn btn-danger <?php echo $deletePermClass; ?>" id="btnDelete"><i class="fa fa-trash-o fa-lg"></i> Delete</a>
                    </div>
                </div> 
            </div>
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

<script>
    $("#idGridContainer").on("click", "a", function(e) {
        e.preventDefault();
        getList(this.href);
    });

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

    $("#idGridContainer").load("index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>");
 </script>
<?php echo $footer; ?>