<?php echo $header;?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
</div>

<div id="page-wrapper">
    <div class="row">
        <div class="col-md-12">
            <?php include 'outtruckpayments_search.tpl';?>
            <div class="row">
                <!--<div class="search-container search-row col-md-4">
                    <div class="btn-group btn-group-justified">
                        <a href="#" class="btn btn-danger <?php echo $deletePermClass; ?>" id="btnDelete"><i class="fa fa-trash-o fa-lg"></i> Delete</a>
                    </div>
                </div>--> 
            </div>
        </div>
    </div>

    <div class="row" >
        <form id="horizontalFormList" class="form-horizontal-list" method="post" >
            <h4>Out Truck Trips</h4>
            <div class="col-md-12" id="idGridContainer">
                <!-- grid -->
            </div>
        </form>
        <!-- /.row -->
    </div>
    
    <!-- <div class="row" >
        <form id="horizontalFormListPayments" class="form-horizontal-list-payments" method="post" >
            <h4>Out Truck Payments</h4>
            <div class="col-md-12" id="idGridContainerPayments">
            </div>
        </form>
    </div> -->

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">x</button>
                <h4><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">View</span></h4>
                    <div class="modal-body col-md-12">
                        <div class="col-md-12 table-container">
                        <div><b>Payment Details</b></div>
                        <table class="table table-responsive table-bordered table-condensed table-striped" id="truck_payment_table">
                            <thead>
                                <tr>
                                    <th>PaymentID</th>
                                    <th>Owner</th>
                                    <th>Truck No</th>
                                    <th>Paid On</th>
                                    <th>Payment Mode</th>
                                    <th>Payment Ref</th>
                                    <th>Amount</th>
                                    <th>Branch</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                        </div>
                        
                        <div class="col-md-12 table-container">
                            <div><b>Trips</b></div>
                            <table class="table table-responsive table-bordered table-condensed table-striped" id="truck_payment_trip_table">
                                <thead>
                                    <tr>
                                        <th>TripID</th>
                                        <th>Route</th>
                                        <th>Trans On</th>
                                        <th>Dispatch On</th>
                                        <th>Freight</th>
                                        <th>Shortage</th>
                                        <th>Damage</th>
                                        <th>Lcharge</th>
                                        <th>ULCharge</th>
                                        <th>Adv</th>
                                        <th>POD Amount</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                
                <div class="modal-footer">
                    <!--<button id="btnUpdate" type="submit" class="btn btn-primary " onclick="fnSubmitParty();
                            return false;"><li class="fa fa-pencil fa-fw"></li> Update</button>-->
                </div>
            </div>
        </div>
    </div>
</div>

<script>
var paymentMode=JSON.parse('<?php echo json_encode(getPaymentMode());?>');
    function fnSubmit(btn) {
        var flag = 1;
        var field="";
        
        field="#filter_id_truck";
        if ($(field).val() == "") {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }

        field='#field_nooftrips';
        if ($(field).val() == "" || $('#field_qty').val() == 0) {
            //alert("inside");
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
        
        field='#field_totalpayableamount';
        if ($(field).val() == "" || $('#field_qty').val() == 0) {
            $(field).closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $(field).closest('.col-md-8').removeClass('has-error');
        }
        
        field='#field_paidon';
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
        
        if ($('#field_trips').val() == "") {
            alert("Please select atleast one trip payment");
            var flag = 0;
        }
        
        var submitTo = "<?php echo $route;?>/" + btn;
        //var submitTo="edit";
        //alert(submitTo);
        if (flag) {

            $.ajax({
                url: 'index.php?route=' + submitTo + '&token=<?php echo $token; ?>',
                type: 'post',
                data: $('#horizontalSearchFormFilter').serialize(),
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
                            $("#horizontalSearchFormFilter input[type='text'],select").val("");
                            getList('index.php?route=<?php echo $route; ?>/getlistpayments&token=<?php echo $token; ?>');
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

    $("#idGridContainer").load("index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>", function(responseTxt, statusTxt, xhr){
        if(statusTxt == "error")
            alert("Error: " + xhr.status + ": " + xhr.statusText);
    });
    //$("#idGridContainerPayments").load("index.php?route=<?php echo $route;?>/getlistpayments&token=<?php echo $token; ?>");

function fnTruckPayment(id){
	//alert("value of "+id)
	$.ajax({
		url: 'index.php?route=<?php echo $route;?>/getPaymentDetails&token=<?php echo $token; ?>',
		type: 'post',
		data: "id="+id,
		dataType: 'json',
		beforeSend: function() {
			//removeFlashLoading();
			getFlashLoading();
		},
		complete: function() {
			//alert('complete');

		},
		success: function(json) {
			$('#myModal').modal('show');
			removeFlashLoading();        
			//alert('in success');
			if (json['status']) {
				$('#truck_payment_table tbody').html("<tr><td>"+json['truck']['id_truck_payment']+"</td><td>"+json['truck']['contactname']+"/"+json['truck']['contactmobile']+"</td><td>"+json['truck']['truckno']+"</td><td>"+json['truck']['paidon']+"</td><td>"+paymentMode[json['truck']['paymentmode']]+"</td><td>"+json['truck']['paymentref']+"</td><td>"+json['truck']['totalpayableamount']+"</td><td>"+json['truck']['branchcity']+"</td></tr>");
				var trip_td; 
				$.each(json['trip'],function(key,data){
					//alert("key "+key);
					//alert("data "+data);
					var freight=data['truckrate']*data['qty'];
					var podamount=parseFloat(freight)-(parseFloat(data['shortage'])+parseFloat(data['damage'])+parseFloat(data['loadingexp'])+parseFloat(data['unloadingexp'])+parseFloat(data['driveradvance']));
					//alert(freight+" "+podamount);
					//alert(data['shortage']+" "+data['damage']+" "+data['loadingexp']+" "+data['unloadingexp']+" "+data['driveradvance']);
					trip_td+="<tr><td>"+data['id_trip']+"</td><td>"+data['operatingroutecode']+"</td><td>"+data['transactiondate']+"</td><td>"+data['dispatchdate']+"</td><td>"+freight+"</td><td>"+data['shortage']+"</td><td>"+data['damage']+"</td><td>"+data['loadingexp']+"</td><td>"+data['unloadingexp']+"</td><td>"+data['driveradvance']+"</td><td>"+podamount+"</td></tr>";
				} );
				$('#truck_payment_trip_table tbody').html(trip_td);
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});

}
//$('#myModal').modal('show');
</script>
<?php echo $footer; ?>