<?php //echo '<pre>';print_r($drivers);echo '</pre>';?>
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
  <div class="col-md-12">
              <div class="col-md-4">
                    <label for="accountID" class="col-md-4"><b>Trip Id:</b></label>
                    <div class="col-md-8" id="tripCode">#Trip21</div>
		</div>
                <div class="col-md-8" id="info-box">
                    <div id="info-box-or"><!--<b>Code</b>:OR.HYD-OR.DLH, <b>Route</b>:Hyderabad-Delhi,<b>Distance</b>:250KM,<b>Toll Charges</b>:2250,<b>TollGates</b>:21--></div>
		</div>
</div>
            <div class="col-md-12">
            <form id="horizontalForm" class="form-horizontal" method="post" >
                
                <fieldset class="large-form-fieldset">
                <legend>Loading Details</legend>
                <?php 
		    getInputText(array("col"=>"transactiondate","title"=>"Transc Date","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"dispatchdate","title"=>"Dispatch Date","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		?>
                <div class="form-group col-md-4 required">
                    <label for="accountID" class="col-md-4">Return :</label>
                    <div class="col-md-8">
			<input name="field[traveltype]" type="checkbox"  placeholder="Return" data-toggle="tooltip" data-placement="auto top" id="field_traveltype" value="0" title="Return">
                    </div>
		</div>

		<div class="form-group col-md-4 required">
                    <label for="accountID" class="col-md-4">Own :</label>
                    <div class="col-md-8">
			<input name="field[own]" type="checkbox"  placeholder="Own" data-toggle="tooltip" data-placement="auto top" id="field_own" required="" value="1" title="Own" checked>
                    </div>
		</div>
		<!--<div class="form-group col-md-6 required">
                    <label for="accountID" class="col-md-4">Travel Type :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[traveltype]" id="field_traveltype" >
                              <?php /*foreach(getTravelType() as $k=>$v){
                                echo '<option value="'.$k.'">'.$v.'</option>';
                              }*/?>
                          </select>
                    </div>
		</div>-->

		<div class="form-group col-md-4 required">
                    <label for="accountID" class="col-md-4">Booked To<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[loadprovider]" id="field_loadprovider" >
                              <option value="">--Select--</option>
                              <?php foreach(getLoadProviders() as $k=>$v){
                                echo '<option value="'.$k.'">'.$v.'</option>';
                              }?>
                          </select>
                        <input  type="hidden" name="pkey" id="pkey">
                    </div>
		</div>
                
                <div class="form-group col-md-4 required" id="div_id_factory">
                    <label for="accountID" class="col-md-4">Factory<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_factory]" id="field_id_factory" >
                              <option value="">--Select--</option>
                              <?php foreach($factories as $factory){
                                echo '<option value="'.$factory['id_factory'].'">'.$factory['factoryname'].'</option>';
                              }?>
                          </select>
                    </div>
		</div>
                
                <div class="form-group col-md-12 required" id="div_id_factory_rate" style="display:none">
                    <label for="accountID" class="col-md-4">Route & Goods<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                        <select class="form-control" name="field[id_factory_route_material]" id="field_id_factory_route_material">
                        </select>
                    </div>
                </div>

		<div class="form-group col-md-4 required"  id="div_id_transporter"  style="display:none">
                    <label for="accountID" class="col-md-4">Transporters<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_transporter]" id="field_id_transporter" >
                              <option value="">--Select--</option>
                              <?php foreach($transporters as $transporter){
                                echo '<option value="'.$transporter['transporter'].'#'.$transporter['id_transporter'].'">'.$transporter['transporter'].'</option>';
                              }?>
                          </select>
                    </div>
		</div>
                
                <div class="form-group col-md-4" id="div_id_operating_route" required>
                    <label for="accountID" class="col-md-4">Route<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_operating_route]" id="field_id_operating_route" >
                              <option value="">--Select--</option>
                              <?php foreach($operatingroutes as $operatingroute){
                                echo "<option value='".json_encode($operatingroute)."'>".$operatingroute["fromplace"].' - '.$operatingroute["toplace"]."</option>";
                              }?>
                          </select>
                    </div>
		</div>
                
                <div class="form-group col-md-4 required" id="div_id_material">
                    <label for="accountID" class="col-md-4">Goods<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_material]" id="field_id_material" >
                              <option value="">--Select--</option>
                              <?php foreach($materials as $material){
                                echo '<option value="'.$material['material'].'#'.$material['id_material'].'#'.$material['materialcode'].'">'.$material['material'].'</option>';
                              }?>
                          </select>
                        
                    </div>
		</div>
                <?php
                    getInputText(array("col"=>"invoicedate","title"=>"Invoice Date","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"waybillno","title"=>"Way Bill No","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"flno","title"=>"FL No","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"lrno","title"=>"LR No","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"orderno","title"=>"Order No","required"=>1,"mainDivClass"=>"form-group col-md-4"));
                ?>
		
                <div class="form-group col-md-4 required">
                    <label for="accountID" class="col-md-4">Trans Type<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[transtype]" id="field_transtype" >
                              <option value="">--Select--</option>
                              <?php foreach(getTruckPayTypes() as $k=>$v){
                                echo '<option value="'.$k.'">'.$v.'</option>';
                              }?>
                          </select>
                    </div>
		</div>
                
                <div class="form-group col-md-4 required" id="div_id_truck_select">
                    <label for="accountID" class="col-md-4">Truck<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_truck]" id="field_id_truck" >
                              <option value="">--Select--</option>
                              <?php foreach($trucks as $truck){ if($truck['own']!=1){ continue;}
                                echo '<option value="'.$truck['id_truck'].'#'.$truck['truckno'].'">'.$truck['truckno'].'</option>';
                              }?>
                          </select>
                    </div>
		</div>
		
		<div class="form-group col-md-4 required" id="div_id_driver_select">
                    <label for="accountID" class="col-md-4">Driver<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <select class="form-control" name="field[id_driver]" id="field_id_driver" >
                              <option value="">--Select--</option>
                              <?php foreach($drivers as $driver){
                                //echo "<option value=".json_encode($driver).">".$driver["drivername"]."</option>";
                                echo "<option value='".json_encode($driver)."'>".$driver["drivername"]."</option>";
                              }?>
                          </select>
                    </div>
		</div>

		<div class="form-group col-md-4 required" id="div_id_driver_text" style="display:none">
                    <label for="accountID" class="col-md-4">Driver<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <input type="text" class="form-control" name="field[id_driver_text]" id="field_id_driver_text" />
                    </div>
		</div>
                <?php 
                getInputText(array("col"=>"drivermobile","title"=>"Driver Mob","required"=>1,"mainDivClass"=>"form-group col-md-4"));
                getInputText(array("col"=>"driveradvance","title"=>"Driver Adv","required"=>1,"mainDivClass"=>"form-group col-md-4"));
                //getInputText(array("col"=>"transporteradvance","title"=>"Transporter Adv","required"=>0,"mainDivClass"=>"form-group col-md-4"));?>
		
		<div class="form-group col-md-4" id="div_transporteradvance" style="display:none">
                    <label for="accountID" class="col-md-4">Transporter Adv<span class="mandatory">*</span> :</label>
                    <div class="col-md-8">
                          <input type="text" class="form-control" name="field[transporteradvance]" id="field_transporteradvance"/>
                    </div>
		</div>	

		<?php   
		    //getInputText(array("col"=>"loadprovider","title"=>"Load Provider","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"billrate","title"=>"Bill Rate","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"truckrate","title"=>"Truck Rate","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"qty","title"=>"Qty","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"bags","title"=>"Bags","required"=>0,"mainDivClass"=>"form-group col-md-4"));
		    //getInputText(array("col"=>"freight","title"=>"Freight","required"=>1,"mainDivClass"=>"form-group col-md-4"));
                    //getInputText(array("col"=>"bpf","title"=>"BPF","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    ?>
                    <div class="form-group col-md-4">
                        <label for="accountID" class="col-md-4">Freight :</label>
                        <div class="col-md-8" id="field_freight"></div>
                    </div>
                    
                    <div class="form-group col-md-4">
                        <label for="accountID" class="col-md-4">BPF :</label>
                        <div class="col-md-8" id="field_bpf"></div>
                    </div>
                    
                    </fieldset>
                    <fieldset class="large-form-fieldset" id="field_transit_details">
                            <legend>Transit Details</legend>
                            <?php
                            getInputText(array("col"=>"omr","title"=>"OMR","required"=>0,"mainDivClass"=>"form-group col-md-4"));
                            getInputText(array("col"=>"cmr","title"=>"CMR","required"=>0,"mainDivClass"=>"form-group col-md-4"));
                            ?>
                            <div class="col-md-6 table-container">
                            <div><b>Fuel Details</b></div>
                            <table class="table table-responsive table-bordered table-condensed table-striped" id="fuel_details_table">
                                <thead>
                                    <tr>
                                        <th>Fuel Station</th>
                                        <th>Qty</th>
					<th>Price Per Ltr</th>
                                        <th>Amount</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if(count($fuels)){
                                        $fuelOptions="<option value='0'>None</option>";
                                        
                                        foreach($fuels as $fuel){
                                            $fuelOptions.="<option value='".$fuel['id_fuel_station']."'>".$fuel['fuelstationname']."-".$fuel['city']."</option>";
                                        }
                                        ?>
                                    <tr>
                                        <td><select name="fuel[3][id_fuel_station]" id="fuel_3_id_fuel_station" class="form-control" ><?php echo $fuelOptions;?></select></td>
                                        <td><input type="text" name="fuel[3][qty]" id="fuel_3_qty" class="form-control" placeholder="Qty" data-toggle="tooltip" data-placement="auto right" title="Qty" data-original-title="Qty" ></td>
					<td><input type="text" name="fuel[3][priceperltr]" id="fuel_3_priceperltr" class="form-control" placeholder="Price Per Ltr" data-toggle="tooltip" data-placement="auto right" title="Price Per Ltr" data-original-title="Price Per Ltr" ></td>
                                        <td><input type="text" name="fuel[3][amount]" id="fuel_3_amount" class="form-control" placeholder="Amount" data-toggle="tooltip" data-placement="auto right" title="Amount" data-original-title="Amount" readonly></td>
                                    </tr>
                                    <tr>
                                        <td><select name="fuel[4][id_fuel_station]" id="fuel_4_id_fuel_station" class="form-control" ><?php echo $fuelOptions;?></select></td>
                                        <td><input type="text" name="fuel[4][qty]" id="fuel_4_qty" class="form-control"  placeholder="Qty" data-toggle="tooltip" data-placement="auto right" title="Qty" data-original-title="Qty" ></td>
                                        <td><input type="text" name="fuel[4][priceperltr]" id="fuel_4_priceperltr" class="form-control" placeholder="Price Per Ltr" data-toggle="tooltip" data-placement="auto right" title="Price Per Ltr" data-original-title="Price Per Ltr" ></td>
					<td><input type="text" name="fuel[4][amount]" id="fuel_4_amount" class="form-control" placeholder="Amount" data-toggle="tooltip" data-placement="auto right" title="Amount" data-original-title="Amount" readonly></td>
                                    </tr>
                                    <?php }?>
                                    <tr>
                                        <td><input type="text" name="fuel[1][fuelstationname]" id="fuel_1_fuelstationname" class="form-control" ></td>
                                        <td><input type="text" name="fuel[1][qty]" id="fuel_1_qty" class="form-control"  placeholder="Qty" data-toggle="tooltip" data-placement="auto right" title="Qty" data-original-title="Qty" ></td>
					<td><input type="text" name="fuel[1][priceperltr]" id="fuel_1_priceperltr" class="form-control" placeholder="Price Per Ltr" data-toggle="tooltip" data-placement="auto right" title="Price Per Ltr" data-original-title="Price Per Ltr" ></td>
                                        <td><input type="text" name="fuel[1][amount]" id="fuel_1_amount" class="form-control" placeholder="Amount" data-toggle="tooltip" data-placement="auto right" title="Amount" data-original-title="Amount" readonly></td>
                                    </tr>
                                    <tr>
                                        <td><input type="text" name="fuel[2][fuelstationname]" id="fuel_2_fuelstationname" class="form-control" ></td>
                                        <td><input type="text" name="fuel[2][qty]" id="fuel_2_qty" class="form-control"  placeholder="Qty" data-toggle="tooltip" data-placement="auto right" title="Qty" data-original-title="Qty" ></td>
					<td><input type="text" name="fuel[2][priceperltr]" id="fuel_2_priceperltr" class="form-control" placeholder="Price Per Ltr" data-toggle="tooltip" data-placement="auto right" title="Price Per Ltr" data-original-title="Price Per Ltr" ></td>
                                        <td><input type="text" name="fuel[2][amount]" id="fuel_2_amount" class="form-control" placeholder="Amount" data-toggle="tooltip" data-placement="auto right" title="Amount" data-original-title="Amount" readonly></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-6 table-container">
                            <div><b>Trip Expenses</b></div>
                            <table class="table table-responsive table-bordered table-condensed table-striped" id="trip_expense_table">
                                <tbody>
                                    <tr>
                                        <td>Toll Gate</td>
                                        <td><input type="text" name="field[tollexp]" id="field_tollexp" class="form-control"  placeholder="Toll Gate" data-toggle="tooltip" data-placement="auto right" title="Toll Gate" data-original-title="Toll Gate" ></td>
                                    </tr>
                                    <tr>
                                        <td>Loading Charge</td>
                                        <td><input type="text" name="field[loadingexp]" id="field_loadingexp" class="form-control"  placeholder="Loading" data-toggle="tooltip" data-placement="auto right" title="Loading" data-original-title="Loading" ></td>
                                    </tr>
                                    <tr>
                                        <td>UnLoading Charge</td>
                                        <td><input type="text" name="field[unloadingexp]" id="field_unloadingexp" class="form-control"  placeholder="UnLoading" data-toggle="tooltip" data-placement="auto right" title="UnLoading" data-original-title="UnLoading" ></td>
                                    </tr>
                                    <tr>
                                        <td>Police Mamul</td>
                                        <td><input type="text" name="field[policeexp]" id="field_policeexp" class="form-control"  placeholder="Police" data-toggle="tooltip" data-placement="auto right" title="Police" data-original-title="Police" ></td>
                                    </tr>
                                    <!--<tr>
                                        <td>Misc</td>
                                        <td><input type="text" name="field[miscexp]" id="field_miscexp" class="form-control"  placeholder="Misc" data-toggle="tooltip" data-placement="auto right" title="Misc" data-original-title="Misc" ></td>
                                    </tr>-->
                                    <tr>
                                        <td>Repairs</td>
                                        <td><input type="text" name="field[repairexp]" id="field_repairexp" class="form-control"  placeholder="Repairs" data-toggle="tooltip" data-placement="auto right" title="Repairs" data-original-title="Repairs" >
                                            <textarea name="field[repairexpcomment]" id="field_repairexpcomment" class="form-control"  placeholder="Comment" data-toggle="tooltip" data-placement="auto right" title="Comment" data-original-title="Comment" ></textarea></td>
                                    </tr>
                                    <tr>
                                        <td>Diesel</td>
                                        <td><input type="text" name="field[dieselexp]" id="field_dieselexp" class="form-control"  placeholder="Diesel" data-toggle="tooltip" data-placement="auto right" title="Diesel" data-original-title="Diesel" ></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </fieldset>
                    
                    <fieldset class="large-form-fieldset">
                    <legend>Delivery Details</legend>
                    <?php
                    getInputText(array("col"=>"unloadingdate","title"=>"Unloading Date","required"=>0,"mainDivClass"=>"form-group col-md-4"));?>
                    <div class="form-group col-md-4">
                        <label for="accountID" class="col-md-6">Qty @ Loading :</label>
                        <div class="col-md-6" id="qtyatloading"></div>
                    </div>
                    <?php
		    //getInputText(array("col"=>"qtyatloading","title"=>"Qty @ Loading","required"=>1,"mainDivClass"=>"form-group col-md-4"));
                    getInputText(array("col"=>"qtyatunloading","title"=>"Qty @ Unloading","required"=>1,"mainDivClass"=>"form-group col-md-4","labelClass"=>"col-md-6","divClass"=>"col-md-6"));?>
                    <div class="form-group col-md-4">
                        <label for="accountID" class="col-md-6">Bags @ Loading :</label>
                        <div class="col-md-6" id="bagsatloading"></div>
                    </div>
                    
                    <?php
                    
                    //getInputText(array("col"=>"bagsatloading","title"=>"Bags @ Loading","required"=>1,"mainDivClass"=>"form-group col-md-4"));
		    getInputText(array("col"=>"bagsatunloading","title"=>"Bags @ Unloading","required"=>0,"mainDivClass"=>"form-group col-md-4","labelClass"=>"col-md-6","divClass"=>"col-md-6"));
		    getInputText(array("col"=>"shortage","title"=>"Shortage","required"=>0,"mainDivClass"=>"form-group col-md-4","labelClass"=>"col-md-5","divClass"=>"col-md-7"));
                    getInputText(array("col"=>"damage","title"=>"Damage","required"=>0,"mainDivClass"=>"form-group col-md-4","labelClass"=>"col-md-5","divClass"=>"col-md-7"));
                    getInputText(array("mainDivId"=>"div_oilshortage","col"=>"oilshortage","title"=>"Oil Shortage","required"=>0,"mainDivClass"=>"form-group col-md-6"));
		    ?>
                    <div class="form-group col-md-6" id="div_ispodreceived" style="display:none">
                        <label for="accountID" class="col-md-4">Pod Received :</label>
                        <div class="col-md-8">
                            <input name="field[ispodreceived]" type="checkbox"  placeholder="Pod Received" data-toggle="tooltip" data-placement="auto top" id="field_ispodreceived"  value="1" title="ispodreceived">
                        </div>
                    </div>
                    
                    <div class="form-group col-md-6" id="div_ispodsubmitted">
                        <label for="accountID" class="col-md-4">Pod Submitted :</label>
                        <div class="col-md-8">
                            <input name="field[ispodsubmitted]" type="checkbox"  placeholder="Pod Submitted" data-toggle="tooltip" data-placement="auto top" id="field_ispodsubmitted"  value="1" title="ispodsubmitted">
                        </div>
                    </div>
                    
                    </fieldset>
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
    </div>
