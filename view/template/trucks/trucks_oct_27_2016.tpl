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
                        <a href="#" class="btn btn-primary <?php echo $addPermClass; ?>"  onclick="$('#myModal').modal('show');$('#horizontalForm').closest('form').find('input[type=text], textarea,select,radio,checkbox').val('');$('#btnUpdate').addClass('hidden');"><i class="fa fa-plus fa-lg"></i>   Create </a>
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
        <?php include 'trucks_form.tpl';?>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>

    function fnSubmit(btn) {
        var flag = 1;

        if ($('#field_truckno').val() == "") {
            //alert("inside");
            $('#field_truckno').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_truckno').closest('.col-md-8').removeClass('has-error');
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
                        $('#list_truckno_' + type).html($('#field_truckno').val());
                        $('#list_id_truck_type_' + type).html($('#field_id_truck_type option[value="'+$('#field_id_truck_type').val()+'"]').text());
			$('#list_engineno_' + type).html($('#field_engineno').val());
			$('#list_chessisno_' + type).html($('#field_chessisno').val());
			
			var field_own=$('#field_own').prop('checked')?'<i class="fa fa-check" aria-hidden="true"></i>':'<i class="fa fa-times" aria-hidden="true"></i>';
			$('#list_own_' + type).html(field_own);
			$('#list_id_admin_role_' + type).html($('#field_id_admin_role').val());
			$('#list_make_' + type).html($('#field_make').val());

			$('#list_makeyear_' + type).html($('#field_makeyear').val());
			$('#list_model_' + type).html($('#field_model').val());
			$('#list_dateinservice_' + type).html($('#field_dateinservice').val());
			$('#list_fitnessexpdate_' + type).html($('#field_fitnessexpdate').val());
			$('#list_hubservicedate_' + type).html($('#field_hubservicedate').val());
			$('#list_insuranceexpdate_' + type).html($('#field_insuranceexpdate').val());
			$('#list_nationalpermitexpdate_' + type).html($('#field_nationalpermitexpdate').val());
			$('#list_pollutionexpdate_' + type).html($('#field_pollutionexpdate').val());
			$('#list_taxpayabledate_' + type).html($('#field_taxpayabledate').val());
			$('#list_editbtn_'+type).attr('data-fulltext',json['data']);

			
                        //reset form

                        $('#pkey').val("");
                        if (btn == 'add') {
                            getList('index.php?route=<?php echo $route; ?>/getlist&token=<?php echo $token; ?>');
			     removeFlashLoading();  
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
</script>
<?php echo $footer; ?>