<?php echo $header;  //echo '<pre>'; print_r($_SESSION);echo '</pre>';?>
<div class="page-heading">
                <span class="page-title"><i class="fa fa-pencil fa-fw"></i> <?php echo $page['title'];?></span>
            </div>
            <div id="page-wrapper">
<!--<div class="alert alert-info alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                            <i class="fa fa-info-circle"></i>  <strong>Like SB Admin?</strong> Try out <a href="http://startbootstrap.com/template-overviews/sb-admin-2" class="alert-link">SB Admin 2</a> for additional features!
                        </div>
                <!--<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> Cannot delete required row
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>-->
                <div class="row">
                    <!--<div class="col-md-4">
                        <div class="info-container info-row">
                            <div class="info-btn">
                                <div class="info-count">72</div>
                                <div class="info-title">Total</div>
                            </div>
                            <div class="info-btn">
                                <div class="info-count">29</div>
                                <div class="info-title">Pending Payment Devices</div>
                            </div>
                        </div>
                        <div class="item-status-container col-md-12">
                            <div class="item-status col-md-6">
                                <div class="item-status-clr-patch patch1"></div>
                                <div class="item-status-text status1">Working</div>
                            </div>
                            <div class="item-status col-md-6">
                                <div class="item-status-clr-patch patch2"></div>
                                <div class="item-status-text status2">Damaged</div>
                            </div>
                                                        <div class="item-status col-md-6">
                                <div class="item-status-clr-patch patch2"></div>
                                <div class="item-status-text status2">Damaged</div>
                            </div>
                                                        <div class="item-status col-md-6">
                                <div class="item-status-clr-patch patch2"></div>
                                <div class="item-status-text status2">Damaged</div>
                            </div>
                        </div>  
                    </div>-->
                    
                    <div class="col-md-8">
                        <div class="row">
                            <div class="search-container search-row col-md-12">
                                <form id="horizontalFormFilter" class="form-horizontal-filter" method="post">
                                    <input class="search-input" type="text" name="filter_material" placeholder="Material">
                                    <input class="search-input" type="text" name="filter_materialcode" placeholder="Material Code">
                                    <input id="submitFilter" class="sbmt-btn" type="submit" name="search" value="Search">
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <!--<div class="col-md-8">
                                <div class="btn-group btn-group-justified">
                                    <a href="#" class="btn btn-primary">Assign Devices</a>
                                    <a href="#" class="btn btn-primary">Transfer Devices</a>
                                    <a href="#" class="btn btn-primary">Confirm Payment</a>
                                </div>

                            </div>-->
                            <div class="search-container search-row col-md-4">
                                <div class="btn-group btn-group-justified">
                                    <!--<a href="#" class="btn btn-primary <?php echo $addPermClass;?>"  ><i class="fa fa-fw fa-plus"></i>Add</a>-->
                                    <!--<a href="#" class="btn btn-danger <?php echo $deletePermClass;?>" onclick="fnBulkAction('index.php?route=settings/materials/delete&token=<?php echo $token; ?>','index.php?route=settings/materials/getlist&token=<?php echo $token; ?>')"><i class="fa fa-trash-o fa-lg"></i> Delete</a>-->
                                    <a href="#" class="btn btn-danger <?php echo $deletePermClass;?>" id="btnDelete"><i class="fa fa-trash-o fa-lg"></i> Delete</a>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>

                <div class="row" >
                    <form id="horizontalFormList" class="form-horizontal-list" method="post" >
                    <div class="col-md-9" id="idGridContainer">
                       <!-- grid -->
                    </div>
                    </form>
                    <div id="form_right" class="right-side-form col-md-3">
                        <div class="right-side-form-title"><?php echo $page['title'];?> <span style="font-style:italic;font-size:10px;font-weight:bold">Add/Edit</span></div>
                        <form id="horizontalForm" class="form-horizontal" method="post" >
                            <div class="form-group">

                                <label for="accountID" class="col-md-4 required">Material:</label>
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
                            <div class="sbmt-btn-holder"> <button type="submit" class="right-side-form-sbmt-btn" onclick="fnSubmit('edit');return false;"><li class="fa fa-pencil fa-fw"></li> Update</button><button type="submit" class="right-side-form-sbmt-btn" onclick="fnSubmit('add');return false;"><li class="fa fa-fw fa-plus"></li> Create</button>
                            </div>
                            
                        </form>
                    </div>
            <!-- /.row -->
                </div>


            

        <!-- /.container-fluid -->

    </div>
    <!-- /#page-wrapper -->

