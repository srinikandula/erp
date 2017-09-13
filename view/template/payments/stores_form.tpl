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
            	<div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Vendor<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_store_vendor]" id="field_id_store_vendor" >
                              <option value="">--Select--</option>
                              <?php foreach($storevendors as $storevendor){
                                echo '<option value="'.$storevendor['id_store_vendor'].'">'.$storevendor['vendorname']."(".$storevendor['vendorcode'].")".'</option>';
                              }?>
                          </select>
                    </div>
		</div>
                <?php 
		    //getInputText(array("col"=>"vendorname","title"=>"Vendor Name","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    getInputText(array("col"=>"datepurchased","title"=>"Date Purchased","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                    //getInputText(array("col"=>"city","title"=>"City","required"=>0,"mainDivClass"=>"form-group col-md-6"));
                    ?>
                <div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Payment Mode<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[paymentmode]" id="field_paymentmode" >
                              <option value="">--Select--</option>
                              <?php foreach(getPaymentMode() as $k=>$pm){
                                echo '<option value="'.$k.'">'.$pm.'</option>';
                              }?>
                          </select>
                    </div>
		</div>    
                <?php getInputText(array("col"=>"paymentreference","title"=>"Paymet Ref","required"=>0,"mainDivClass"=>"form-group col-md-6"));?>    
                <div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Stock Branch<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_branch_store]" id="field_id_branch_store" >
                              <option value="">--Select--</option>
                              <?php foreach($branchs as $branch){
                                $hq=$branch['isheadoffice']==1?"(HQ)":"";
                                echo '<option value="'.$branch['id_branch'].'">'.$branch['branchcity'].$hq.'</option>';
                              }?>
                          </select>
                    </div>
		</div>
                <div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Payment Branch<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_branch_payment]" id="field_id_branch_payment" >
                              <option value="">--Select--</option>
                              <?php foreach($branchs as $branch){
                                $hq=$branch['isheadoffice']==1?"(HQ)":"";
                                echo '<option value="'.$branch['id_branch'].'">'.$branch['branchcity'].$hq.'</option>';
                              }?>
                          </select>
                    </div>
		</div>
                <?php getInputText(array("col"=>"amount","title"=>"Amount","required"=>1,"mainDivClass"=>"form-group col-md-6"));
                getInputTextArea(array("col"=>"comment","title"=>"Comment","required"=>0,"mainDivClass"=>"form-group col-md-6","rows"=>"2","cols"=>"20"));
                ?>    
            <input  type="hidden" name="pkey" id="pkey">
        <div class="col-md-12 table-container">
	<div><b>Items</b></div>
	<table class="table table-responsive table-bordered table-condensed table-striped" id="store_items_table">
		<thead>
		<tr>
                    <th>Item Name</th>
                    <th>Part No/Tyre No/Ref No</th>
                    <th>Qty</th>
                    <th>Unit Price</th>
                    <th>Amount</th>
                    <th><i class="fa fa-plus" onclick="fnItems()"></th>
		</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	</div>
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
$(function() {
    $("#field_datepurchased").datepicker({dateFormat: 'yy-mm-dd'});
});

var rowNum=0;
function fnItems(rate){
	rowNum=rowNum+1;
	//alert(rowNum)
	if (typeof(rate)=="undefined")
	{
		rate={"id_store_item":"","id_store_vendor_item":"","id_store_vendor_payment":"","qty":"","available":"","price":"","refno":""};
	}
	var amount=(parseInt(rate['price'])*+parseFloat(rate['qty'])) || 0;
	$('#store_items_table tbody').append('<tr><td><select  name="row['+rowNum+'][id_store_item]" id="row_'+rowNum+'_id_store_item" class="form-control">'+stockItemsOption+'</select></td><td><input name="row['+rowNum+'][refno]" type="text" class="form-control" placeholder="Ref No" data-toggle="tooltip" data-placement="auto top" title="Ref No"   id="row_'+rowNum+'_refno" value="'+rate['refno']+'"  data-original-title="Ref No"></td><td><input name="row['+rowNum+'][qty]" type="number" class="form-control qty" placeholder="Qty" data-toggle="tooltip" data-placement="auto top" title="Qty" onkeyup="fnamount('+rowNum+')" value="'+rate['qty']+'"  id="row_'+rowNum+'_qty"   data-original-title="Qty" required></td><td><input name="row['+rowNum+'][price]" type="number" class="form-control price" placeholder="Price" data-toggle="tooltip" data-placement="auto top" title="Price"  value="'+rate['price']+'"  onkeyup="fnamount('+rowNum+')" id="row_'+rowNum+'_price"  data-original-title="Price" required></td><td id="row_'+rowNum+'_amount">'+amount+'</td><td><i class="fa fa-remove"  onclick="fnremove(this)"></td></tr>');

	$('#row_'+rowNum+'_id_store_item').val(rate['id_store_item']);
	//alert("id_factory_party "+rate['id_factory_party']);
}

function fnamount(row){
    var qty=parseInt($('#row_'+row+'_qty').val());
    var price=parseFloat($('#row_'+row+'_price').val());
    $('#row_'+row+'_amount').html(qty*price);
    fnTotalAmount();
}
function fnTotalAmount(){
    var amount=0;
    //alert(rowNum)
    var loop=rowNum;
    while(loop>0){
        amount+=(parseInt($('#row_'+loop+'_qty').val())*parseFloat($('#row_'+loop+'_price').val())) || 0;
        loop--;
    }
    $('#field_amount').val(amount||0);
}

function fnremove(obj){
    $(obj).parent().parent().remove()
    fnTotalAmount();
}

//$('#myModal').modal('show');
</script>