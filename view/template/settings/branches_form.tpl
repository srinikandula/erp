        <div id="form_right" class="right-side-form col-md-3">
            <div class="right-side-form-title"><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></div>
            <form id="horizontalForm" class="form-horizontal" method="post" >
                
		<?php 
		      getInputText(array("col"=>"branchcode","title"=>"Code","required"=>1));
		      getInputText(array("col"=>"branchcity","title"=>"City","required"=>1));
		      getInputTextArea(array("col"=>"branchaddress","title"=>"Address","required"=>0));
		      getInputText(array("col"=>"branchcontactname","title"=>"Contact Name","required"=>0));
		      getInputText(array("col"=>"branchcontactmobile","title"=>"Contact Mobile","required"=>0));
		      //getInputText(array("col"=>"isheadoffice","title"=>"Head Office","required"=>0));
		?>	

		<div class="form-group required">
			<label for="accountID" class="col-md-4">Is Head Office? :</label>
			<div class="col-md-8"><select class="form-control" name="field[isheadoffice]" id="field_isheadoffice" >
                            <option value="0">No</option>
			    <option value="1">Yes</option>
			</select>
			</div>
		</div>
                
		<div class="sbmt-btn-holder"> 
		<input  type="hidden" name="pkey" id="pkey">
		<button type="submit" class="right-side-form-sbmt-btn <?php echo $editPermClass; ?>" onclick="fnSubmit('edit');
                        return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button type="submit" class="right-side-form-sbmt-btn <?php echo $addPermClass; ?>" onclick="fnSubmit('add');
                                return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                </div>

            </form>
        </div>