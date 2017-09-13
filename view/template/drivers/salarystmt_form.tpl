<div id="myModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4><?php echo $page['title']; ?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span>
               <!--<i class="fa fa-print pull-right" onclick="printDiv()" aria-hidden="true"></i>--> </h4>
                <div class="modal-body col-md-12" id="modal-body">
                    <div id="form_right">

                        <form id="horizontalForm" class="form-horizontal" method="post" >

                            <?php
                                getInputText(array("value"=>"2016-08-23","col" => "datefrom", "title" => "Date From", "required" => 1, "mainDivClass" => "form-group col-md-6"));
                                getInputText(array("labelClass"=>"col-md-5","divClass"=>"col-md-7","value"=>"2016-08-26","col" => "dateto", "title" => "Date To", "required" => 1, "mainDivClass" => "form-group col-md-5"));?><div  id="idDateDiff"></div>
                                <?php
                                getInputText(array("col" => "settlementdate", "title" => "Settlement Date", "required" => 1, "mainDivClass" => "form-group col-md-6"));
                            ?>
                            <div class="form-group col-md-6 required">
                                <label for="accountID" class="col-md-4">Driver<span class="mandatory">*</span> :</label>
                                <div class="col-md-8">
                                    <select class="form-control" name="field[id_driver]" id="field_id_driver" >
                                        <option value="">--Select--</option>
                                        <?php
                                        foreach ($drivers as $driver) {
                                            echo "<option value='" .json_encode($driver). "'>" . $driver['drivername'] . "(".$driver['drivercode'].")</option>";
                                        }
                                        ?>
                                    </select>
                                    <input  type="hidden" name="pkey" id="pkey">
                                </div>
                            </div>
                            <?php 
                            //getInputText(array("col" => "batta", "title" => "Batta", "required" => 0, "mainDivClass" => "form-group col-md-6"));
                            //getInputText(array("col" => "pertrippercentonfreight", "title" => "Percent On Freight Per Trip", "required" => 0, "mainDivClass" => "form-group col-md-6"));
                            //getInputText(array("col" => "pertripcommission", "title" => "Commission Per Trip", "required" => 0, "mainDivClass" => "form-group col-md-6"));
                            //getInputText(array("col" => "fixedpermonth", "title" => "Fixed Per Month", "required" => 0, "mainDivClass" => "form-group col-md-6"));
                            getInputText(array("col" => "paidon", "title" => "Paid On", "required" => 0, "mainDivClass" => "form-group col-md-6"));?>
			    <div class="form-group col-md-6 required">
                                <label for="accountID" class="col-md-4">Paid By Branch<span class="mandatory">*</span> :</label>
                                <div class="col-md-8">
                                    <select class="form-control" name="field[paidby_id_branch]" id="field_paidby_id_branch" >
                                    </select>
                                </div>
                            </div>
			    
			    <?php getInputTextArea(array("col" => "comment", "title" => "Comment", "required" => 0, "mainDivClass" => "form-group col-md-6"));
			    ?>
                            <div class="form-group col-md-6">
                                <label for="accountID" class="col-md-4">Close Statement:</label>
                                <div class="col-md-8">
                                    <input name="field[closed]" type="checkbox"  placeholder="Close" data-toggle="tooltip" data-placement="auto top" id="field_close"  value="1" title="Close">
                                </div>
                            </div>
                            <div class="col-md-12 table-container">
    <div><b>Trip Details</b></div>
    <table class="table table-responsive table-bordered table-condensed table-striped" id="trip_details_table">
        <thead>
            <tr>
                <th>Trip Id</th>
                <th>Truck No</th>
                <th>Dispatch Date</th>
                <th>Route</th>
                <th>Adv</th>
                <th>Trip Exp</th>
		<!-- <th>Batta</th> -->
                <th>Shortage</th>
                <th>Damage</th>
                <th>Oil Shortage</th>
                <th><button name='btnGettrips' id='btnGettrips' type='button' class='btn btn-primary' >Get Trips</button></th>
            </tr>
        </thead>
        <tbody>
            <tr id='row_trip_no' ><td colspan="9">No Trips Found</td></tr>
        </tbody>
            
        
    </table>
    <table class="table table-responsive table-bordered table-condensed table-striped" id="factory_rates_table">
        <thead>
            <tr>
		<th>No Of Leaves</th>
                <th>Total Trips</th>
                <th>Total Freight</th>
                <th>Total Advance</th>
                <th>Total Trip Exp</th>
                <th>Total Shortage</th>
                <th>Total Damage</th>
                <th>Total Oil Shortage</th>
                
            </tr>
        </thead>
        <tbody>
            <tr>
                <!--<td><input name="triptotal[totaltrips]" class="form-control" placeholder="Total Trips" data-toggle="tooltip" data-placement="auto top" title="Total Trips" id="triptotal_totaltrips" type="text"></td>
                
                <td><input name="triptotal[totalfreight]" class="form-control" placeholder="Total Freight" data-toggle="tooltip" data-placement="auto top" title="Total Freight" id="triptotal_totalfreight" type="text"></td>
                
                <td><input name="triptotal[totaladv]" class="form-control" placeholder="Total Advance" data-toggle="tooltip" data-placement="auto top" title="Total Advance" id="triptotal_totaladv" type="text"></td>
                
                <td><input name="triptotal[totaltripexp]" class="form-control" placeholder="Total Trip Expenses" data-toggle="tooltip" data-placement="auto top" title="Total Trip Expenses" id="triptotal_totaltripexp" type="text"></td>
                
                <td><input name="triptotal[totalshortage]" class="form-control" placeholder="Total Shortage" data-toggle="tooltip" data-placement="auto top" title="Total Shortage" id="triptotal_totalshortage" type="text"></td>
                
                <td><input name="triptotal[totaldamage]" class="form-control" placeholder="Total Damage" data-toggle="tooltip" data-placement="auto top" title="Total Damage" id="triptotal_totaldamage" type="text"></td>
                
                <td><input name="triptotal[totaloilshortage]" class="form-control" placeholder="Total Oil Shortage" data-toggle="tooltip" data-placement="auto top" title="Total Oil Shortage" id="triptotal_totaloilshortage" type="text"></td>-->
                <td>    
                <input name="field[totalleaves]" type="text" class="form-control" placeholder="Leaves" title="Leaves" id="triptotal_totalleaves" ></td>

                <td><input name="field[totaltrips]" class="form-control" placeholder="Total Trips" data-toggle="tooltip" data-placement="auto top" title="Total Trips" id="triptotal_totaltrips" type="text"></td>
                
                <td><input name="field[totalfreight]" class="form-control" placeholder="Total Freight" data-toggle="tooltip" data-placement="auto top" title="Total Freight" id="triptotal_totalfreight" type="text"></td>
                
                <td><input name="field[totaladvance]" class="form-control" placeholder="Total Advance" data-toggle="tooltip" data-placement="auto top" title="Total Advance" id="triptotal_totaladv" type="text"></td>
                
                <td><input name="field[totaltripexp]" class="form-control" placeholder="Total Trip Expenses" data-toggle="tooltip" data-placement="auto top" title="Total Trip Expenses" id="triptotal_totaltripexp" type="text"></td>
                
                <td><input name="field[totalshortage]" class="form-control" placeholder="Total Shortage" data-toggle="tooltip" data-placement="auto top" title="Total Shortage" id="triptotal_totalshortage" type="text"></td>
                
                <td><input name="field[totaldamage]" class="form-control" placeholder="Total Damage" data-toggle="tooltip" data-placement="auto top" title="Total Damage" id="triptotal_totaldamage" type="text"></td>
                
                <td><input name="field[totaloilshortage]" class="form-control" placeholder="Total Oil Shortage" data-toggle="tooltip" data-placement="auto top" title="Total Oil Shortage" id="triptotal_totaloilshortage" type="text"></td>
                
            </tr>
        </tbody>
    </table>
