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
                        <a href="#" class="btn btn-primary <?php echo $addPermClass; ?>"  onclick="$('#myModal').modal('show');$('#horizontalForm').closest('form').find('input[type=text],input[type=number],input[type=email], textarea,select,radio,checkbox').val('');$('#btnUpdate').addClass('hidden');$('#factory_rates_table tbody').html('');"><i class="fa fa-plus fa-lg"></i>   Create </a>
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
        <?php include 'factories_form.tpl';?>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>

    function fnSubmit(btn) {
        var flag = 1;
	$('#factory_rates_table').find('tr').each(function(){
		if(typeof($("#row_"+$(this).attr('id')+"_id_material").val())!='undefined' && $("#row_"+$(this).attr('id')+"_id_material").val()==""){
			$("#row_"+$(this).attr('id')+"_id_material").css('border-color','red');
			flag=0;
		}else{
			$("#row_"+$(this).attr('id')+"_id_material").css('border-color','');
		}

		if(typeof($("#row_"+$(this).attr('id')+"_id_operating_route").val())!='undefined' && $("#row_"+$(this).attr('id')+"_id_operating_route").val()==""){
			$("#row_"+$(this).attr('id')+"_id_operating_route").css('border-color','red');
			flag=0;
		}else{
			$("#row_"+$(this).attr('id')+"_id_operating_route").css('border-color','');
		}

		if(typeof($("#row_"+$(this).attr('id')+"_priceperton").val())!='undefined' && $("#row_"+$(this).attr('id')+"_priceperton").val()==""){
			$("#row_"+$(this).attr('id')+"_priceperton").css('border-color','red');
			flag=0;
		}else{
			$("#row_"+$(this).attr('id')+"_priceperton").css('border-color','');
		}

		if(typeof($("#row_"+$(this).attr('id')+"_priceperton").val())!='undefined' && $("#row_"+$(this).attr('id')+"_priceperton").val()==""){
			$("#row_"+$(this).attr('id')+"_priceperton").css('border-color','red');
			flag=0;
		}else{
			$("#row_"+$(this).attr('id')+"_priceperton").css('border-color','');
		}
		//console.log($(this).attr('id')+" "+$("#row_"+$(this).attr('id')+"_id_material").val())
	});
	
	
	

        if ($('#field_factorycode').val() == "") {
            //alert("inside");
            $('#field_factorycode').closest('.col-md-8').addClass('has-error');
            flag = 0;
        } else {
            $('#field_factorycode').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_factoryname').val() == "") {
            //alert("inside");
            $('#field_factoryname').closest('.col-md-8').addClass('has-error');
            flag = 0;
        } else {
            $('#field_factoryname').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_factorycontactname').val() == "") {
            //alert("inside");
            $('#field_factorycontactname').closest('.col-md-8').addClass('has-error');
             flag = 0;
        } else {
            $('#field_factorycontactname').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_factorycontactmobile').val() == "") {
            //alert("inside");
            $('#field_factorycontactmobile').closest('.col-md-8').addClass('has-error');
             flag = 0;
        } else {
            $('#field_factorycontactmobile').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_paymentcycle').val() == "") {
            //alert("inside");
            $('#field_paymentcycle').closest('.col-md-8').addClass('has-error');
             flag = 0;
        } else {
            $('#field_paymentcycle').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_paymentmode').val() == "") {
            //alert("inside");
            $('#field_paymentmode').closest('.col-md-8').addClass('has-error');
             flag = 0;
        } else {
            $('#field_paymentmode').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_city').val() == "") {
            //alert("inside");
            $('#field_city').closest('.col-md-8').addClass('has-error');
             flag = 0;
        } else {
            $('#field_city').closest('.col-md-8').removeClass('has-error');
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
                        
			if (btn == 'add') {
                            getList('index.php?route=<?php echo $route; ?>/getlist&token=<?php echo $token; ?>');
			     removeFlashLoading();  
                        }else{
				var parseJsonData=JSON.parse(json['data']);
				$.each(parseJsonData, function (key, data) {
				if(key=='status'){
					var field_status=data?'<i class="fa fa-star" aria-hidden="true"></i>':'<i class="fa fa-star-o" aria-hidden="true"></i>';
					$('#list_status_' + type).html(field_status);

					return true;
				}
				//console.log(key+"="+data);
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
</script>
<?php echo $footer; ?>