</div>

<link rel="stylesheet" type="text/css" href="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.css"/>
<script src="<?php echo HTTP_SERVER;?>view/js/datetime/jquery.datetimepicker.js"></script>
<script type="text/javascript">
$('#field_dispatchdate, #field_transactiondate, #field_invoicedate, #field_unloadingdate').datetimepicker({
	dayOfWeekStart: 1,
	lang: 'en',
	format: 'Y-m-d H:i',
	startDate: '<?php echo date("Y/m/d H:i"); ?>'	//'2015/09/01'
});


$('#field_traveltype').on("change",function(){
	travelType();
});


$('#field_loadprovider').on('change',function(){
	loadprovider();	
});

$('#field_own').on("click",function(){
	own();
});

$('#field_id_operating_route').on('change',function(){
    id_operating_route();
});

$('#field_qty').on('keyup',function(){
    qty();
});

$('#field_bags').on('keyup',function(){
    bags();
});

$("#field_id_factory").on('change',function(){
	id_factory();   
});

$('#field_id_factory_route_material').on('change',function(){
    id_factory_route_material();
});

$('#field_billrate, #field_truckrate, #field_qty').on('keyup',function(){
    rate();
});

$('#field_id_driver').on('change',function(){
    id_driver();
});

function travelType(){
	if($('#field_traveltype').val()==1){
		$('#div_id_factory').css('display','');
		$('#div_id_transporter').css('display','none');
	}else{
		$('#div_id_factory').css('display','none');
		$('#div_id_transporter').css('display','');
	}
}

