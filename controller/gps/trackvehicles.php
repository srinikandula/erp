<?php

class ControllerGpsTrackvehicles extends Controller {
    //error_reporting(E_ERROR);
    private $error = array();
    public $viewPathPrefix='gps/trackvehicles';	
    public function index() {
        //$_SESSION['gps_account_id']='vampvt';
        //$this->document->setTitle('Out Truck Payments');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        $this->document->setTitle($data['page']['title']);
        $this->user->gpsDeviceSession();
        //echo '<pre>';print_r($_SESSION['device']);exit;
        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        $todayUnix=strtotime('now')+19800;
        $ystdayUnix=$todayUnix-86400;
        $today=gmdate("Y-m-d H:i", $todayUnix);
        $ystday=gmdate("Y-m-d H:i", $ystdayUnix);
        
        $to=$_POST['to_date'];
        $from=$_POST['from_date'];
        $truckregno=$_POST['deviceID'];
                
        $data['data']['groups']=$rows;
        $data['data']['dtoday']=$today;
        $data['data']['dystday']=$ystday;
        $accountID=$_SESSION['gps_account_id'];
        if (($this->request->server['REQUEST_METHOD'] == 'POST')){
            
            $query="SELECT ifnull(latitude,0) as latitude, ifnull(longitude,0) as longitude, ceil(speedKPH) as speed, (ifnull(timestamp,0)+19800) as time_in_secs, FROM_UNIXTIME(ifnull(timestamp,0), '%d-%m-%Y %k:%i') as date_time,heading,distanceKM,odometerKM FROM EventData WHERE latitude!=0 and longitude!=0 and  accountID='".$accountID."' and deviceID ='".$truckregno."' AND timestamp <= unix_timestamp('".$to."') AND timestamp >=unix_timestamp('".$from."')  ORDER BY timestamp";
				
            /*$query2="SELECT max(odometerKM) as max_odokm,ceil(sum(distanceKM)) as distancetravelled,ceil((sum(speedKPH)/count(*))) as avgspeed FROM EventData WHERE speedKPH!=0 and deviceID like '".$truckregno."' AND timestamp <= unix_timestamp('".$to."') AND timestamp >=unix_timestamp('".$from."')";*/
				$too=strtotime($to);
				$fromm=strtotime($from);
				$qryRows=$this->newdb->query($query);	
                                $rows=$qryRows->rows;
                                $points=array();
                                $speedVal=0;
                                $speedCount=0;
                                $distanceTravelled=0;
                                $loop=0;
                                $rowSize=sizeof($rows);
				$miss=$rowSize>50?1:1;
                                foreach($rows as $row){
                                    if($row["speed"]>0){
                                        $speedVal+=$row["speed"];
                                        $speedCount+=1;
                                        $distanceTravelled+=$row["distanceKM"];
                                    }
                                    if($loop){
                                        $loop=$loop==$miss?0:$loop+1;
                                        continue;
                                    }
                                    $loop++;
                                    $points[]=array("distanceTravelled"=>  number_format($row['distanceKM'],2)." Km","odo"=>$row["odometerKM"],"latitude"=>$row["latitude"],"longitude"=>$row["longitude"],"speed"=>$row["speed"],"time_in_secs"=>$row["time_in_secs"],"date_time"=>$row["date_time"],"heading"=>$row["heading"],"address"=>$addr['address']);
                                }
                                $speedAvg=ceil($speedVal/$speedCount);
                                $timeTravelled=floor($distanceTravelled/$speedAvg);
				
				if($speedAvg<30){
					$running_status='Running Slow';
				}else if($speedAvg>30 && $speedAvg<55){
					$running_status='Running on Time';
				}else if($speedAvg>55){
					$running_status='Running Fast';
				}
				if(is_array($rows) && sizeof($rows)){
                                $json['statusCode']=1;
                                //$json['success']['odokm']=ceil($info[max_odokm]-$info[min_odokm])." Km";
                                //$json['odokm']=ceil($info[max_odokm])." Km";
                                $json['deviceID']=$truckregno;
                                $json['from']=$from;
                                $json['to']=$to;
                                $json['diff']=$too-$fromm;
                                $json['idleTime']=$idleTime." Hours";
                                $json['distanceTravelled']=floor($distanceTravelled)." Km";
                                $json['timeTravelled']=$timeTravelled." Hours";
                                $json['averageSpeed']=$speedAvg." Km/Hr";
                                $json['runningStatus']=$running_status;
                                $json['points']=$points;
                                //Yii::app()->session['trackReport']=$json;
                                //Yii::app
                                //echo '<pre>';print_r($json);echo '</pre>';exit;
                }else{
                    $json['statusCode']=0;
                }
            
            $data['data']['track']=$json;
        }
        
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
}