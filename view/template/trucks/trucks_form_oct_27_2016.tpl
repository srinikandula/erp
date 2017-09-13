<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
	<h4><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span>
        <!-- <h4 class="modal-title">Modal Header</h4> -->
      </h4>
      <div class="modal-body col-md-12">
          <div id="form_right">
            
            <form id="horizontalForm" class="form-horizontal" method="post" >
                
		<?php 
		    getInputText(array("col"=>"truckno","title"=>"Truck No","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    //getInputText(array("col"=>"id_truck_type","title"=>"Truck Type","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    //getInputText(array("col"=>"own","title"=>"Own","required"=>1,"mainDivClass"=>"form-group col-md-6"));?>
                <div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Truck Type :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_truck_type]" id="field_id_truck_type" >
                              <option value="">--Select--</option>
                              <?php foreach($trucktypes as $trucktype){
                                echo '<option value="'.$trucktype['id_truck_type'].'">'.$trucktype['trucktype'].'</option>';
                              }?>
                          </select>
                        <input  type="hidden" name="pkey" id="pkey">
                    </div>
		</div>    
                <div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Own :</label>
                    <div class="col-md-8">
			<input name="field[own]" type="checkbox"  placeholder="Own" data-toggle="tooltip" data-placement="auto top" id="field_own" required="" value="1" title="Own">
                    </div>
		</div>
		<div class="form-group col-md-6" id="div_field_contactname">
			<label for="accountID" class="col-md-4">Contact Name :</label>
			<div class="col-md-8">
				<input name="field[contactname]" class="form-control" placeholder="Contact Name" data-toggle="tooltip" data-placement="auto top" title="Contact Name" id="field_contactname" style="" type="text">
			</div>
		</div>
		
		<div class="form-group col-md-6"  id="div_field_contactmobile">
			<label for="accountID" class="col-md-4">Contact Mobile :</label>
			<div class="col-md-8">
				<input name="field[contactmobile]" class="form-control" placeholder="Contact Mobile" data-toggle="tooltip" data-placement="auto top" title="Contact Mobile" id="field_contactmobile" style="" type="text">
			</div>
		</div>	

                <?php
		    //getInputText(array("col"=>"contactname","title"=>"Contact Name","required"=>0,"mainDivClass"=>"form-group col-md-6"));	
		    //getInputText(array("col"=>"contactmobile","title"=>"Contact Mobile","required"=>0,"mainDivClass"=>"form-group col-md-6"));	
		    getInputText(array("col"=>"make","title"=>"Make","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"makeyear","title"=>"Make Year","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"model","title"=>"Model","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"engineno","title"=>"Engine No","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"chessisno","title"=>"Chessis No","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"omr","title"=>"Open Meter Reading","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"cmr","title"=>"Current Meter Reading","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"dateinservice","title"=>"Date In Service","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"fitnessexpdate","title"=>"Fitness Exp Date","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"hubservicedate","title"=>"Hub Service Date","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"insuranceexpdate","title"=>"Insurance Exp Date","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"nationalpermitexpdate","title"=>"N Permit Exp Date","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"pollutionexpdate","title"=>"Pollution Exp Date","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"taxpayabledate","title"=>"Tax Payable Date","required"=>0,"mainDivClass"=>"form-group col-md-6"));
		?>	
                
		
            </form>
        </div>
      </div>
      <div class="modal-footer">
      		<button id="btnUpdate" type="submit" class="btn btn-primary <?php echo $editPermClass; ?>" onclick="fnSubmit('edit');
                        return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button id="btnCreate" type="submit" class="btn btn-primary <?php echo $addPermClass; ?>" onclick="fnSubmit('add');
                                return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                
        <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
      </div>
    </div>
  </div>
</div>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>    
<script>
    $( function() {
    var curYear=new Date().getFullYear();
    var upYear=curYear+2;
    
    /*$( "#field_nationalpermitexpdate" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });
    $( "#field_dateinservice" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });
    $( "#field_fitnessexpdate" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });
    $( "#field_hubservicedate" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });
    $( "#field_insuranceexpdate" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });
    $( "#field_nationalpermitexpdate" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });
    $( "#field_pollutionexpdate" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });
    $( "#field_taxpayabledate" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });*/

    $( "#field_nationalpermitexpdate, #field_dateinservice, #field_fitnessexpdate, #field_hubservicedate, #field_insuranceexpdate, #field_pollutionexpdate, #field_taxpayabledate" ).datepicker({ changeMonth: true,changeYear: true,dateFormat: 'yy-mm-dd',yearRange: curYear+':'+upYear });
    } );

    $("#field_own").on('click',function(){
	//var trucks=JSON.parse('<?php echo json_encode($trucks);?>');
	//alert($(this).prop('checked'));
	if($(this).prop('checked')){
		$('#div_field_contactname').css('display','none');	
		$('#div_field_contactmobile').css('display','none');
	}else{
		$('#div_field_contactname').css('display','');	
		$('#div_field_contactmobile').css('display','');
	}
    });
</script>