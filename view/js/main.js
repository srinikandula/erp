$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip({trigger:'hover'});
});

function getFlashWrapper(type,msg){
	var symbol;
	if(type=='success'){
		symbol='<i class="fa fa-check-circle"></i>';
	}else if(type=='danger'){
		symbol='<i class="fa fa-times-circle"></i>';
	}else if(type=='info'){
	
	}
	$('.page-title').after('<div id="loadingFlash" class="alert alert-'+type+' alert-dismissable text-center"  style="width:50%;float:right;height:25px;"><button type="button" class="close" data-dismiss="alert" aria-hidden="true"><i class="fa fa-times-circle-o"></i></button><strong>'+symbol+'</strong> '+msg+'</div>');
	//alert("here in else");
}

function getFlashLoading(){
	$('.page-title').after('<div id="loadingFlash" class="alert alert-info alert-dismissable text-center"  style="width:50%;float:right;height:25px;"><button aria-hidden="true" data-dismiss="alert" class="close" type="button"><i class="fa fa-times-circle-o"></i></button><strong><i class="fa fa-cog fa-spin fa-1x fa-fw"></i></strong> Loading,Please Wait!!</div>');
}

/*function getFlashWrapperLoading(content){
	$('.page-title').after('<div id="loadingFlash" class="alert alert-info alert-dismissable text-center"  style="width:50%;float:right;height:25px;"><button aria-hidden="true" data-dismiss="alert" class="close" type="button"><i class="fa fa-times-circle-o"></i></button><strong><i class="fa fa-cog fa-spin fa-1x fa-fw"></i></strong> Loading,Please Wait!!</div>');
}*/

function removeFlashLoading(){
	//alert("hello")
	$('#loadingFlash').remove();
}

function fnBulkAction(pageUrl,pageListUrl,formData)
{
      //var atLeastOneIsChecked = $('input[name=\"id[]\"]:checked').length > 0;
      //var atLeastOneIsChecked = $('input[name=\"'+field+'\"]:checked').length > 0;
		var atLeastOneIsChecked = $('input[name=\"selected[]\"]:checked').length > 0;
		
	if (!atLeastOneIsChecked)
	{
			//js:bootbox.alert('No rows selected!!');
                        //alert('No rows selected!!');
		removeFlashLoading()
		//$('#page-wrapper').before(getFlashWrapper('danger','No rows selected,Please select atleast one!'));
		getFlashWrapper('danger','No rows selected,Please select atleast one!')
	}/*else{
        js:bootbox.confirm("Are you sure?", function(confirmed){ console.log(confirmed);return confirmed;{alert("Confirmed: "+confirmed);}
            if(confirmed){flag=true}else{ flag= false}})
    alert(console.log.value)
    }*/
  
	else if(confirm('Are you sure you want to perform selected action?'))
	{
		$.ajax({
			url: pageUrl,
			type: 'post',
			//data:$('#horizontalFormList').serialize(),
			data:formData,
			dataType: 'json',
			beforeSend: function() {
				//alert('before send');
                                getFlashLoading();
			},
			complete: function() {
				//alert('complete');
                                //removeFlashLoading();
			},
			success: function(json) {
				removeFlashLoading();
                            //alert('in success');
                            if(json['status']){
								//$('#page-wrapper').before(getFlashWrapper('success',json['msg'])); 
								getFlashWrapper('success',json['msg']);
								getList(pageListUrl);
                            }else{
								//$('#page-wrapper').before(getFlashWrapper('danger',json['msg']));
								
								getFlashWrapper('danger',json['msg']);
                            }
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});
			//return true;
	}else
	{
		return false;
	}
}

 function getList(pageUrl) {
	removeFlashLoading();
	$.ajax({
		url: pageUrl,
		type: 'post',
		beforeSend: function() {
			getFlashLoading();
		},
		complete: function() {
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