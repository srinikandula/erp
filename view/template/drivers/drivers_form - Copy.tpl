        <div id="form_right" class="right-side-form col-md-3">
            <div class="right-side-form-title"><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></div>
            <form id="horizontalForm" class="form-horizontal" method="post" >
                
		<?php 
		      getInputText(array("col"=>"drivername","title"=>"Name","required"=>1));
		      getInputText(array("col"=>"drivercode","title"=>"Code","required"=>1));
		      getInputText(array("col"=>"drivermobile","title"=>"Mobile","required"=>1));
		      getInputText(array("col"=>"doj","title"=>"Date Of Joining","required"=>1));
		      getInputText(array("col"=>"licenceno","title"=>"Licence No","required"=>0));
		      getInputText(array("col"=>"licencevalidtilldate","title"=>"Licence Valid Till","required"=>0));
		      getInputTextArea(array("col"=>"driveraddress","title"=>"Address","required"=>0));
		      getInputText(array("col"=>"alternateno","title"=>"Alt Mobile","required"=>0));
		      
			getInputText(array("col"=>"fixedpermonth","title"=>"Fixed Per Month","required"=>0));
			getInputText(array("col"=>"batta","title"=>"Batta","required"=>0));
			getInputText(array("col"=>"pertrippercentonfreight","title"=>"Percent On Fright ","required"=>0));
			getInputText(array("col"=>"pertripcommission","title"=>"Commission Per Trip","required"=>0));

		      getInputText(array("col"=>"bankname","title"=>"Bank","required"=>0));
		      getInputText(array("col"=>"accountno","title"=>"Account No","required"=>0));
		      getInputText(array("col"=>"bankbranch","title"=>"Branch","required"=>0));
		      getInputText(array("col"=>"bankifsccode","title"=>"IFSC Code","required"=>0));
		getInputText(array("col"=>"status","title"=>"Status","required"=>0));
		?>	
                
		<div class="sbmt-btn-holder"> 
		<input  type="hidden" name="pkey" id="pkey">
		<button type="submit" class="right-side-form-sbmt-btn <?php echo $editPermClass; ?>" onclick="fnSubmit('edit');
                        return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button type="submit" class="right-side-form-sbmt-btn <?php echo $addPermClass; ?>" onclick="fnSubmit('add');
                                return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                </div>

            </form>
        </div>