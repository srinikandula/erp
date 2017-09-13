        <div id="form_right" class="right-side-form col-md-3">
            <div class="right-side-form-title"><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></div>
            <form id="horizontalForm" class="form-horizontal" method="post" >
                
		<?php 
		      getInputText(array("col"=>"itemname","title"=>"Item Name","required"=>1));
		      getInputTextArea(array("col"=>"description","title"=>"Description","required"=>0));
		      getInputText(array("col"=>"make","title"=>"Make","required"=>1));
            	?>
                <div class="form-group required">
			<label for="accountID" class="col-md-4">Type<span class="mandatory">*</span> :</label>
			<div class="col-md-8"><select class="form-control" name="field[type]" id="field_type" >
                            <option value="">--Select--</option>
                            <?php
                            foreach (getStoreItemTypes() as $k=>$v) {
                                echo "<option value='" .$k. "'>".$v."</option>";
                            }
                            ?>
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