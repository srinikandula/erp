<?php echo $header;?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">
    <div class="row">
        <div class="col-md-12">
            <?php include 'paymentstmt_search.tpl';?>
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
        <?php include 'paymentstmt_form.tpl';?>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>
var paymentMode=JSON.parse('<?php echo json_encode(getPaymentMode());?>');
function fnAdd(){

	$('#myModal').modal('show');
	$("#trip_details_table tbody").html("<tr id='row_trip_no' ><td colspan='12'>No Trips Found</td></tr>");
	$("#trip_details_table th:last-child, #trip_details_table td:last-child").show();
	$("#getTripsButton").html("<button name='btnGettrips' id='btnGettrips' type='button' class='btn btn-primary' >Get Trips</button>");
	$('#horizontalForm').closest('form').find('input[type=text], textarea,select,radio,checkbox').val('');
	$('#btnUpdate').hide();
	$('#btnCreate').show();
	$('#span_id_factory_payment').html('');
}

var factoriesJson=JSON.parse('<?php echo json_encode($factories);?>');
//alert(factoriesJson[2]['id_factory']);

    $("#field_id_factory").on('change', function() {
        var id_factory=$("#field_id_factory").val();
	$("#field_paymentcycle").val(factoriesJson[id_factory]['paymentcycle']);
	calPayment();
    });

    function fnSubmit(btn) {
        var flag = 1;

        if ($('#field_datefrom').val() == "") {
            //alert("inside");
            $('#field_datefrom').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_datefrom').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_billgendate').val() == "") {
            //alert("inside");
            $('#field_billgendate').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_billgendate').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_dateto').val() == "") {
            //alert("inside");
            $('#field_dateto').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_dateto').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_id_factory').val() == "") {
            //alert("inside");
            $('#field_id_factory').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_id_factory').closest('.col-md-8').removeClass('has-error');
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
			
                        //reset form

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
//$('#myModal').modal('show');


$("#btnGettrips").on('click',function(){
        var datefrom=$('#field_datefrom').val();
        var dateto=$('#field_dateto').val();
        var id_factory=$('#field_id_factory').val();
        var flag=1;
        if(datefrom=="" || dateto==""){
            flag=0;
            alert("Date From and Date TO are mandatory!!");
        }
        //alert("value of "+id_factory);
        if(id_factory==""){
            flag=0;
            alert("Please select Factory!!");
        }

	if(flag){
		$.ajax({
		url: 'index.php?route=<?php echo $route;?>/getTrips&token=<?php echo $token; ?>',
		type: 'post',
		data: "datefrom="+datefrom+"&dateto="+dateto+"&id_factory="+id_factory,
		dataType: 'json',
		beforeSend: function() {
			//removeFlashLoading();
			//getFlashLoading();
			$('#btnGettrips').html('Get Trips<i class="fa fa-cog fa-spin fa-1x fa-fw"></i>');
		},
		complete: function() {
			//alert('complete');

		},
		success: function(json) {
			$('#btnGettrips').html('Get Trips');
			//removeFlashLoading();        
			//alert('in success');
			if (json['status']) {

				if(json['data']['totalTrips']){
					$('#trip_details_table tbody').html("");
					$('#field_totaltrips').val(json['data']['totalTrips']);
					$('#field_freight').val(json['data']['totalFreight']);
					$('#field_toll').val(json['data']['totalToll']);
					$('#field_loading').val(json['data']['totalLoading']);
					$('#field_unloading').val(json['data']['totalUnloading']);
					$('#field_shortage').val(json['data']['totalShortage']);
					$('#field_damage').val(json['data']['totalDamage']);
					$('#field_wait_charges').val(json['data']['totalWait']);
					$('#field_ext_unload_charges').val(json['data']['totalExtUnloading']);
					
					$('#row_trip_no').remove();
					$.each(json['data']['trips'],function(k,data){
						populateTrips(data);
					});
					calPayment();
				}else{
					$('#trip_details_table tbody').html("<tr id='row_trip_no' ><td colspan='12'>No Trips Found</td></tr>");

				}

				//getFlashWrapper('success', json['msg']);
			} else {
				 //getFlashWrapper('danger', json['msg']);
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
		});
	}

    });

    /*$(".btn-default").on('click',function(){
	alert("hello");
    });*/

    function populateTrips(data){
	//alert(data['wait_charges']+ " " + data['ext_unload_charges'])
	$('#trip_details_table tbody').append("<tr id='tripRow_"+data['id_trip']+"'><td><input type='hidden' name='trip[]' value='"+JSON.stringify(data)+"'>"+data['id_trip']+"</td><td>"+data['truckno']+"</td><td>"+data['dispatchdate']+"</td><td>"+data['operatingroutecode']+"</td><td>"+data['freight']+"</td><td>"+data['qty']+"</td><td>"+data['shortage']+"</td><td>"+data['damage']+"</td><td>"+data['tollcharge']+"</td><td>"+data['loadingcharge']+"</td><td>"+data['unloadingcharge']+"</td><td>"+data['wait_charges']+"</td><td>"+data['ext_unload_charges']+"</td><td><i class='fa fa-trash-o' onclick='fnTripDelete("+JSON.stringify(data)+")'></i></td></tr>");
    }

    function fnTripDelete(jData){
	
	$("#tripRow_"+jData['id_trip']).remove();
	var totaltrips=parseInt($('#field_totaltrips').val());
	var totalfreight=parseFloat($('#field_freight').val());
	var totalshortage=parseFloat($('#field_shortage').val());
	var totaldamage=parseFloat($('#field_damage').val());
	var totaltoll=parseFloat($('#field_toll').val());
	var totalloading=parseFloat($('#field_loading').val());
	var totalunloading=parseFloat($('#field_unloading').val());

	var wait_charges=parseFloat($('#field_wait_charges').val());
	var ext_unload_charges=parseFloat($('#field_ext_unload_charges').val());
	
	$('#field_trips').val(totaltrips-1);
	$('#field_freight').val(totalfreight-jData['freight']);
	$('#field_shortage').val(totalshortage-jData['shortage']);
	$('#field_damage').val(totaldamage-jData['damage']);
	$('#field_toll').val(totaltoll-jData['tollcharge']);
	$('#field_loading').val(totalloading-jData['loadingcharge']);
	$('#field_unloading').val(totalunloading-jData['unloadingcharge']);

	$('#field_wait_charges').val(wait_charges-jData['wait_charges']);
	$('#field_ext_unload_charges').val(ext_unload_charges-jData['ext_unload_charges']);
	
	
	calPayment();
    }

</script>
<?php echo $footer; ?>