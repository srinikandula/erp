<?php

//session_start();
class ControllerGpsGpsvehicles extends Controller {
    //error_reporting(E_ERROR);
    private $error = array();
    public $viewPathPrefix='gps/gpsvehicles';	
    public function index() {
        
		//$_SESSION['gps_account_id']='venkatreddy';
        //$this->document->setTitle('Out Truck Payments');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        $this->document->setTitle($data['page']['title']);
        
		$this->user->gpsDeviceSession();
        //exit("here");
		//echo '<pre>';print_r($_SESSION['device']);exit;
        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        //$query = $this->newdb->query("SELECT * from Account where accountID like 'ramreddy'");
	//echo '<pre>';print_r($query);exit;
        /*$this->load->model('settings/gpsaccount');
        $branchesQry=$this->model_settings_gpsaccount->getItem('vampvt');
        echo '<pre>';
        print_r($branchesQry);exit;*/
        
        $date=date('Y-m-d');
        $this->getTodayODO($date);
	//$data=array();
        //exit("here");
        $qryGroup=$this->newdb->query("select groupID,displayName from DeviceGroup where accountID='".$_SESSION['gps_account_id']."'");
        
        $data['data']['groups']=$qryGroup->rows;
        $gid=isset($_GET['gid'])?(int)$_GET['gid']:0;
        if($gid){
            $qryDevices=$this->newdb->query("select lastValidHeading,lastGPSTimestamp,FROM_UNIXTIME(ifnull(lastUpdateTime,0), '%d-%b %k:%i') as date_time,deviceID,lastValidLatitude,lastValidLongitude,ceil(lastValidSpeedKPH*1.852) as lastValidSpeedKPH,ceil(lastOdometerKM) as lastOdometerKM from Device where accountID='".$_SESSION['gps_account_id']."' and isActive=1 and groupID='".$gid."'");
            $data['data']['devices']=$qryDevices->rows;
        }else{
            $qryDevices=$this->newdb->query("select lastValidHeading,lastGPSTimestamp,FROM_UNIXTIME(ifnull(lastUpdateTime,0), '%d-%b %k:%i') as date_time,deviceID,lastValidLatitude,lastValidLongitude,ceil(lastValidSpeedKPH*1.852) as lastValidSpeedKPH,ceil(lastOdometerKM) as lastOdometerKM from Device where accountID='".$_SESSION['gps_account_id']."' and isActive=1");
            $data['data']['devices']=$qryDevices->rows;
        }
		
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getTodayODO($date){
        
        //unset($_SESSION[$date]);
        if(!isset($_SESSION[$date])){
        //if(1){
            //echo 'inside';
            foreach($_SESSION['device'] as $k=>$v){
                //echo $v."<br/>";
                    $row=$this->newdb->query("select ceil(odometerKM) as odometerKM from EventData where accountID like '".$_SESSION['gps_account_id']."' and deviceID like '".$v['deviceID']."' and timestamp>=".strtotime($date)." limit 1");
                    //echo '<pre>';print_r($row);exit;
                    $_SESSION[$date][$v['deviceID']]=$row->row['odometerKM'];
            }
        }
    }
    
    public function getajaxgroupmap(){
        
        $data=array();
        $gid=isset($_GET['gid'])?(int)$_GET['gid']:0;
        $date=date('Y-m-d');
        $this->getTodayODO($date);
        $_SESSION['overSpeedLimit']=70;
		//exit("value of ".$gid);
        //echo 'outside';
        //echo strtotime($date).'<pre>';print_r($_SESSION);exit;
        if($gid){
            $qry=$this->newdb->query("select lastValidHeading,lastGPSTimestamp,FROM_UNIXTIME(ifnull(lastUpdateTime,0), '%d-%b %k:%i') as date_time,deviceID,lastValidLatitude,lastValidLongitude,ceil(lastValidSpeedKPH*1.852) as lastValidSpeedKPH,ceil(lastOdometerKM) as lastOdometerKM from Device where accountID='".$_SESSION['gps_account_id']."' and isActive=1 and groupID='".$gid."'");
            $rows=$qry->rows;
        } else {
            $qry=$this->newdb->query("select lastValidHeading,lastGPSTimestamp,FROM_UNIXTIME(ifnull(lastUpdateTime,0), '%d-%b %k:%i') as date_time,deviceID,lastValidLatitude,lastValidLongitude,ceil(lastValidSpeedKPH*1.852) as lastValidSpeedKPH,ceil(lastOdometerKM) as lastOdometerKM from Device where accountID='".$_SESSION['gps_account_id']."' and isActive=1");
            $rows=$qry->rows;
            
        }
        
        foreach($rows as $k=>$device){
            $data['devices'][$k]=$device;
			$trColorUpdate="";
            if($device['lastGPSTimestamp']+5400<strtotime('now')){ $trColorUpdate='style="background-color:#ed2b37;"'; }

            if($device['lastValidSpeedKPH']>0 && $device['lastValidSpeedKPH']<$_SESSION['overSpeedLimit']) { 
                $tdColorSpeed= 'class="success"';
            } else if($device['lastValidSpeedKPH']>=$_SESSION['overSpeedLimit']){ 
                $tdColorSpeed='style:background-color:maroon'; 
            } else { 
                $tdColorSpeed= 'class="danger"'; 
            }
            
			if($_SESSION[$date][$device['deviceID']]!=""){
				$todayODO=$device['lastOdometerKM']-$_SESSION[$date][$device['deviceID']];
            }else{
				$todayODO=0;
			}
			//echo $device['lastOdometerKM']."-".$_SESSION[$date][$device['deviceID']]."<br/>";
            if($device['lastGPSTimestamp']+5400<strtotime('now')){'style="background-color:#ed2b37;"'; }
            $addr=$device['lastValidLatitude'].",".$device['lastValidLongitude'];
            
			if($device['lastValidSpeedKPH']>$_SESSION['overSpeedLimit']){$overSpeedColor='style="background-color:#660066;color:white;font-weight:bold"';}else{$overSpeedColor='';}
			
			$tr='<tr '.$trColorUpdate.'><td><a href="javascript:fnSearch(\''.$device['deviceID'].'\')" ><strong>'.$device['deviceID'].'</strong></a><br><small>'.$device['date_time'].'</small></td> <td  '.$tdColorSpeed.'><small><a '.$overSpeedColor.' href="javascript:fnShowMarkerAddress(\''.$device['deviceID'].'\',\''.$device['lastValidSpeedKPH'].'\',\''.$addr.'\',\''.$device['lastOdometerKM'].'\')" >'.$device['lastValidSpeedKPH'].' Km/Hr</a> - <span id="today"><a href="javascript:fnShowMarker(\''.$device['deviceID'].'\')">'.$todayODO.' Km</a></span></small></td></tr>';

            $data['devices'][$k]['tr']=$tr;
        }
        //echo '<pre>';print_r($rows);print_r($_SESSION);print_r($data);exit;
        echo json_encode($data);
        
        
        //echo '{"devices":[{"lastGPSTimestamp":"1479449663","date_time":"18-11-2016 11:55","deviceID":"AP13Y3500","lastValidLatitude":"17.526795","lastValidLongitude":"78.51504166666666","lastValidSpeedKPH":"0","lastOdometerKM":"3351.241648052934"},{"lastGPSTimestamp":"1479449474","date_time":"18-11-2016 11:55","deviceID":"AP29V9039","lastValidLatitude":"17.44065","lastValidLongitude":"78.49495","lastValidSpeedKPH":"0","lastOdometerKM":"3020.267651873785"},{"lastGPSTimestamp":"1479450529","date_time":"18-11-2016 11:55","deviceID":"AP29W1372","lastValidLatitude":"17.495893333333335","lastValidLongitude":"78.39651333333333","lastValidSpeedKPH":"30","lastOdometerKM":"3779.4549863653406"},{"lastGPSTimestamp":"1479449894","date_time":"18-11-2016 11:54","deviceID":"AP29W2174","lastValidLatitude":"17.46165","lastValidLongitude":"78.45587666666665","lastValidSpeedKPH":"0","lastOdometerKM":"3454.0314991755117"},{"lastGPSTimestamp":"1479449177","date_time":"18-11-2016 11:54","deviceID":"AP9TA4171","lastValidLatitude":"17.46484","lastValidLongitude":"78.44812333333334","lastValidSpeedKPH":"0","lastOdometerKM":"1331.9589849319768"},{"lastGPSTimestamp":"1479450505","date_time":"18-11-2016 11:55","deviceID":"TS07EU4105","lastValidLatitude":"17.461655","lastValidLongitude":"78.455805","lastValidSpeedKPH":"0","lastOdometerKM":"3563.5416357912727"},{"lastGPSTimestamp":"1479448399","date_time":"18-11-2016 11:33","deviceID":"TS07UB1858","lastValidLatitude":"17.407091666666666","lastValidLongitude":"78.47413333333333","lastValidSpeedKPH":"0","lastOdometerKM":"2563.056187811016"},{"lastGPSTimestamp":"1479450418","date_time":"18-11-2016 11:54","deviceID":"TS15UA4504","lastValidLatitude":"17.441866666666666","lastValidLongitude":"78.49549166666667","lastValidSpeedKPH":"6","lastOdometerKM":"3900.3077588009774"}]}';
        exit; 
    }
}