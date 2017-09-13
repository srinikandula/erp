<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog modal-lg">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
      <form id="horizontalForm" class="form-horizontal" method="post" >
        <button type="button" class="close" data-dismiss="modal">&times;</button>
	<h4><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span>
        <!-- <h4 class="modal-title">Modal Header</h4> -->
      </h4>
      <div class="modal-body col-md-12">
          <div id="form_right">
            
            
                
		<?php 
		    getInputText(array("col"=>"role","title"=>"Role","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                ?>
                    
                <div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Status :</label>
                    <div class="col-md-8">
			<input name="field[status]" type="checkbox"  placeholder="Status" data-toggle="tooltip" data-placement="auto top" id="field_status" required="" value="1" title="Status">
		<input name="pkey" id="pkey" type="hidden">		
	             </div>
		</div>	
            
        </div>
      </div>
      <div id="permissionsBlock">
<?php foreach($siteMap as $mod=>$data){?>
<div class="col-md-6">
    <table class="table table-striped table-bordered table-responsive table-condensed">
        <tbody>
            <tr>
                <td ><b>&nbsp;&nbsp;<?php echo ucfirst($mod);?></b></td>
            </tr>
            <tr id="SUB_customers" style="display: table-row;">
                <td style="padding-left: 9px;">
                    <table  cellspacing="0" cellpadding="0" border="0">
                        <tbody>
                            <tr >
                                <td  width="25%" align="left"><strong>Section Name</strong></td>
                                <td  width="12%" align="center"><strong>View</strong></td>
                                <td  width="15%" align="center"><strong>Add</strong></td>
                                <td  width="18%" align="center"><strong>Edit</strong></td>
                                <td  width="8%" align="center"><strong>Delete</strong></td>
                            </tr>
			    <?php foreach($data as $dataInfo){?>
                            <tr >
                                <td  align="left" height="22"><?php echo $dataInfo['title'];?></td>
                                
				<td  align="center" height="22"><input name="permissions[<?php echo $mod."@".$dataInfo['filename'];?>][view]" id="<?php echo $mod."_".$dataInfo['filename']."_view";?>" class="form-control" value="<?php echo $dataInfo['view']==1?1:0;?>" type="checkbox" <?php echo $dataInfo['view']==1?"":"disabled";?> ></td>
                                
				<td  align="center" height="22"><input  name="permissions[<?php echo $mod."@".$dataInfo['filename'];?>][add]" id="<?php echo $mod."_".$dataInfo['filename']."_add";?>" class="form-control" value="<?php echo $dataInfo['add'];?>" type="checkbox" <?php echo $dataInfo['add']==1?"":"disabled";?> ></td>

                                <td  align="center" height="22"><input  name="permissions[<?php echo $mod."@".$dataInfo['filename'];?>][edit]" id="<?php echo $mod."_".$dataInfo['filename']."_edit";?>" class="form-control" value="<?php echo $dataInfo['edit'];?>" type="checkbox" <?php echo $dataInfo['edit']==1?"":"disabled";?> ></td>

                                <td  align="center" height="22"><input  name="permissions[<?php echo $mod."@".$dataInfo['filename'];?>][delete]" id="<?php echo $mod."_".$dataInfo['filename']."_delete";?>"  class="form-control" value="<?php echo $dataInfo['delete'];?>" type="checkbox"  <?php echo $dataInfo['delete']==1?"":"disabled";?> ></td>
                            
			    </tr>
			    <?php }?>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>
<?php }?>
</div>
      <div class="modal-footer">
      		<button id="btnUpdate" type="submit" class="btn btn-primary <?php echo $editPermClass; ?>" onclick="fnSubmit('edit');
                        return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button id="btnCreate" type="submit" class="btn btn-primary <?php echo $addPermClass; ?>" onclick="fnSubmit('add');
                                return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                
        <!-- <button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
      </div>
      </form>
    </div>
  </div>
</div>