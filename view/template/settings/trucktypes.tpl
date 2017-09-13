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
                        <a href="#" class="btn btn-danger <?php echo $deletePermClass; ?>" id="btnDelete"><i class="fa fa-trash-o fa-lg"></i> Delete</a>
                    </div>
                </div> 
            </div>
        </div>
    </div>

    <div class="row" >
        <form id="horizontalFormList" class="form-horizontal-list" method="post" >
            <div class="col-md-9" id="idGridContainer">
                <!-- grid -->
            </div>
        </form>
        <?php include '_trucktypes_form.tpl';?>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>
    function fnSubmit(btn) {
        var flag = 1;

        if ($('#field_trucktype').val() == "") {
            //alert("inside");
            $('#field_trucktype').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_trucktype').closest('.col-md-8').removeClass('has-error');
        }

        if ($('#field_tons').val() == "") {
            //alert("inside");
            $('#field_tons').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_tons').closest('.col-md-8').removeClass('has-error');
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
                    //alert('in success');
                    if (json['status']) {
			
                        if (btn == 'add') {
                            getList('index.php?route=<?php echo $route; ?>/getlist&token=<?php echo $token; ?>');
			     removeFlashLoading();  
                        }
			var parseJsonData=JSON.parse(json['data']);
			$.each(parseJsonData, function (key, data) {
			$('#list_'+key+'_' + type).html(data);
			});

			$('#list_editbtn_'+type).attr('data-fulltext',json['data']);
			$('#horizontalForm').closest('form').find('input[type=text], textarea,select,radio,checkbox').val('');
                        $('#pkey').val("");
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
</script>
<?php echo $footer; ?>