</div>
                            <div class="col-md-12 table-container">
    <div><b>Payment Details</b></div>
    <table class="table table-responsive table-bordered table-condensed table-striped" id="driver_payment_table">
        <thead>
            <tr>
                <th>Batta Amount</th>
		<th>Days Paid</th>
                <th>Percent On Freight</th>
                <th>Trip Commsion</th>
                <th>Fixed</th>
                <th>Deductions</th>
                <th>Adv</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <tr>
		<td><input name="field[batta]" type="text" class="form-control" placeholder="Batta" title="Batta" id="field_batta" ></td>
		<td><input name="field[dayspaid]" type="text" class="form-control" placeholder="Days Paid" title="Days Paid" id="field_dayspaid"></td>
                <!-- <td><div class="input-group"><input name="field[batta]" type="text" class="form-control" placeholder="Batta" title="Batta" id="field_batta" ><span class="input-group-addon">*</span><input name="field[dayspaid]" type="text" class="form-control" placeholder="Days Paid" title="Days Paid" id="field_dayspaid"></div></td> -->
                <td><div class="input-group"><input name="field[pertrippercentonfreight]" type="text" class="form-control" placeholder="Percent On Freight" title="Percent On Freight" id="field_pertrippercentonfreight"><span class="input-group-addon">*</span><span id="span_total_frieght" class="col-md-4" ></span></div></td>
                <td><div class="input-group"><input name="field[pertripcommission]" type="text" class="form-control" placeholder="Commission Per Trip" data-toggle="tooltip" data-placement="auto top" title="Commission Per Trip" id="field_pertripcommission" ><span class="input-group-addon">*</span><span id="span_total_trips" class="col-md-4"></span></div></td>
                <td><input name="field[fixedpermonth]" type="text" class="form-control" placeholder="Fixed Per Month" data-toggle="tooltip" data-placement="auto top" title="Fixed Per Month" id="field_fixedpermonth"></td>
                <td><span id="span_total_deductions" ></span></td>
                <td><span id="span_adv_bal"></span></td>
                <td>    
                <input name="field[totalpayableamount]" type="text" class="form-control" placeholder="Payable Amount" data-toggle="tooltip" data-placement="auto top" title="Payable Amount" id="field_totalpayableamount" style="width:100px" ></td>
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

