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
		    getInputText(array("col"=>"vendorname","title"=>"Vendor Name","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"vendorcode","title"=>"Vendor Code","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"contactname","title"=>"Contact Name","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"contactmobile","title"=>"Contact Mobile","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"city","title"=>"City","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputTextArea(array("col"=>"address","title"=>"Address","required"=>0,"mainDivClass"=>"form-group col-md-6","rows"=>"2","cols"=>"20"));
                    getInputText(array("col"=>"bankname","title"=>"Bank Name","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"accountno","title"=>"Account No","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"bankbranch","title"=>"Bank Branch","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"bankifsccode","title"=>"Bank IFSC Code","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    ?>
                    <div class="form-group col-md-4" id="div_ispodsubmitted">
                        <label for="accountID" class="col-md-4">Supply Oil? :</label>
                        <div class="col-md-8">
                            <input name="field[oil]" type="checkbox"  placeholder="Oil" data-toggle="tooltip" data-placement="auto top" id="field_oil"  value="1" title="oil">
                        </div>
                    </div>
                    
                    <div class="form-group col-md-4" id="div_ispodsubmitted">
                        <label for="accountID" class="col-md-4">Supply Spares? :</label>
                        <div class="col-md-8">
                            <input name="field[spares]" type="checkbox"  placeholder="spares" data-toggle="tooltip" data-placement="auto top" id="field_spares"  value="1" title="spares">
                        </div>
                    </div>
                    
                    <div class="form-group col-md-4" id="div_ispodsubmitted">
                        <label for="accountID" class="col-md-4">Supply Tyres? :</label>
                        <div class="col-md-8">
                           <input name="field[tyres]" type="checkbox"  placeholder="Tyres" data-toggle="tooltip" data-placement="auto top" id="field_tyres"  value="1" title="Tyres">
                        </div>
                    </div>
                    
            <input  type="hidden" name="pkey" id="pkey">
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