function loadprovider(){
	if($('#field_loadprovider').val()=='TR'){
            //alert("in");
		$('#div_id_factory').css('display','none');
		$('#div_id_transporter').css('display','');
                
                $('#div_id_material').css('display','');
		$('#div_id_operating_route').css('display','');
                $('#div_id_factory_rate').css('display','none');
                //$('#div_ispodreceived').css('display','');
                //$('#div_ispodsubmitted').css('display','');
                $('#div_transporteradvance').css('display','');
		$('#field_transtype').val('AD');
        }else{
            //alert("out");
		$('#div_id_factory').css('display','');
		$('#div_id_transporter').css('display','none');
                
                $('#div_id_material').css('display','none');
		$('#div_id_operating_route').css('display','none');
                $('#div_id_factory_rate').css('display','none');
                //$('#div_ispodreceived').css('display','none');
                //$('#div_ispodsubmitted').css('display','');
                $('#div_transporteradvance').css('display','none');
		$('#field_transtype').val('BL');
	}
}

function own(){
	if($('#field_own').prop('checked')){
            //alert("in");
		$('#div_id_driver_select').css('display','');
		$('#div_id_driver_text').css('display','none');

		//$('#div_id_truck_select').css('display','');
		//$('#div_id_truck_text').css('display','none');
                
                $('#field_transit_details').css('display','');
                $('#div_oilshortage').css('display','');
                $('#div_ispodreceived').css('display','none');
                $('#div_ispodsubmitted').css('display','');
                
	}else{
            //alert("out");
		$('#div_id_driver_select').css('display','none');
		$('#div_id_driver_text').css('display','');
                $('#field_transit_details').css('display','none');
                $('#div_oilshortage').css('display','none');
                $('#div_ispodreceived').css('display','');
                $('#div_ispodsubmitted').css('display','');
		//$('#div_id_truck_select').css('display','none');
		//$('#div_id_truck_text').css('display','');
	}
            
            
            var trucks=JSON.parse('<?php echo json_encode($trucks);?>');
            $('#field_id_truck option').remove();
            $('#field_id_truck').append($("<option></option>").attr("value","").text("--Select--"));
            $.each(trucks,function(key,data){
            var own=$('#field_own').prop('checked')?1:0;
            if(data['own']==own){
            $('#field_id_truck').append($("<option></option>")
                    .attr("value",data['id_truck']+"#"+data['truckno'])
                    .text(data['truckno'])); 
	    }
        });
}