<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.js"></script>    
<script>
    $(function() {
        $("#field_datefrom, #field_dateto, #field_settlementdate, #field_paidon").datepicker({dateFormat: 'yy-mm-dd'});
    });

    $("#field_id_driver").on('change', function() {
        var dr= JSON.parse($(this).val());
        //$("#field_batta").val(dr['batta']);
        $("#field_pertrippercentonfreight").val(dr['pertrippercentonfreight']);
        $("#field_pertripcommission").val(dr['pertripcommission']);
        $("#field_fixedpermonth").val(dr['fixedpermonth']);
        calPayment();
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
            //$("#field_dayspaid").val(days);
        }else{
            $("#idDateDiff").html("");
            //$("#field_dayspaid").val('');
        }
        calPayment();
    });
    
    $("#triptotal_totaltrips, #triptotal_totalfreight, #triptotal_totaladv, #triptotal_totaltripexp, #triptotal_totalshortage, #triptotal_totaldamage, #triptotal_totaloilshortage, #field_batta, #field_dayspaid, #field_pertrippercentonfreight, #field_fixedpermonth, #field_pertripcommission").on('keyup',function(){
        
        calPayment();
    });
    
    
    function calPayment(){
        var batta=parseFloat($("#field_batta").val());
        var dayspaid=parseFloat($("#field_dayspaid").val());
        
        var pertrippercentonfreight=parseFloat($("#field_pertrippercentonfreight").val());
        var pertripcommission=parseFloat($("#field_pertripcommission").val());
        var fixedpermonth=parseFloat($("#field_fixedpermonth").val());
        var totaltrips=parseFloat($("#triptotal_totaltrips").val());
        var totalfreight=parseFloat($("#triptotal_totalfreight").val());
        var totaladv=parseFloat($("#triptotal_totaladv").val());
        var totaltripexp=parseFloat($("#triptotal_totaltripexp").val());
        var totalshortage=parseFloat($("#triptotal_totalshortage").val());
        var totaldamage=parseFloat($("#triptotal_totaldamage").val());
        var totaloilshortage=parseFloat($("#triptotal_totaloilshortage").val());
        
        //alert(batta+" batta "+dayspaid+" dayspaid "+pertrippercentonfreight+" perent on freight "+ pertripcommission+" commi "+  fixedpermonth+" fixed per month "+ totaltrips+" total trips "+ totalfreight+" total freigh "+ totaladv+" total adv "+ totaltripexp+" total trip exp "+ totalshortage+" total short "+ totaldamage+" total damage "+ totaloilshortage);
        //(s-(x+y-z))-ledgexp
        
        $('#span_total_frieght').html(totalfreight);
        $('#span_total_trips').html(totaltrips);
        $('#span_total_deductions').html(totalshortage+totaldamage+totaloilshortage);
        $('#span_adv_bal').html(totaladv);
        
        var salary;
        //salary=(batta*dayspaid)+((pertrippercentonfreight*totalfreight)/100)+(pertripcommission*totaltrips)+fixedpermonth;
	salary=(batta)+((pertrippercentonfreight*totalfreight)/100)+(pertripcommission*totaltrips)+fixedpermonth;	
        var payment=salary-((totaladv+(totalshortage+totaldamage+totaloilshortage))-totaltripexp);
        $("#field_totalpayableamount").val(payment);
        //alert(salary+" "+payment);
    }
    
	/*function printDiv() 
	{

	  var divToPrint=document.getElementById('modal-body');

	  var newWin=window.open('','Print-Window');

	  newWin.document.open();

	  newWin.document.write('<html><body onload="window.print()">'+divToPrint.innerHTML+'</body></html>');

	  newWin.document.close();

	  setTimeout(function(){newWin.close();},10);

	}*/
</script>