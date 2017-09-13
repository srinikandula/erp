<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalSearchFormFilter" class="form-horizontal-filter" method="post">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Filter<div style="float:right;padding:0px 2px 2px; 10px"><button type="button" class="btn btn-info btn-xs" onClick="fnDownload()" ><i class="fa fa-download" aria-hidden="true"></i> Download</button> <!-- <button type="button" class="btn btn-info btn-xs"><i class="fa fa-print" aria-hidden="true"></i> Print</button> --></div></legend>
	
        
<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-4">Branch :</label>
    <div class="col-md-8">
        <select name="filter_id_branch" class="form-control"   title="Branch" id="field_id_branch" >
        <option value="">Select Store Branch</option>    
        <?php foreach($branches as $branche){
            $hq=$branche['isheadoffice']?"(HQ)":"";
            echo '<option value="'.$branche['id_branch'].'">'.$branche['branchcity'].'-'.$branche['branchcode'].$hq.'</option>';
        }?>
        </select>
    </div>
</div>

<div class="form-group col-md-3 required">
	<label for="accountID" class="col-md-4">Fr Date* :</label>
	<div class="col-md-8">
		<input name="filter_fromdate" class="form-control" placeholder="Fr Date" title="Fr Date" id="field_fromdate" value="" type="text">
	</div>
</div>
<div class="form-group col-md-3 required">
	<label for="accountID" class="col-md-4">To Date* :</label>
	<div class="col-md-8">
		<input name="filter_todate"  class="form-control" placeholder="To Date" title="To Date" id="field_todate" value="" type="text">
	</div>
</div>

	<input id="submitFilter" class="sbmt-btn" type="submit" name="submit" value="Submit" >
	</fieldset>
    </form>
</div>
</div>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>    
<script>
$(function() {
	$("#field_dateattached, #field_fromdate, #field_todate").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>
<script>
$("#submitFilter").on("click", function(e) {
	e.preventDefault();
	if($('input[name="filter_todate"]').val()!="" && $('input[name="filter_fromdate"]').val()!=""){
		var data = $('form#horizontalSearchFormFilter').serialize();
		getList('index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>&' + data);
	}else{
		alert("From Date and To Date are mandatory!!");
	}
});

function fnDownload(){
	location.href='index.php?route=reports/bankstatement/download&token=<?php echo $_GET["token"];?>&'+$('form#horizontalSearchFormFilter').serialize();
}
</script>