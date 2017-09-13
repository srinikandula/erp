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

function fileUpload($data)
{
	if (is_uploaded_file($data['tmp_name']))
	{
		$fileExt=substr(strrchr($data['name'], '.'), 1);//end(explode(".", $data['name']));
			if (in_array($fileExt, array('jpg','png','jpeg','gif','bmp','psd','pdf'))) {
			$file= $data['input']['prefix'].'.'.$fileExt;
			if(isset($data['input']['prev_file']) && file_exists($data['input']['path'].$data['input']['prev_file']))
			{
					@unlink($data['input']['path'].$data['input']['prev_file']);
			}
			copy($data['tmp_name'], $data['input']['path'].$file);
			return array('status'=>'1','file'=>$file,'msg'=>'upload successfull!!');
		}else
		{
			return  array('status'=>'0','file'=>$data['input']['prev_file'],'msg'=>'Invalid file extension');
		}
	}
	else
	{
		return array('status'=>'0','file'=>$data['input']['prev_file'],'msg'=>'No file to upload!!');
	}
}

function getPathTruckDocs(){
	return DIR_APPLICATION."uploads/truckdocs/";
}

function getLinkTruckDocs(){
	return HTTP_SERVER."uploads/truckdocs/";
}

function getGPBYLATLNGDetails($latlng){
		$exp=explode(",",$latlng);
		//$password=Yii::app()->params['config']['sms_password'];
		$details_url='http://egnom.cloudapp.net/nominatim/reverse?format=json&lat='.$exp[0].'&lon='.$exp[1];
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $details_url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
	    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE); 
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,  2);
		//$result=curl_exec($ch);
		$geoloc = json_decode(curl_exec($ch), true);
		//echo '<pre>';	print_r($geoloc);echo '</pre>';
		$return=array();
		//echo '<pre>';print_r($ch);print_r($geoloc);echo '</pre>';exit;
		$return['input']=$latlng; 
		//$return['status']=$geoloc['status'];

		$addr=array();
		$addr=$geoloc['address'];
		unset($addr['county']);
		unset($addr['country']);
		unset($addr['country_code']);
		unset($addr['postcode']);
		/*$addr[$geoloc['address']['road']]=$geoloc['address']['road'];
		$addr[$geoloc['address']['neighbourhood']]=$geoloc['address']['neighbourhood'];
		$addr[$geoloc['address']['suburb']]=$geoloc['address']['suburb'];
		$addr[$geoloc['address']['town']]=$geoloc['address']['town'];
		$addr[$geoloc['address']['city']]=$geoloc['address']['city'];
		$addr[$geoloc['address']['state_district']]=$geoloc['address']['state_district'];
		$addr[$geoloc['address']['state']]=$geoloc['address']['state'];*/
		//echo implode(",",$addr).'<pre>';print_r($geoloc);print_r($addr);exit;
		$return['address']=implode(",",$addr);
		$return['country']=$geoloc['address']['country'];
		$return['state']=$geoloc['address']['state'];
		$return['city']=$geoloc['address']['city'];
		$return['town']=$geoloc['address']['town'];
		$return['state_district']=$geoloc['address']['state_district'];
		$return['lat']=$geoloc['lat'];
		$return['lng']=$geoloc['lon'];
		$return['postcode']=$geoloc['address']['postcode'];
		$return['county']=$geoloc['address']['county'];
		$return['road']=$geoloc['address']['road'];
		$return['neighbourhood']=$geoloc['address']['neighbourhood'];
		$return['suburb']=$geoloc['address']['suburb'];
		//echo '<pre>';print_r($geoloc);print_r($return);echo '</pre>';exit;
		return $return;
		//return $result;
	}
	
	 function getGPBYLATLNGDetailsGoogle($latlng){
		/*AIzaSyA2kEPrugsp5mwkbHfK3LDYUiiauJwR6IQ - easygaadi001@gmail.com 
AIzaSyCdSrzv1hxzEAK5V7sLnH3y_TIxg7wDrwE - easygaadi002@gmail.com
AIzaSyAcezj-r0GrFMoDeVsSGlytphXTdQeGMN8 - easygaadi003@gmail.com
AIzaSyCXldy85sJDAeLBoyjHVyinvZzUBiuAew4 - easygaadi004@gmail.com
AIzaSyBbFUTMr_UuOH1zCqF6lMMJeWIg7zyNHKc - easygaadi005@gmail.com
AIzaSyDWhEC0B_BRWkRKKctppL8eNP2inr2kRbY - easygaadi11@gmail.com
AIzaSyC57f77D1gQC2u0sU1Wx3YJlZjLq4Cm1bw - easygaadi12@gmail.com
AIzaSyBg7sDLD08foapLP_T68CMA7lZx6MNSlFY - easygaadi13@gmail.com
AIzaSyB30HDD7kJhgrsyg0JjlsjUURRjikJylMA - easygaadi14@gmail.com
AIzaSyCD5AvEnBA_r_LGw9JZa4XClvvMfD8AFj4 - easygaadi15@gmail.com
AIzaSyAD4j1nEgfIeNDFR2ImafB2gw-R7gkB98M - easygaadi16@gmail.com
AIzaSyAHGo13K7lKqgoXgmsmLeyhRiHnE2Or-Bw - easygaadi007@gmail.com
AIzaSyAD9b6iNH1DhCRZzoeYaNBfdaQGhQFcXLM - easygaadi006@gmail.com
AIzaSyB6iBOmTft_fKuB7f-0a6fhMdj199uT6uA - easygaadi008@gmail.com
AIzaSyBvXJmUQS1RLxHj23olw0CALDCrq9Z0PpI - easygaadi009@gmail.com
AIzaSyBelJz9-yw46cp78-UvaEGhzi8jA4c-JfQ - easygaadi10@gmail.com
AIzaSyCwYpYffxQe_lDI7PxN9GUPlyKJUQ-CUO4 - easygaadi17@gmail.com
AIzaSyBVN5oiavvpNBB1_lmLXtLYA1Y2RR1tYtM - easygaadi18@gmail.com
AIzaSyBjpEGA_4eg4wzNQh_nMe1g4awDWYMO6pE -  easygaadi19@gmail.com*/
		$keyarray=array('AIzaSyCGxZ4rJdtex-AZvnn1H5EVcy04Tq-otqI','AIzaSyA2kEPrugsp5mwkbHfK3LDYUiiauJwR6IQ','AIzaSyCdSrzv1hxzEAK5V7sLnH3y_TIxg7wDrwE','AIzaSyAcezj-r0GrFMoDeVsSGlytphXTdQeGMN8','AIzaSyCXldy85sJDAeLBoyjHVyinvZzUBiuAew4','AIzaSyBbFUTMr_UuOH1zCqF6lMMJeWIg7zyNHKc','AIzaSyDWhEC0B_BRWkRKKctppL8eNP2inr2kRbY','AIzaSyC57f77D1gQC2u0sU1Wx3YJlZjLq4Cm1bw','AIzaSyBg7sDLD08foapLP_T68CMA7lZx6MNSlFY','AIzaSyB30HDD7kJhgrsyg0JjlsjUURRjikJylMA','AIzaSyCD5AvEnBA_r_LGw9JZa4XClvvMfD8AFj4','AIzaSyAD4j1nEgfIeNDFR2ImafB2gw-R7gkB98M','AIzaSyAHGo13K7lKqgoXgmsmLeyhRiHnE2Or-Bw','AIzaSyAD9b6iNH1DhCRZzoeYaNBfdaQGhQFcXLM','AIzaSyB6iBOmTft_fKuB7f-0a6fhMdj199uT6uA','AIzaSyBvXJmUQS1RLxHj23olw0CALDCrq9Z0PpI','AIzaSyBelJz9-yw46cp78-UvaEGhzi8jA4c-JfQ','AIzaSyCwYpYffxQe_lDI7PxN9GUPlyKJUQ-CUO4','AIzaSyBVN5oiavvpNBB1_lmLXtLYA1Y2RR1tYtM','AIzaSyBjpEGA_4eg4wzNQh_nMe1g4awDWYMO6pE');

		foreach($keyarray as $key){
		$details_url="https://maps.googleapis.com/maps/api/geocode/json?latlng=".urlencode($latlng)."&sensor=false&key=".$key;//mahindra.mj@gmail.com
		
		//echo $details_url;
		$ch = curl_init();
		curl_setopt($ch, CURLOPT_URL, $details_url);
		curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
		curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
	    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE); 
		curl_setopt($ch, CURLOPT_SSL_VERIFYHOST,  2);
		$geoloc = json_decode(curl_exec($ch), true);
			if($geoloc['results']['0']['formatted_address']!=""){
				break;
			}
		}
		$formatted_addr=$geoloc['results']['0']['formatted_address'];
		if($formatted_addr!=""){
			$formatted_addr_exp=explode(", ",$formatted_addr);
			$formatted_addr_exp_rev=array_reverse($formatted_addr_exp);
		}
		$return=array();
		//echo '<pre>';print_r($ch);print_r($geoloc);echo '</pre>';exit;
		$return['input']=$latlng; 
		$return['status']=$geoloc['status'];
		$return['address']=str_replace("Unnamed Road, ","",$geoloc['results']['0']['formatted_address']);
		$return['country']=$formatted_addr_exp_rev[0];
		$return['state']=$formatted_addr_exp_rev[1];
		$return['city']=$formatted_addr_exp_rev[2];
		$return['lat']=$geoloc['results']['0']['geometry']['location']['lat'];
		$return['lng']=$geoloc['results']['0']['geometry']['location']['lng'];
		return $return;
	}