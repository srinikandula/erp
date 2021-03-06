<?php echo $header;?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">
    <div class="row">
        <div class="col-md-12">
            <?php include 'trips_search.tpl';?>
            <div class="row">
                <div class="search-container search-row col-md-2">
                    <div class="btn-group btn-group-justified">
                        <a href="#" class="btn btn-primary <?php echo $addPermClass; ?>"  onclick="fnAdd()"><i class="fa fa-plus fa-lg"></i>   Create </a>
                    </div>
                </div>
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
            <div class="col-md-12" id="idGridContainer">
                <!-- grid -->
            </div>
        </form>
        <?php include 'trips_form.tpl';?>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>
 var fratesJson=JSON.parse('<?php echo json_encode($fratesById);?>');
var driversJson=JSON.parse('<?php echo json_encode($drivers);?>');
var operatingroutesJson=JSON.parse('<?php echo json_encode($operatingroutes);?>');

    function fnAdd(){
	$('#myModal').modal('show');
	$('#horizontalForm').closest('form').find('input[type=text], textarea,select,radio').val('');
	//$('#horizontalForm').closest('form').find('checkbox').prop('checked',false);//alert("hello");
	$('#field_ispodsubmitted').prop('checked',false);
	$('#field_ispodreceived').prop('checked',false);
	$('#field_ispodsubmitted').prop('checked',false);
	$('#field_traveltype').prop('checked',false);
	$('#btnUpdate').addClass('hidden');
	$('#btnCreate').removeClass('hidden');
	$('#tripCode').html('Pending Generate!!');
	$('#info-box-or').html('');
	$('#span_id_truck').html("");
	own();
    }


    function fnSubmit(btn) {
        var flag = 1;
	var field="";
	
	field="#field_transactiondate";
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
	
	field="#field_dispatchdate";
	if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
	
	field="#field_loadprovider";
	var lp=$(field).val();
	if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }

	if($('#field_own').prop('checked')){
		field="#field_id_driver";
		var lp=$(field).val();
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}	
	}else{
		field="#field_id_driver_text";
		var lp=$(field).val();
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}
	}

	if(lp=='TR'){
		field="#field_id_transporter";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}

		field="#field_id_operating_route";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}

		field="#field_material";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}

		field="#field_truckrate";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}

	} else if(lp=='FT'){
		field="#field_id_factory";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}

		field="#field_id_factory_route_material";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}

		field="#field_billrate";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}

	}


		field="#field_id_truck";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}

		field="#field_id_driver_mobile";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}


		field="#field_driveradvance";
		if ($(field).val() == "") {
		    $(field).closest('.col-md-8').addClass('has-error');
		    var flag = 0;
		} else {
		    $(field).closest('.col-md-8').removeClass('has-error');
		}
		
		field="#field_qty";
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
				if(parseJsonData['loadprovider']=='FT'){
					$('#list_transporter_' + type).html(parseJsonData['factoryname']);
				}

				var ownHtml=parseJsonData['own']=='1'?'<i class="fa fa-check" aria-hidden="true"></i>':'<i class="fa fa-times" aria-hidden="true"></i>';
				var traveltypeHtml=parseJsonData['traveltype']=='1'?'<i class="fa fa-check" aria-hidden="true"></i>':'<i class="fa fa-times" aria-hidden="true"></i>';
				$('#list_own_' + type).html(ownHtml);
				$('#list_traveltype_' + type).html(traveltypeHtml);
				
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
</script>
<?php echo $footer; ?>