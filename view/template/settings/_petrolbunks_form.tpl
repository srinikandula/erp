        <div id="form_right" class="right-side-form col-md-3">
            <div class="right-side-form-title"><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></div>
            <form id="horizontalForm" class="form-horizontal" method="post" >
                
		<!-- <div class="form-group">
                    <label for="accountID" class="col-md-4">Name:</label>
                    <div class="col-md-8">
                        <input name="field[fuelstationname]" type="text" class="form-control"  placeholder="Name" data-toggle="tooltip" data-placement="auto top" title="Name" id="field_fuelstationname" required>
                    </div>
                </div>

                <div class="form-group">
                    <label  for="deviceID" class="col-md-4">Code:</label>
                    <div class="col-md-8">
                        <input type="text" name="field[fuelstationcode]" class="form-control"  placeholder="Code" data-toggle="tooltip" data-placement="auto top" title="Code" id="field_fuelstationcode" required>
                        <input  type="hidden" name="pkey" id="pkey">
                    </div>
                </div> -->

		<?php 
		      getInputText(array("col"=>"fuelstationname","title"=>"Name","required"=>1));
		      getInputText(array("col"=>"fuelstationcode","title"=>"Code","required"=>1));
		      getInputText(array("col"=>"city","title"=>"City","required"=>1));
		      getInputText(array("col"=>"fuelpersonname","title"=>"Contact Name","required"=>1));
		      getInputText(array("col"=>"fuelpersonmobile","title"=>"Contact Mobile","required"=>1));
		      getInputTextArea(array("col"=>"address","title"=>"Address","required"=>0));
		      getInputText(array("col"=>"bankname","title"=>"Bank Name","required"=>0));
		      getInputText(array("col"=>"accountno","title"=>"Account No","required"=>0));
		      getInputText(array("col"=>"bankbranch","title"=>"Bank Branch","required"=>0));
		      getInputText(array("col"=>"bankifsccode","title"=>"IFSC Code","required"=>0));
		?>	
                
		<div class="sbmt-btn-holder"> 
		<input  type="hidden" name="pkey" id="pkey">
		<button type="submit" class="right-side-form-sbmt-btn <?php echo $editPermClass; ?>" onclick="fnSubmit('edit');
                        return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button type="submit" class="right-side-form-sbmt-btn <?php echo $addPermClass; ?>" onclick="fnSubmit('add');
                                return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                </div>

            </form>
        </div>