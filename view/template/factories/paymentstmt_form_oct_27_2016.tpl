<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span>
                <span class="pull-right" id="span_id_factory_payment"></span></h4>
                <div class="modal-body col-md-12">
                    <div id="form_right">

                        <form id="horizontalForm" class="form-horizontal" method="post" >
                            <?php
                                getInputText(array("value"=>"","col" => "datefrom", "title" => "Date From", "required" => 1, "mainDivClass" => "form-group col-md-6"));
                                getInputText(array("labelClass"=>"col-md-5","divClass"=>"col-md-7","value"=>"","col" => "dateto", "title" => "Date To", "required" => 1, "mainDivClass" => "form-group col-md-5"));?><div  id="idDateDiff"></div>
                                <?php
                                getInputText(array("col" => "billgendate", "title" => "Bill Date", "required" => 1, "mainDivClass" => "form-group col-md-6"));
                            ?>
                            <div class="form-group col-md-6 required">
                                <label for="accountID" class="col-md-4">Factory<span class="mandatory">*</span> :</label>
                                <div class="col-md-8">
                                    <select class="form-control" name="field[id_factory]" id="field_id_factory" >
                                        <option value="">--Select--</option>
                                        <?php
                                        foreach ($factories as $factory) {
                                            //echo "<option value='" .json_encode($factory). "'>" . $factory['factoryname'] . "(".$factory['factorycode'].")</option>";
                                            echo "<option value='" .$factory['id_factory']. "'>" . $factory['factoryname'] . "(".$factory['factorycode'].")</option>";
                                        }
                                        ?>
                                    </select>
                                    <input  type="hidden" name="pkey" id="pkey">
                                    <input  type="hidden" name="field[paymentcycle]" id="field_paymentcycle">
                                </div>
                            </div>
                            <?php 
                            //getInputText(array("col" => "batta", "title" => "Batta", "required" => 0, "mainDivClass" => "form-group col-md-6"));
                            //getInputText(array("col" => "pertrippercentonfreight", "title" => "Percent On Freight Per Trip", "required" => 0, "mainDivClass" => "form-group col-md-6"));
                            //getInputText(array("col" => "pertripcommission", "title" => "Commission Per Trip", "required" => 0, "mainDivClass" => "form-group col-md-6"));
                            //getInputText(array("col" => "fixedpermonth", "title" => "Fixed Per Month", "required" => 0, "mainDivClass" => "form-group col-md-6"));
                            getInputTextArea(array("col" => "comment", "title" => "Comment", "required" => 0, "mainDivClass" => "form-group col-md-6"));?>
                            <!--<div class="form-group col-md-6">
                                <label for="accountID" class="col-md-4">Close Statement:</label>
                                <div class="col-md-8">
                                    <input name="field[closed]" type="checkbox"  placeholder="Close" data-toggle="tooltip" data-placement="auto top" id="field_close"  value="1" title="Close">
                                </div>
                            </div>-->
                            <div class="col-md-12 table-container">
    <div><b>Trip Details</b></div>
    <table class="table table-responsive table-bordered table-condensed table-striped" id="trip_details_table">
        <thead>
            <tr>
                <th>Trip Id</th>
                <th>Truck No</th>
                <th>Dispath Date</th>
                <th>Route</th>
                <th>Freight</th>
                <th>Qty</th>
                <th>Shortage</th>
                <th>Damage</th>
                <th>Toll</th>
                <th>LCharge</th>
                <th>ULCharge</th>
                <th><button name='btnGettrips' id='btnGettrips' type='button' class='btn btn-primary' >Get Trips</button></th>
            </tr>
        </thead>
        <tbody>
            <tr id='row_trip_no' ><td colspan="12">No Trips Found</td></tr>
        </tbody>
            
        
    </table>
    <div><b>Payment Details</b></div>
    <table class="table table-responsive table-bordered table-condensed table-striped" id="factory_rates_table">
        <thead>
            <tr>
                <th>Total Trips</th>
                <th>Total Freight</th>
                <th>Total Shortage</th>
                <th>Total Damage</th>
                <th>TDS</th>
                <th>VAT</th>
                <th>Toll Charges</th>
                <th>LCharges</th>
                <th>UL Charges</th>
                <th>Advance</th>
                <th>Net Amount</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td><input name="field[totaltrips]" class="form-control" placeholder="Total Trips" data-toggle="tooltip" data-placement="auto top" title="Total Trips" id="field_totaltrips" type="text"></td>
                
                <td><input name="field[freight]" class="form-control" placeholder="Total Freight" data-toggle="tooltip" data-placement="auto top" title="Total Freight" id="field_freight" type="text"></td>
                
                <td><input name="field[shortage]" class="form-control" placeholder="Total Shortage" data-toggle="tooltip" data-placement="auto top" title="Total Shortage" id="field_shortage" type="text"></td>
                
                <td><input name="field[damage]" class="form-control" placeholder="Total Damage" data-toggle="tooltip" data-placement="auto top" title="Total Damage" id="field_damage" type="text"></td>
                
                <td><input name="field[tds]" class="form-control" placeholder="TDS" data-toggle="tooltip" data-placement="auto top" title="TDS" id="field_tds" type="text"><span id="span_tdsamount"></span></td>
                
                <td><input name="field[vat]" class="form-control" placeholder="VAT" data-toggle="tooltip" data-placement="auto top" title="VAT" id="field_vat" type="text"><span id="span_vatamount"></span></td>
                
                <td><input name="field[toll]" class="form-control" placeholder="Toll" data-toggle="tooltip" data-placement="auto top" title="Toll" id="field_toll" type="text"></td>
                
                <td><input name="field[loading]" class="form-control" placeholder="loading" data-toggle="tooltip" data-placement="auto top" title="Loading" id="field_loading" type="text"></td>
                
                <td><input name="field[unloading]" class="form-control" placeholder="unloading" data-toggle="tooltip" data-placement="auto top" title="UnLoading" id="field_unloading" type="text"></td>
                
                <td><input name="field[advance]" class="form-control" placeholder="Advance" data-toggle="tooltip" data-placement="auto top" title="Advance" id="field_advance" type="text" value="0"></td>
                
                <td><input name="field[totalreceivableamount]" class="form-control" placeholder="Net Amount" data-toggle="tooltip" data-placement="auto top" title="Net Amount" id="field_totalreceivableamount" type="text"></td>
            </tr>
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
</div>

