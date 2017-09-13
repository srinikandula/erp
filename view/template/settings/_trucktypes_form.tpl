        <div id="form_right" class="right-side-form col-md-3">
            <div class="right-side-form-title"><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></div>
            <form id="horizontalForm" class="form-horizontal" method="post" >
                <div class="form-group">
                    <label for="accountID" class="col-md-4">Truck Type:</label>
                    <div class="col-md-8">
                        <input name="field[trucktype]" type="text" class="form-control"  placeholder="Truck Type" data-toggle="tooltip" data-placement="auto top" title="Truck Type" id="field_trucktype" required>
                    </div>
                </div>

                <div class="form-group">
                    <label  for="deviceID" class="col-md-4">Tons:</label>
                    <div class="col-md-8">
                        <input type="text" name="field[tons]" class="form-control"  placeholder="Tons" data-toggle="tooltip" data-placement="auto top" title="Tons" id="field_tons" required>
                        <input  type="hidden" name="pkey" id="pkey">
                    </div>
                </div>

		<div class="form-group">
                    <label  for="deviceID" class="col-md-4">Batta:</label>
                    <div class="col-md-8">
                        <input type="text" name="field[batta]" class="form-control"  placeholder="Batta" data-toggle="tooltip" data-placement="auto top" title="Batta" id="field_batta" >
                    </div>
                </div>

		<div class="form-group">
                    <label for="accountID" class="col-md-4">Tyres:</label>
                    <div class="col-md-8">
                        <input name="field[tyres]" type="text" class="form-control"  placeholder="Tyres" data-toggle="tooltip" data-placement="auto top" title="Tyres" id="field_tyres" required>
                    </div>
                </div>
                
		<div class="sbmt-btn-holder"> 
		<button type="submit" class="right-side-form-sbmt-btn <?php echo $editPermClass; ?>" onclick="fnSubmit('edit');
                        return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button type="submit" class="right-side-form-sbmt-btn <?php echo $addPermClass; ?>" onclick="fnSubmit('add');
                                return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                </div>

            </form>
        </div>