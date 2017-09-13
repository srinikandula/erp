        <div id="form_right" class="right-side-form col-md-3">
            <div class="right-side-form-title"><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></div>
            <form id="horizontalForm" class="form-horizontal" method="post" >
                <div class="form-group">
                    <label for="accountID" class="col-md-4">Material:</label>
                    <div class="col-md-8">
                        <input name="field[material]" type="text" class="form-control"  placeholder="Material" data-toggle="tooltip" data-placement="auto top" title="Material" id="field_material" required>
                    </div>
                </div>

                <div class="form-group">
                    <label  for="deviceID" class="col-md-4">Material Code:</label>
                    <div class="col-md-8">
                        <input type="text" name="field[materialcode]" class="form-control"  placeholder="Material Code" data-toggle="tooltip" data-placement="auto top" title="Material Code should be unique" id="field_materialcode" required>
                        <input  type="hidden" name="pkey" id="pkey">
                    </div>
                </div>
                
		<div class="sbmt-btn-holder"> 
		<button type="submit" class="right-side-form-sbmt-btn <?php echo $editPermClass; ?>" onclick="fnSubmit('edit');
                        return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button type="submit" class="right-side-form-sbmt-btn <?php echo $addPermClass; ?>" onclick="fnSubmit('add');
                                return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                </div>

            </form>
        </div>