<div id="myModalSub" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4>Factory Payment History <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></h4>
                    <div class="modal-body col-md-12">
                        <div class="col-md-12 table-container">
                        <div><b>Bill Details</b></div>
                        <table class="table table-responsive table-bordered table-condensed table-striped" id="factory_paymentbill_table">
                            <thead>
                                <tr>
                                    <th>Bill No</th>
                                    <th>Factory</th>
                                    <th>Bill Gen Date</th>
                                    <th>Billed Amount</th>
                                    <th>Received Amount</th>
                                    <th>Balance Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td id="td_id_factory_payment" ></td>
                                    <td id="td_factoryname" ></td>
                                    <td id="td_billgendate"></td>
                                    <td id="td_totalreceivableamount" ></td>
                                    <td id="td_paidamount" ></td>
                                    <td id="td_balanceamount" ></td>
                                </tr>
                            </tbody>
                        </table>
                        
                        </div>
                        
                        <div class="col-md-12 table-container">
                            <div><b>Payment History</b></div>
                            <form id="horizontalSubForm" class="form-horizontal" method="post" >
                            <table class="table table-responsive table-bordered table-condensed table-striped" id="factory_payment_table">
                                <thead>
                                    <tr>
                                        <th>Part/Full<span class="mandatory">*</span></th>
                                        <th>Amount<span class="mandatory">*</span></th>
                                        <th>Date Received<span class="mandatory">*</span></th>
                                        <th>Payment Mode<span class="mandatory">*</span></th>
                                        <th>Branch<span class="mandatory">*</span></th>
                                        <th>Payment Ref</th>
                                        <th></th>
                                    </tr>
                                    
                                    <tr id="input_payment_history">
                                        <th><select class="form-control" name="field[paymenttype]" id="field_paymenttype">
<option value="Part">Part</option>
<option value="Full">Full</option>
</select><input name="field[id_factory_payment]" id="field_id_factory_payment" type="hidden"></th>
                                        <th><input name="field[amount]" class="form-control" placeholder="Amount" data-toggle="tooltip" data-placement="auto top" title="Amount" id="field_amount" data-original-title="Amount"  type="text"></th>
                                        
                                        <th><input name="field[datereceived]" class="form-control" placeholder="Date Received" data-toggle="tooltip" data-placement="auto top" title="Date Received" id="field_datereceived" data-original-title="Date Received"  type="text"></th>
                                        
                                        <th><select class="form-control" name="field[paymentmode]" id="field_paymentmode">
