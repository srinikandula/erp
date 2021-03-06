        <div id="form_right" class="right-side-form col-md-3">
            <div class="right-side-form-title"><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></div>
            <form id="horizontalForm" class="form-horizontal" method="post" >
                
		<?php 
		      getInputText(array("col"=>"adminname","title"=>"Name","required"=>1));
		      getInputText(array("col"=>"adminemail","title"=>"Email","required"=>1));
		      getInputText(array("col"=>"adminmobile","title"=>"Mobile","required"=>1));
		      getInputText(array("col"=>"username","title"=>"Username","required"=>1));
		      getInputText(array("col"=>"password","title"=>"Password","required"=>0,"type"=>"password"));
		      getInputText(array("col"=>"confirmpassword","title"=>"Confirm Password","required"=>0,"type"=>"password"));
		      //getInputText(array("col"=>"id_branch","title"=>"Branch","required"=>0));
		      //getInputText(array("col"=>"id_admin_role","title"=>"Role","required"=>0));
		      //getInputText(array("col"=>"status","title"=>"Status","required"=>0));
		?>	

		<div class="form-group required">
			<label for="accountID" class="col-md-4">Branch<span class="mandatory">*</span> :</label>
			<div class="col-md-8"><select class="form-control" name="field[id_branch]" id="field_id_branch" >
                            <?php
			    foreach ($branches as $row) {
				$hq=$row['isheadoffice']==1?"(HQ)":"";
                                echo "<option value='" .$row['id_branch']."'>".$row['branchcity'].$hq."</option>";
                            }
                            ?>
                        </select>
			</div>
		</div>
		
		<div class="form-group required">
			<label for="accountID" class="col-md-4">Role<span class="mandatory">*</span> :</label>
			<div class="col-md-8"><select class="form-control" name="field[id_admin_role]" id="field_id_admin_role" >
                            <?php
                            foreach ($roles as $row) {
                                echo "<option value='" .$row['id_admin_role']. "'>".$row['role']."</option>";
                            }
                            ?>
                        </select>
			</div>
		</div>

                <div class="form-group required">
			<label for="accountID" class="col-md-4">Active<span class="mandatory">*</span> :</label>
			<div class="col-md-8"><select class="form-control" name="field[status]" id="field_status" >
                            <option value="1">Yes</option>
                            <option value="0">No</option>
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