<?php echo $header;
//echo '<pre>';print_r($page);echo '</pre>';

?>
<div class="page-heading">
    <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title']; ?></span>
    <div style="float:right;padding:0px 2px 2px; 10px"><span class="btn-success btn-xs">Salaries Closed</span> <!-- <span class="btn-warning btn-xs">TR Pending Bill</span> <span class="btn-danger btn-xs">O/S Trips</span> --></div>
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
        <?php include 'salarystmt_form.tpl';?>
        <!-- /.row -->
    </div>

    <!-- /.container-fluid -->
</div>
<!-- /#page-wrapper -->

<script>

var branchesJson=JSON.parse('<?php echo json_encode($branches);?>');

function fnAdd(){
	$('#myModal').modal('show');
	$('#horizontalForm').closest('form').find('input[type=text], textarea,select,radio').val('');
	//$('#horizontalForm').closest('form').find('checkbox').attr('checked',false);
	$("#trip_details_table tbody").html("<tr id='row_trip_no' ><td colspan='12'>No Trips Found</td></tr>");
	$("#trip_details_table th:last-child, #trip_details_table td:last-child").show();
	$("#getTripsButton").html("<button name='btnGettrips' id='btnGettrips' type='button' class='btn btn-primary' >Get Trips</button>");
	$('#btnUpdate').hide();
	$('#btnCreate').show();
	
	$('#field_paidby_id_branch').html("");
	$.each(branchesJson, function(key, value) {
	     $('#field_paidby_id_branch')
		 .append($("<option></option>")
			    .attr("value",value['id_branch'])
			    .text(value['branchcity'])); 
	});

}

var driversJson=JSON.parse('<?php echo json_encode($drivers);?>');
    function fnSubmit(btn) {
        var flag = 1;

        if ($('#field_datefrom').val() == "") {
            //alert("inside");
            $('#field_datefrom').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_datefrom').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_settlementdate').val() == "") {
            //alert("inside");
            $('#field_settlementdate').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_settlementdate').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_dateto').val() == "") {
            //alert("inside");
            $('#field_dateto').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_dateto').closest('.col-md-8').removeClass('has-error');
        }

	if ($('#field_id_driver').val() == "") {
            //alert("inside");
            $('#field_id_driver').closest('.col-md-8').addClass('has-error');
            var flag = 0;
        } else {
            $('#field_id_driver').closest('.col-md-8').removeClass('has-error');
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
	//alert("value of "+days);
        var datefrom=$('#field_datefrom').val();
        var dateto=$('#field_dateto').val();
        var id_driver=$('#field_id_driver').val();
        var flag=1;
        if(datefrom=="" || dateto==""){
            flag=0;
            alert("Date From and Date TO are mandatory!!");
        }
        //alert("value of "+id_driver);
        if(id_driver==null){
            flag=0;
            alert("Please select driver!!");
        }

	if(flag){
	    var diff = new Date(new Date(dateto) - new Date(datefrom));
            var days=(diff/1000/60/60/24)+1;

		$.ajax({
		url: 'index.php?route=<?php echo $route;?>/getTrips&token=<?php echo $token; ?>',
		type: 'post',
		data: "salarydays="+days+"&datefrom="+datefrom+"&dateto="+dateto+"&id_driver="+id_driver,
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
					//alert(json['data']['totalBatta']);
					$('#trip_details_table tbody').html("");
					$('#triptotal_totalleaves').val(json['data']['totalLeaves']);
					$('#field_batta').val(json['data']['totalBatta']);
					$('#field_dayspaid').val(json['data']['totalPaidDays']);
					
					$('#triptotal_totaltrips').val(json['data']['totalTrips']);
					$('#triptotal_totalfreight').val(json['data']['totalFreight']);
					$('#triptotal_totaladv').val(json['data']['totalAdv']);
					$('#triptotal_totaltripexp').val(json['data']['totalTripExp']);
					$('#triptotal_totalshortage').val(json['data']['totalShortage']);
					$('#triptotal_totaldamage').val(json['data']['totalDamage']);
					$('#triptotal_totaloilshortage').val(json['data']['totalOilShortage']);
					//$('#field_batta').val(json['data']['totalOilShortage']);
					$('#row_trip_no').remove();
					$.each(json['data']['trips'],function(k,data){
						populateTrips(data);
					});
					calPayment();
				}else{
					$('#trip_details_table tbody').html("<tr id='row_trip_no' ><td colspan='9'>No Trips Found</td></tr>");

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
	//<td>"+data['batta']+"</td>
	$('#trip_details_table tbody').append("<tr id='tripRow_"+data['id_trip']+"'><td><input type='hidden' name='trip[]' value='"+JSON.stringify(data)+"'>"+data['id_trip']+"</td><td>"+data['truckno']+"</td><td>"+data['dispatchdate']+"</td><td>"+data['operatingroutecode']+"</td><td>"+data['driveradvance']+"</td><td>"+data['tripexpense']+"</td><td>"+data['shortage']+"</td><td>"+data['damage']+"</td><td>"+data['oilshortage']+"</td><td><i class='fa fa-trash-o' onclick='fnTripDelete("+JSON.stringify(data)+")'></i></td></tr>");
	}

    function fnTripDelete(jData){
	
	$("#tripRow_"+jData['id_trip']).remove();
	var totaltrips=$('#triptotal_totaltrips').val();
	var totalfreight=$('#triptotal_totalfreight').val();
	var totaladv=$('#triptotal_totaladv').val();
	var totaltripexp=$('#triptotal_totaltripexp').val();
	var totalshortage=$('#triptotal_totalshortage').val();
	var totaldamage=$('#triptotal_totaldamage').val();
	var totaloilshortage=$('#triptotal_totaloilshortage').val();

	$('#triptotal_totaltrips').val(totaltrips-1);
	$('#triptotal_totalfreight').val(totalfreight-jData['freight']);
	$('#triptotal_totaladv').val(totaladv-jData['driveradvance']);
	$('#triptotal_totaltripexp').val(totaltripexp-jData['tripexp']);
	$('#triptotal_totalshortage').val(totalshortage-jData['shortage']);
	$('#triptotal_totaldamage').val(totaldamage-jData['damage']);
	$('#triptotal_totaloilshortage').val(totaloilshortage-jData['oilshortage']);
	calPayment();
    }

</script>
<?php echo $footer; ?>