<option value="">--Select--</option>
<?php foreach(getPaymentMode() as $k=>$v){ echo '<option value="'.$k.'">'.$v.'</option>'; }?>
</select></th>
                                        
                                        <th><select class="form-control" name="field[id_branch]" id="field_id_branch">
<option value="">--Select--</option><?php foreach($branches as $row){ 
    $hq=$row['isheadoffice']==1?"(HQ)":"";
    echo '<option value="'.$row['id_branch'].'">'.$row['branchcity']."(".$hq.")".'</option>'; }?></select>
                                        </th>
                                        
                                        <th><input name="field[paymentref]" class="form-control" placeholder="Payment Ref" data-toggle="tooltip" data-placement="auto top" title="Payment Ref" id="field_paymentref" data-original-title="Payment Ref"  type="text"></th>
                                        
                                        <th><i class="fa fa-plus" onclick="fnAddRecord()"></th>
                                    
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                                
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <!--<button id="btnUpdate" type="submit" class="btn btn-primary <?php echo $editPermClass; ?>" onclick="fnSubmitParty();
                            return false;"><li class="fa fa-pencil fa-fw"></li> Update</button>-->
                </div>
            </div>
        </div>
    </div>
</div>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>    
<script>
    $(function() {
        $("#field_datefrom, #field_dateto, #field_billgendate, #field_datereceived").datepicker({dateFormat: 'yy-mm-dd'});
    });


    
    $("#field_datefrom, #field_dateto").on('change',function(){
        var datefrom=$("#field_datefrom").val();
        var dateto=$("#field_dateto").val();
        if(datefrom!="" && dateto!="" )
        {
            var diff = new Date(new Date(dateto) - new Date(datefrom));
            var days=(diff/1000/60/60/24)+1;
            //alert(days);
            $("#idDateDiff").html(days+" Days");
            $("#field_dayspaid").val(days);
        }else{
            $("#idDateDiff").html("");
            $("#field_dayspaid").val('');
        }
        calPayment();
    });
    
    $("#field_freight, #field_tds, #field_vat, #field_toll, #field_loading, #field_unloading, #field_advance,  #field_shortage, #field_damage").on('keyup',function(){
        
        calPayment();
    });
    
    
    function calPayment(){
        
        var totaltrips=parseFloat($("#field_totaltrips").val());
        var totalfreight=parseFloat($("#field_freight").val());
        var totalshortage=parseFloat($("#field_shortage").val());
        var totaldamage=parseFloat($("#field_damage").val());
        var totaladvance=parseFloat($("#field_advance").val()) || 0;
        //alert("total advance"+totaladvance);
        var input_tds=parseFloat($("#field_tds").val()) || 0;
        var input_vat=parseFloat($("#field_vat").val()) || 0;
        
        var totaltoll=parseFloat($("#field_toll").val());
        var totalloading=parseFloat($("#field_loading").val());
        var totalunloading=parseFloat($("#field_unloading").val());
        
        var vat=(totalfreight*input_vat)/100;
        var tds=(totalfreight*input_tds)/100;
        
        $('#span_vat').html(vat);
        $('#span_tds').html(tds);
        //alert(" total freight "+totalfreight+" shortage "+totalshortage+" damage "+totaldamage+" adva "+totaladvance+" loading "+totalloading+" unloading "+totalunloading+" toll "+totaltoll+" vat "+vat+" tds "+tds);
        var vatamount=parseFloat((((totalfreight)-(totalshortage+totaldamage)+(totalloading+totalunloading+totaltoll))*input_vat)/100);
	var tdsamount=parseFloat((((totalfreight)-(totalshortage+totaldamage)+(totalloading+totalunloading+totaltoll))*input_tds)/100);
	var netamount=0;
        netamount=parseFloat((totalfreight)-(totalshortage+totaldamage+totaladvance)+(totalloading+totalunloading+totaltoll)+(vatamount+tdsamount)) || 0;
        $("#field_totalreceivableamount").val(netamount);
        //alert(netamount);
        //alert(salary+" "+payment);
    }
    
//$("#myModalSub").modal('show');
</script>