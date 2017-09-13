<?php echo $header;?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">
    <div class="row">
        <div class="col-md-8">
            <?php //include '_materials_search.tpl';?>
            <div class="row">
                <div class="search-container search-row col-md-4">
                    <div class="btn-group btn-group-justified">
                        <a href="#" class="btn btn-primary <?php echo $addPermClass; ?>"  onclick="fnAdd()"><i class="fa fa-plus fa-lg"></i>   Create </a>
                    </div>
                </div>
		<div class="search-container search-row col-md-4">
                    <div class="btn-group btn-group-justified">
                        <a href="#" class="btn btn-danger <?php echo $deletePermClass; ?>" id="btnDelete"><i class="fa fa-trash-o fa-lg"></i> Delete</a>
                    </div>
                </div> 
            </div>
        </div>
    </div>

    <div class="row" >
        <form id="horizontalFormList" class="form-horizontal-list" method="post" >
            <div class="col-md-12" id="idGridContainer">
                <!-- grid -->
            </div>
        </form>
        <?php include 'stores_form.tpl';?>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>

var stockItemsJson=JSON.parse('<?php echo json_encode($storeitems);?>');
var stockItemsOption={};
    function fnSubmit(btn) {
        var flag = 1;
        var field="";
	
	field="#field_id_store_vendor";
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
        
        field="#field_datepurchased";
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
        
        field="#field_amount";
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
        
        field="#field_id_branch_store";
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
        
        field="#field_id_branch_payment";
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }

        var type = $('#pkey').val();
        var submitTo = "<?php echo $route;?>/" + btn;
        //var submitTo="edit";
        //alert(submitTo);
        if (flag) {

            $.ajax({
                url: 'index.php?route=' + submitTo + '&token=<?php echo $token; ?>',
                type: 'post',
                data: $('#horizontalForm').serialize(),
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
		    $('#myModal').modal('hide');
                    //alert('in success');
                    if (json['status']) {
                        $('#pkey').val("");
                        if (btn == 'add') {
                            getList('index.php?route=<?php echo $route; ?>/getlist&token=<?php echo $token; ?>');
			     removeFlashLoading();  
                        }else{
				var parseJsonData=JSON.parse(json['data']);
				$.each(parseJsonData, function (key, data) {
					$('#list_'+key+'_' + type).html(data);
				});
				$('#list_editbtn_'+type).attr('data-fulltext',json['data']);
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
    
   function fnAdd(){
        $('#myModal').modal('show');
        $('#horizontalForm').closest('form').find('input[type=text], textarea,select,radio,checkbox').val('');
        $('#btnUpdate').addClass('hidden');
        fnGetStoreItems();
         $('#store_items_table tbody').html("");
        $('#btnCreate').show();
    } 
</script>
<?php echo $footer; ?>