function id_operating_route(){
	//alert($("#field_id_operating_route").val());
	//alert("val of "+$(this).val());
   var or= JSON.parse($("#field_id_operating_route").val());
   //alert(or['operatingroutecode']);
   $("#info-box-or").html("<b>Code</b>:"+or['operatingroutecode']+", <b>Route</b>:"+or['fromplace']+"-"+or['toplace']+",<b>Distance</b>:"+or['distance']+"KM,<b>Toll Charges</b>:"+or['tollcharge']+",<b>TollGates</b>:"+or['nooftollgates']);
   if($('#field_tollexp').val()==""){
        $('#field_tollexp').val(or['tollcharge']);
    }
}

function qty(){
	$('#qtyatloading').html($('#field_qty').val());
}

function bags(){
	$('#bagsatloading').html($('#field_bags').val());
}

function id_factory(){
	//alert($(this).val());
   var ft=$("#field_id_factory").val();
   var frates=JSON.parse('<?php echo json_encode($frates);?>');
   //alert(ft);
   //alert(frates[ft]['material']);
   //alert(frates[3][0]['material']);
   //var options="";
   $('#div_id_factory_rate').css('display','');
   $('#field_id_factory_route_material option').remove();
   $('#field_id_factory_route_material')
         .append($("<option></option>")
                    .attr("value","")
                    .text("select")); 
   $.each(frates[ft],function(key,data){
       //options+='<option value='+JSON.stringify(data)+'>'+data['material']+'-'+data['operatingroutecode']+'-'+data['partycode']+'<option>';
        $('#field_id_factory_route_material')
         .append($("<option></option>")
                    .attr("value",JSON.stringify(data))
                    .text(data['material']+'-'+data['operatingroutecode']+'-'+data['partycode'])); 
    });
}

