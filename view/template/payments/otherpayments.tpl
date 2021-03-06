<?php echo $header;?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">
    <div class="row">
        <div class="col-md-12">
            <?php include 'otherpayments_add.tpl';
            //include 'otherpayments_search.tpl';?>
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

<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.css"/>
<script src="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.js"></script>
<script type="text/javascript">
$('#field_transactiondate').datetimepicker({
	dayOfWeekStart: 1,
	lang: 'en',
	format: 'Y-m-d H:i',
	startDate: '<?php echo date("Y/m/d H:i"); ?>'	//'2015/09/01'
});

    function fnSubmit(btn) {
        var flag = 1;
        var field="";
        
        field="#field_particulars";
	
        if ($(field).val() == "") {
		//alert($(field).val());
	    $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }

        field='#field_id_branch';
        if ($(field).val() == "" || $('#field_qty').val() == 0) {
            //alert("inside");
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
        
        field='#field_narration';
	if ($(field).val() == "" || $('#field_qty').val() == 0) {
           //alert($(field).val());
	    $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
        
        field='#field_transactiondate';
        if ($(field).val() == "") {
	//	alert($(field).val());
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
        
        field="#field_transactiontype";
	
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }

	field="#field_paymentmode";
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
	
	field="#field_id_branch";
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
	
	field="#field_amount";
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }

        var submitTo = "<?php echo $route;?>/" + btn;
        //var submitTo="edit";
        //alert(submitTo);
        if (flag) {

            $.ajax({
                url: 'index.php?route=' + submitTo + '&token=<?php echo $token; ?>',
                type: 'post',
                data: $('#horizontalAddFormFilter').serialize(),
                dataType: 'json',
                beforeSend: function() {
                    //alert('before send');
                    removeFlashLoading();
                    getFlashLoading();
                },
                complete: function() {
                    //alert('complete');

                },
                success: function(json) {
                    removeFlashLoading();        
                    //alert('in success');
                    if (json['status']) {
                        if (btn == 'add') {
                            getList('index.php?route=<?php echo $route; ?>/getlist&token=<?php echo $token; ?>');
			    removeFlashLoading();  
                            $("#horizontalAddFormFilter input[type='text'],select,textarea").val("");
                            //getList('index.php?route=<?php echo $route; ?>/getlistpayments&token=<?php echo $token; ?>');
                        }
                        //removeFlashLoading();
                        getFlashWrapper('success', json['msg']);
                    } else {
                        //$('#page-wrapper').before(getFlashWrapper('danger',json['msg']));
                        getFlashWrapper('danger', json['msg']);
                    }
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });

        } else {
            //alert("in else")
            return false;
        }
    }

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

    $("#idGridContainer").load("index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>");
 </script>
<?php echo $footer; ?>