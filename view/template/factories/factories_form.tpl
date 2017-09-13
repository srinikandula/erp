<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
	<h4><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span>
        <!-- <h4 class="modal-title">Modal Header</h4> -->
      </h4>
      <form id="horizontalForm" class="form-horizontal" method="post" >
      <div class="modal-body col-md-12">
          <div id="form_right">
            
            
                
		<?php 
		    getInputText(array("col"=>"factoryname","title"=>"Name","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"factorycode","title"=>"Code","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"factorycontactname","title"=>"Contact Name","required"=>1,"mainDivClass"=>"form-group col-md-6"));
		    getInputText(array("col"=>"factorycontactmobile","title"=>"Contact Mobile","required"=>1,"mainDivClass"=>"form-group col-md-6","type"=>"number"));
		    getInputText(array("col"=>"factoryemail","title"=>"Email","required"=>0,"mainDivClass"=>"form-group col-md-6","type"=>"email"));
		    getInputText(array("col"=>"billingpersonname","title"=>"Biller Name","required"=>1,"mainDivClass"=>"form-group col-md-6"));
		    getInputText(array("col"=>"billingpersonmobile","title"=>"Biller Mobile","required"=>1,"mainDivClass"=>"form-group col-md-6"));
		    getInputText(array("col"=>"paymentcycle","title"=>"Payment Cycle","required"=>1,"mainDivClass"=>"form-group col-md-6","type"=>"number"));
		    getInputText(array("col"=>"paymentmode","title"=>"Payment Mode","required"=>1,"mainDivClass"=>"form-group col-md-6"));
		    getInputText(array("col"=>"city","title"=>"City","required"=>1,"mainDivClass"=>"form-group col-md-6"));
		    getInputTextArea(array("col"=>"address","title"=>"Address","required"=>0,"mainDivClass"=>"form-group col-md-6"));
		?>
                    
                <div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Status :</label>
                    <div class="col-md-8">
			<input name="field[status]" type="checkbox"  placeholder="Status" data-toggle="tooltip" data-placement="auto top" id="field_status" required="" value="1" title="Status">
			<input  type="hidden" name="pkey" id="pkey">
                    </div>
		</div>
		
            
        </div>
      </div>
      <div class="col-md-12 table-container">
	<div><b>Opearting Routes</b></div>
	<table class="table table-responsive table-bordered table-condensed table-striped" id="factory_rates_table">
		<thead>
		<tr>
			<th>Material</th>
			<th>Route</th>
			<th>Price Per Ton</th>
			<th>Contact Name</th>
			<th>Contact Mobile</th>
			<th>L Point</th>
			<th>UL Point</th>
			<th>L Charge</th>
			<th>UL Charge</th>
			<th>Toll Charge</th>
			<th>Party</th>
			<th><i class="fa fa-plus" onclick="fnRates()"></th>
		</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	
      </div>
      </form>
      <div class="modal-footer">
      		<button id="btnUpdate" type="submit" class="btn btn-primary <?php echo $editPermClass; ?>" onclick="fnSubmit('edit');
                        return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button id="btnCreate" type="submit" class="btn btn-primary <?php echo $addPermClass; ?>" onclick="fnSubmit('add');
                                return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                
        <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
      </div>
    </div>
  </div>
</div>
</div>

<div id="myModalSub" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4>Party <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span>
                    <!-- <h4 class="modal-title">Modal Header</h4> -->
                </h4>
                <form id="horizontalSubForm" class="form-horizontal" method="post" >
                    <div class="modal-body col-md-12">
			<div class="form-group col-md-6 required">
				<label for="accountID" class="col-md-4">Factory<span class="mandatory">*</span> :</label>
				<div class="col-md-8">
					<span id="party_factory_name"></span>
					<input name="field[id_factory_factory_party]" id="field_id_factory_factory_party" type="hidden">
				</div>
			</div>
                        <div class="col-md-12 table-container">
                            <div><b>Party Details</b></div>
                            <table class="table table-responsive table-bordered table-condensed table-striped" id="factory_parties_table">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Code</th>
                                        <th>Contact Name</th>
                                        <th>Contact Mobile</th>
                                        <th><i class="fa fa-plus" onclick="fnParties()"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button id="btnUpdate" type="submit" class="btn btn-primary <?php echo $editPermClass; ?>" onclick="fnSubmitParty();
                            return false;"><li class="fa fa-pencil fa-fw"></li> Update</button>

                </div>
            </div>
        </div>
    </div>
</div>
<script>
function fnSubmitParty() {
        var flag = 1;
	var partyRowCount=$('#factory_parties_table').find('tr').length;
		if(partyRowCount==1){
			flag = 0;
		}
		//alert("value of "+$('#factory_parties_table').find('tr').length);
		//return false;
		$('#factory_parties_table').find('tr').each(function(){
		if(typeof($("#row_"+$(this).attr('id')+"_partyname").val())!='undefined' && $("#row_"+$(this).attr('id')+"_partyname").val()==""){
			$("#row_"+$(this).attr('id')+"_partyname").css('border-color','red');
			flag=0;
		}else{
			$("#row_"+$(this).attr('id')+"_partyname").css('border-color','');
		}

		if(typeof($("#row_"+$(this).attr('id')+"_contactname").val())!='undefined' && $("#row_"+$(this).attr('id')+"_contactname").val()==""){
			$("#row_"+$(this).attr('id')+"_contactname").css('border-color','red');
			flag=0;
		}else{
			$("#row_"+$(this).attr('id')+"_contactname").css('border-color','');
		}

		if(typeof($("#row_"+$(this).attr('id')+"_contactmobile").val())!='undefined' && $("#row_"+$(this).attr('id')+"_contactmobile").val()==""){
			$("#row_"+$(this).attr('id')+"_contactmobile").css('border-color','red');
			flag=0;
		}else{
			$("#row_"+$(this).attr('id')+"_contactmobile").css('border-color','');
		}
		//console.log($(this).attr('id')+" "+$("#row_"+$(this).attr('id')+"_id_material").val())
	});
	
	    var type = $('#pkey').val();
        var submitTo = "<?php echo $route;?>/addparty";
        //var submitTo="edit";
        //alert(submitTo);
        if (flag) {

            $.ajax({
                url: 'index.php?route=' + submitTo + '&token=<?php echo $token; ?>',
                type: 'post',
                data: $('#horizontalSubForm').serialize(),
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
		    $('#myModalSub').modal('hide');
                    //alert('in success');
                    if (json['status']) {
                         getList('index.php?route=<?php echo $route; ?>/getlist&token=<?php echo $token; ?>');
					     removeFlashLoading();  
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
</script>