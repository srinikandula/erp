<?php
function token($length = 32) {
	// Create random token
	$string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
	
	$max = strlen($string) - 1;
	
	$token = '';
	
	for ($i = 0; $i < $length; $i++) {
		$token .= $string[mt_rand(0, $max)];
	}	
	
	return $token;
}

function getUrlString($fieldData,$ignore=array()){
	$url="";
	foreach($fieldData as $col=>$val){
		if ($val!="" && !in_array($col,$ignore)) {
			$url .= '&'.$col.'=' . urlencode(html_entity_decode($val, ENT_QUOTES, 'UTF-8'));
		}
	}
	return $url;
}

function getSortLink($data){
	if ($data['sortedBy'] == $data['column']) {
	echo '<a href="' . $data['link'] . '">'.$data['title'].' <i class="fa fa-sort-' . strtolower($data['orderTypeIcon']) . '" aria-hidden="true"></i></a>';
	} else {
	echo '<a href="' . $data['link'] . '">'.$data['title'].'</a>';
	}
}

function getInputText($input){
	$labelClass=!isset($input['labelClass'])?"col-md-4":$input['labelClass'];
	$divClass=!isset($input['divClass'])?"col-md-8":$input['divClass'];
	$mainDivClass=!isset($input['mainDivClass'])?"form-group":$input['mainDivClass'];
	$inputClass=!isset($input['inputClass'])?"form-control":$input['inputClass'];
	$required=$input['required']==1?"required":"";
	$astrick=$input['required']==1?'<span class="mandatory">*</span>':"";
	$inputType=	!isset($input['type'])?"text":$input['type'];
	$value=isset($input['value'])?$input['value']:"";
	$mainDivId=!isset($input['mainDivId'])?"":'id="'.$input['mainDivId'].'"';


	echo '<div class="'.$mainDivClass.' required" '.$mainDivId.' >
			<label for="accountID" class="'.$labelClass.'">'.$input['title'].$astrick.' :</label>
			<div class="'.$divClass.'">
				<input name="field['.$input['col'].']" type="'.$inputType.'" class="'.$inputClass.'"  placeholder="'.$input['title'].'" data-toggle="tooltip" data-placement="auto top" title="'.$input['title'].'" id="field_'.$input['col'].'" value="'.$value.'" '.$required.'>
			</div>
		</div>';
}

function getInputTextArea($input){
	$labelClass=!isset($input['labelClass'])?"col-md-4":$input['labelClass'];
	$divClass=!isset($input['divClass'])?"col-md-8":$input['divClass'];
	$mainDivClass=!isset($input['mainDivClass'])?"form-group":$input['mainDivClass'];
	$inputClass=!isset($input['inputClass'])?"form-control":$input['inputClass'];
	$required=$input['required']==1?"required":"";
	$rows=!isset($input['rows'])?"2":$input['rows'];
	$cols=!isset($input['cols'])?"10":$input['cols'];
	$tooltip=!isset($input['tooltip'])?$input['title']:$input['tooltip'];
	$astrick=$input['required']==1?'<span class="mandatory">*</span>':"";
	
	echo '<div class="'.$mainDivClass.' required">
			<label for="accountID" class="'.$labelClass.'">'.$input['title'].$astrick.' :</label>
			<div class="'.$divClass.'"><textarea name="field['.$input['col'].']" rows="'.$rows.'" cols="'.$cols.'" placeholder="'.$input['title'].'" class="'.$inputClass.'"   data-toggle="tooltip" data-placement="auto top" title="'.$tooltip.'" id="field_'.$input['col'].'" '.$required.'></textarea>
				</div>
		</div>';
}

function getTruckPayTypes(){
	return array(//"PD"=>"Paid",
		         "BL"=>"Bill",
				 "TP"=>"To Pay",
				 "AD"=>"Advance/POD",
			);
}

function getTravelType(){
	return array("1"=>"ONWARD",
		         "0"=>"RETURN"
				);
}

function getLoadProviders(){
	return array("TR"=>"Transporter",
		         "FT"=>"Factory",
				 //"PT"=>"Party",
				);
}

function getPaymentMode(){
	return array(
	    "CH"=>"Cash",
		"CQ"=>"Cheque",
		"AT"=>"Account Transfer");
}

function getStoreItemTypes(){
	return array(
	    "SP"=>"Spare",
		"OL"=>"Oil",
		"TY"=>"Tyre");
}

function getTransactionTypes(){
	return array(
	    "CR"=>"Credit",
		"DR"=>"Debit");
}