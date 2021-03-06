<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalSearchFormFilter" name="horizontalSearchFormFilter" class="form-horizontal-filter" method="get">
	<!-- <input class="search-input" type="text" name="filter_material" placeholder="Material"> -->
	<fieldset class="large-form-fieldset">
        <legend>Filter<div style="float:right;padding:0px 2px 2px; 10px"><button onclick="fnDownload()" type="button" id="download" class="btn btn-info btn-xs"><i class="fa fa-download" aria-hidden="true" ></i> Download</button> <!-- <button type="button" class="btn btn-info btn-xs"><i class="fa fa-print" aria-hidden="true"></i> Print</button> --></div></legend>
<div class="form-group col-md-3 required">
    <label for="accountID" class="col-md-5">Truck No :</label>
    <div class="col-md-7">
        <select name="filter_id_truck[]" class="form-control" title="Tuck" id="field_id_truck" multiple>
	<?php foreach($trucks as $truck){
		$out=$truck['own']==0?"(Out)":"";
		$sel=isset($_GET['filter_id_truck']) && in_array($truck['id_truck'],$_GET['filter_id_truck'])?'selected':'';
		echo '<option  '.$sel.' value="'.$truck['id_truck'].'">'.$truck['truckno'].$out.'</option>';
	}?>
        </select>
    </div>
</div>

<div class="form-group col-md-2 required">
    <label for="accountID" class="col-md-6">Data :</label>
    <div class="col-md-6">
        <select name="filter_truckdata" class="form-control"  title="Tuck" id="filter_truckdata" >
        <option value="T" >Trips</option>
	<option value="D" <?php echo isset($_GET['filter_truckdata']) && $_GET['filter_truckdata']=='D'?'selected':'';?> >Diesel</option>
	<option value="M" <?php echo isset($_GET['filter_truckdata']) && $_GET['filter_truckdata']=='M'?'selected':'';?> >Maintenance</option>
	</select>
    </div>
</div>
        
<div class="form-group col-md-2 required">
	<label for="accountID" class="col-md-6">Fr Date :</label>
	<div class="col-md-6">
		<input name="filter_fromdate" class="form-control" placeholder="Fr Date" data-toggle="tooltip" data-placement="auto top" title="Fr Date" id="field_fromdate" value="<?php echo isset($_GET['filter_fromdate'])?$_GET['filter_fromdate']:'';?>" type="text">
	</div>
</div>
<div class="form-group col-md-2 required">
	<label for="accountID" class="col-md-6">To Date :</label>
	<div class="col-md-6">
		<input name="filter_todate" class="form-control" placeholder="To Date" data-toggle="tooltip" data-placement="auto top" title="To Date" id="field_todate" value="<?php echo isset($_GET['filter_todate'])?$_GET['filter_todate']:'';?>" type="text">
		<input  type="hidden" name="route" id="route"  value="reports/truckreport" >
		<input type="hidden" name="token" value="<?php echo $_GET['token'];?>" >
	</div>
</div>

	<input id="submitFilter" class="sbmt-btn btn-xs" type="button" name="submit" value="Submit" onclick="fnSubmit()">
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
/*$("#submitFilter").on("click", function(e) {
	e.preventDefault();
	var data = $('form#horizontalSearchFormFilter').serialize();
	getList('index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>&' + data);
});*/

/*$('#download').on('click',function(){
	alert("hello");
	//$("#route").val('reports/truckreport/download');
	$('form#horizontalSearchFormFilter').attr('action', 'index.php?route=reports/truckreport/download');
	$('form#horizontalSearchFormFilter').submit();
	//document.getElementById("horizontalSearchFormFilter").submit();
	//document.horizontalSearchFormFilter.action='index.php?route=reports/truckreport/download';
	//document.horizontalSearchFormFilter.submit();
});*/

function fnDownload(){
	//alert("downlaod");
	//$('form#horizontalSearchFormFilter').attr('action', 'index.php?route=reports/truckreport/download');
	//$('form#horizontalSearchFormFilter').submit;
	///document.horizontalSearchFormFilter.action='index.php?route=reports/truckreport/download';
	//document.horizontalSearchFormFilter.submit;
	$("#route").val('reports/truckreport/download');
	location.href='index.php?'+$('form#horizontalSearchFormFilter').serialize();

}

function fnSubmit(){
	$("#route").val('reports/truckreport');
	location.href='index.php?'+$('form#horizontalSearchFormFilter').serialize();

}
</script>