</div>
<script>
    
   
    
    function fnEdit(str){
        //alert(str.material)
        //$('#form_right').hide();
        //$("#form_right" ).fadeToggle();
        //$("#form_right" ).fadeToggle();
        $('#field_material').val(str.material);
        $('#field_materialcode').val(str.materialcode);
        $('#pkey').val(str.id_material);
        
        
    }
    
    function fnSubmit(btn){
        //alert("in submit")
        //e.preventDefault();
        var flag=1;
        if($('#field_material').val()==""){
            //alert("inside");
            $('#field_material').closest('.col-md-8').addClass('has-error');
            var flag=0;
        }else{
            $('#field_material').closest('.col-md-8').removeClass('has-error');
        }
        
        if($('#field_materialcode').val()==""){
            //alert("inside");
            $('#field_materialcode').closest('.col-md-8').addClass('has-error');
            var flag=0;
        }else{
            $('#field_materialcode').closest('.col-md-8').removeClass('has-error');
        }
        var type=$('#pkey').val();
        var submitTo="settings/materials/"+btn;
        //var submitTo="edit";
        //alert(submitTo);
        if(flag){
   
            $.ajax({
			url: 'index.php?route='+submitTo+'&token=<?php echo $token; ?>',
			type: 'post',
			data:$('#horizontalForm').serialize(),
			dataType: 'json',
			beforeSend: function() {
				//alert('before send');
                                removeFlashLoading();
                                getFlashLoading();
			},
			complete: function() {
				//alert('complete');
                                
			},
			success: function(json) {
                            
                            //alert('in success');
                            if(json['status']){
                                $('#list_material_'+type).html($('#field_material').val());
                                $('#list_materialcode_'+type).html($('#field_materialcode').val());
                                //$('#page-wrapper').before(getFlashWrapper('success',json['msg']));                 
                                
                                //reset form
                                $('#field_material').val("");
                                $('#field_materialcode').val("");
                                $('#pkey').val("");
                                if(btn=='add'){
                                    getList('index.php?route=<?php echo $_GET["route"];?>/getlist&token=<?php echo $token; ?>');
                                }
                                removeFlashLoading();
                                getFlashWrapper('success',json['msg']);
                            }else{
                            //$('#page-wrapper').before(getFlashWrapper('danger',json['msg']));
                            getFlashWrapper('danger',json['msg']);
                            }
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
          
        }else{
            //alert("in else")
            return false;
        }
    }   




function getList(pageUrl){
    //alert("in list");
removeFlashLoading();
        $.ajax({
	url: pageUrl,
	type: 'post',
	//data:$('#horizontalForm').serialize(),
	//dataType: 'json',
	beforeSend: function() {
		//alert('before send');
						getFlashLoading();
	},
	complete: function() {
		//alert('complete');
						removeFlashLoading();
	},
	success: function(data) {
		$('#idGridContainer').html(data);
	},
	error: function(xhr, ajaxOptions, thrownError) {
		alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
	}
});
}

    /*$("#idGridContainer a").click(function(e){
	e.preventDefault();
        alert(this.href);
        getList(this.href)
});*/

$("#idGridContainer").on("click","a", function(e){
  e.preventDefault();
        //alert(this.href);
        getList(this.href)
});

$("#btnDelete").on("click", function(e){
  e.preventDefault();
  //alert("on click");
  var data=$('form#horizontalFormList').serialize();
  //alert(data);
  if(data!=""){
  //getList('index.php?route=settings/materials/getlist&token=<?php echo $token; ?>');
  fnBulkAction('index.php?route=settings/materials/delete&token=<?php echo $token; ?>','index.php?route=settings/materials/getlist&token=<?php echo $token; ?>',data);
  }
        
});

$("#submitFilter").on("click", function(e){
  e.preventDefault();
  //alert("on click");
  var data=$('form#horizontalFormFilter').serialize();
  //alert(data);
  getList('index.php?route=settings/materials/getlist&token=<?php echo $token; ?>&'+data);
  /*if(data!=""){
  
  fnBulkAction('index.php?route=settings/materials/delete&token=<?php echo $token; ?>','index.php?route=settings/materials/getlist&token=<?php echo $token; ?>',data);
  }
  getList(this.href)*/
        
});

$("#idGridContainer").load("index.php?route=settings/materials/getlist&token=<?php echo $token; ?>");

</script>
<?php echo $footer; ?>