function id_factory_route_material(){
   //var frm=$(this).val();
   var or= JSON.parse($('#field_id_factory_route_material').val());
   //alert(or['operatingroutecode']);
   $("#info-box-or").html("<b>Code</b>:"+or['operatingroutecode']+", <b>Route</b>:"+or['fromplace']+"-"+or['toplace']+",<b>LPoint</b>:"+or['loadingpoint']+",<b>UnPoint</b>:"+or['unloadingpoint']+",<b>Lcharge</b>:"+or['loadingcharge']+",<b>Uncharge</b>:"+or['unloadingcharge']+",<b>Contact Name/Mobile</b>:"+or['loadingperson']+"/"+or['loadingpersonmobile']+",<b>Distance</b>:"+or['distance']+"KM,<b>Toll Charges</b>:"+or['tollcharge']+",<b>TollGates</b>:"+or['nooftollgates']);
   //if($('#field_tollexp').val()==""){
        $('#field_tollexp').val(or['tollcharge']);
        $('#field_loadingexp').val(or['loadingcharge']);
        $('#field_unloadingexp').val(or['unloadingcharge']);
    //}
    $('#field_billrate').val(or['priceperton']);
}

function rate(){
    var freight="";
    var billrate=$('#field_billrate').val();
    var truckrate=$('#field_truckrate').val();
    var qty=$('#field_qty').val();
    if($('#field_loadprovider').val()=='FT'){
        freight=billrate*qty;
    }else{
        freight=truckrate*qty;
    }
    var bpf=(billrate-truckrate)*qty;    
    
    $('#field_freight').html(freight);
    $('#field_bpf').html(bpf);
}

function id_driver(){
	if($('#field_own').prop('checked')){
        var driver=JSON.parse($('#field_id_driver').val());
        //alert(driver['drivermobile']);
        $('#field_drivermobile').val(driver['drivermobile']);
    }
}

$("#fuel_details_table input[type='text']").on('keyup',function(){
  var id=$(this).attr('id');
  ida=id.split("_");
  //alert(ida[1])
  var idNo=ida[1];
  var amount=parseFloat(parseFloat($("#fuel_"+idNo+"_qty").val())*parseFloat($("#fuel_"+idNo+"_priceperltr").val())) || 0;
  $("#fuel_"+idNo+"_amount").val(amount);
});

</script>