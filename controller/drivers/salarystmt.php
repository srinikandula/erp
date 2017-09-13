<?php

class ControllerDriversSalarystmt extends Controller {

    private $error = array();
    public $viewPathPrefix='drivers/salarystmt';	
    
    public function index() {

        $data = $this->user->getPageAccessInfo($this->request->get['route']);
		$this->document->setTitle($data['page']['title']);
        
        
        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        $this->load->model('settings/driver');
        $filter_data = array(
                'sort' => 'drivername',
                'order' => 'asc'
        );
        $drivers=$this->model_settings_driver->getItems($filter_data);
        //$data['drivers'] =$drivers->rows;
        foreach($drivers->rows as $row){
            $data['drivers'][$row['id_driver']]=$row;
			$data['drivers'][$row['id_driver']]['driveraddress']=trim(preg_replace('/\s\s+/', ' ', $row['driveraddress']));
        }
        
        $this->load->model('settings/branch');
        $filter_data = array(
                'sort' => 'branchcity',
                'order' => 'asc'
        );
        $branches=$this->model_settings_branch->getItems($filter_data);
        foreach($branches->rows as $row){
            $data['branches'][$row['id_branch']]=$row;
			$data['branches'][$row['id_branch']]['branchaddress']=trim(preg_replace('/\s\s+/', ' ', $row['branchaddress']));
        }
        
        //echo '<pre>';print_r($data['trucktypes']);exit;
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        
        $this->load->model('settings/driversalary');
        $route = $this->request->get['route'];
        
        $data['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'datecreated';
        $data['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : 'DESC';
        $data['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : 1;

        //$filter_material=isset($this->request->get['filter_material'])?$this->request->get['filter_material']:'';
	//$filter_materialcode=isset($this->request->get['filter_materialcode'])?$this->request->get['filter_materialcode']:'';
		
        //$urlData['filter_material']=$filter_material;
        //$urlData['filter_materialcode']=$filter_materialcode;
        $urlData['sort']=isset($this->request->get['sort']) ? $this->request->get['sort'] : '';
        $urlData['order']=isset($this->request->get['order']) ? $this->request->get['order'] : '';
        $urlData['page']=isset($this->request->get['page']) ? $this->request->get['page'] : '';
        $urlDataIgnore=array();
        $buttonUrl=getUrlString($urlData,$urlDataIgnore);
        $data['delete'] = $this->url->link($route . '/delete', 'token=' . $this->session->data['token'] . $buttonUrl, true);

        $data['items'] = array();

        $filter_data = array(
        //    'filter_material' => $filter_material,
        //    'filter_materialcode' => $filter_materialcode,
            'sort' => $data['sort'],
            'order' => $data['order'],
            'start' => ($data['page'] - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $itemTotal = $this->model_settings_driversalary->getTotalItems($filter_data);
        $results = $this->model_settings_driversalary->getItems($filter_data);
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
	$this->load->model('settings/driversalarytrip');
        foreach ($results->rows as $k=>$result) {
            $dstrips = $this->model_settings_driversalarytrip->getItems(array('filter_id_driver_salary' => $result['id_driver_salary'],'limit' => 100,'start'=>0));
            $data['items'][$k]=$result;
            $data['items'][$k]['id']=$result['id_driver_salary'];
            $data['items'][$k]['trips']=$dstrips->rows;
            $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_driver_salary'] . $buttonUrl, true);
            $data['items'][$k]['sno']=$k+$pageSno;
        }
        
        $urlDataIgnore=array('page');
        $pageUrl=getUrlString($urlData,$urlDataIgnore);

        $pagination = new Pagination();
        $pagination->total = $itemTotal;
        $pagination->page = $data['page'];
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link($route, 'token=' . $this->session->data['token'] . $pageUrl . '&page={page}', true);
        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf('Showing %d to %d of %d (%d Pages)', ($itemTotal) ? (($data['page'] - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($data['page'] - 1) * $this->config->get('config_limit_admin')) > ($itemTotal - $this->config->get('config_limit_admin'))) ? $itemTotal : ((($data['page'] - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $itemTotal, ceil($itemTotal / $this->config->get('config_limit_admin')));
        
        $urlData['order']=$data['order']=='ASC'?'DESC':'ASC';
        $urlDataIgnore=array('sort');
	$sortUrl=getUrlString($urlData,$urlDataIgnore);
        //$data['sort_truckno'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=truckno' . $sortUrl, true);
        $data['selected']=isset($this->request->post['selected'])?(array) $this->request->post['selected']:array();	
	
        $this->response->setOutput($this->load->view($this->viewPathPrefix.'_list', $data));
    }
    
    public function add() {
        
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/driversalary');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['datecreated']=$this->globalVal['todayDateTime'];
            $json_dr=json_decode($_POST['field']['id_driver']);
            $cols['id_driver']=$json_dr->id_driver;
            $cols['closed']=isset($this->request->post['field']['closed'])?1:0;
            $id=$this->model_settings_driversalary->addItem($cols);
            $this->load->model('settings/driversalarytrip');
            foreach($_POST['trip'] as $trip){
                $json_tp=json_decode($trip);
                //echo "<pre>";print_r($json_tp);exit;
                $tcols['id_trip']=$json_tp->id_trip;
                $tcols['id_driver_salary']=$id;
                $tcols['truckno']=$json_tp->truckno;
                $tcols['dispatchdate']=$json_tp->dispatchdate;
                $tcols['id_operating_route']=$json_tp->id_operating_route;
                $tcols['operatingroutecode']=$json_tp->operatingroutecode;
                $tcols['driveradvance']=$json_tp->driveradvance;
                $tcols['tripexpense']=$json_tp->tripexpense;
//$json_tp->tollexp+$json_tp->repairexp+$json_tp->loadingexp+$json_tp->unloadingexp+$json_tp->policeexp+$json_tp->dieselexp;
                $tcols['freight']=$json_tp->freight;
                $tcols['shortage']=$json_tp->shortage;
                $tcols['damage']=$json_tp->damage;
                $tcols['oilshortage']=$json_tp->oilshortage;
                //echo $json_tp->tollexp."+".$json_tp->repairexp."+".$json_tp->loadingexp."+".$json_tp->unloadingexp."+".$json_tp->policeexp."+".$json_tp->dieselexp;
                //echo '<pre>';print_r($tcols);
                $this->model_settings_driversalarytrip->addItem($tcols);
            }
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        //echo '<pre>';print_r($_POST);EXIT;
        echo json_encode($json);
    }

    public function edit() {
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        //if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $id=$this->request->post['pkey'];
            $this->load->model('settings/driversalary');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $json_dr=json_decode($_POST['field']['id_driver']);
            $cols['id_driver']=$json_dr->id_driver;
            $cols['closed']=isset($this->request->post['field']['closed'])?1:0;
            $this->model_settings_driversalary->editItem($id, $cols);
            
            $this->load->model('settings/driversalarytrip');
            $this->model_settings_driversalarytrip->deleteItemByDriverSalaryID($id);
            foreach($_POST['trip'] as $trip){
                $json_tp=json_decode($trip);
                $cols1['id_trip']=$json_tp->id_trip;
                $cols1['id_driver_salary']=$id;
                $cols1['truckno']=$json_tp->truckno;
                $cols1['dispatchdate']=$json_tp->dispatchdate;
                $cols1['id_operating_route']=$json_tp->id_operating_route;
                $cols1['operatingroutecode']=$json_tp->operatingroutecode;
                $cols1['driveradvance']=$json_tp->driveradvance;
                $cols1['tripexpense']=$json_tp->tripexpense;
                //$json_tp->tollexp+$json_tp->repairexp+$json_tp->loadingexp+$json_tp->unloadingexp+$json_tp->policeexp+$json_tp->dieselexp;
                $cols1['freight']=$json_tp->freight;
                $cols1['shortage']=$json_tp->shortage;
                $cols1['damage']=$json_tp->damage;
                $cols1['oilshortage']=$json_tp->oilshortage;
                //echo '<pre>';print_r($cols1);
                $this->model_settings_driversalarytrip->addItem($cols1);
            }
            //exit("after trips");
            
            $json['status'] = 1;
            $json['msg'] = FLASH_EDIT_SUCCESS_MSG;
            $cols['id']=$this->request->post['pkey'];
            $json['data']= json_encode($cols);
            $json['trips']=$cols1;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        //echo '<pre>';print_r($_POST);exit;
        echo json_encode($json);
    }
    
    public function getTrips() {
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        //if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $this->load->model('settings/trip');
            $this->load->model('settings/driverleave');
            $input['datefrom']=$this->request->post['datefrom'];
            $input['dateto']=$this->request->post['dateto'];
            $salarydays=$this->request->post['salarydays'];
            $js_id_driver=json_decode($_POST['id_driver']);
            $input['id_driver']=$js_id_driver->id_driver;
            
            $tripsObj=$this->model_settings_trip->getTripsByDriverID($input);
            //echo '<pre>';print_r($tripsObj);
            $totalBatta=0;
            $totalShortage=0;
            $totalDamage=0;
            $totalOilShortage=0;
            $totalAdv=0;
            $totalTripExp=0;
            $totalFreight=0;
            $tripExp=0;
            $rows=$tripsObj->rows;
            $countRows=sizeof($rows)-1;
            foreach($rows as $k=>$row){
                $json['data']['trips'][$k]=$row;
                //$json['data']['trips'][$k]['tripexpense']=$row['tollexp']+$row['repairexp']+$row['loadingexp']+$row['unloadingexp']+$row['policeexp']+$row['dieselexp'];
                //$json_tp->tollexp+$json_tp->repairexp+$json_tp->loadingexp+$json_tp->unloadingexp+$json_tp->policeexp+$json_tp->dieselexp
                $tripExp=($row['tollexp']+$row['loadingexp']+$row['unloadingexp']+$row['policeexp']+$row['repairexp']+$row['dieselexp'])+($row['otherexp']+$row['parkingexp']+$row['tappalexp']+$row['assocfeesexp']+$row['teleexp']);
                $json['data']['trips'][$k]['tripexpense']=$tripExp;
                $totalShortage+=$row['shortage'];
                $totalDamage+=$row['damage'];
                $totalOilShortage+=$row['oilshortage'];
                $totalAdv+=$row['driveradvance'];
                $totalFreight+=$row['freight'];
                $totalTripExp+=$tripExp;
                $row['batta'];
                //echo $rows[$k]['transactiondate']." ".$rows[$k+1]['transactiondate']."</br>";
                if($countRows==$k){
                    if($rows[$k]['transactiondate']!=$input['datefrom']){
                        $date2=date_create(date('Y-m-d', strtotime('-1 day', strtotime($rows[$k]['transactiondate']))));//date_create($rows[$k]['transactiondate']);
                        $date1=date_create($input['datefrom']);
                        //$totalBatta+=$this->calcBatta(array('date1'=>date_format($date1, 'Y-m-d'),'date2'=>date_format($date2, 'Y-m-d'),'batta'=>$row['batta']));
                        $totalBatta+=$this->calcBatta(array('date1'=>$date1,'date2'=>$date2,'batta'=>$row['batta'],'id_driver'=>$input['id_driver']));
                    }
                    
                    $date1=date_create($rows[$k]['transactiondate']);
                    $date2=date_create(date('Y-m-d', strtotime('-1 day', strtotime($rows[$k-1]['transactiondate']))));
                    
                }else if ($k==0){
                    $date1=date_create($rows[$k]['transactiondate']);
                    $date2=date_create($input['dateto']);
                    
                }else {
                    $date1=date_create($rows[$k]['transactiondate']);
                    $date2=date_create(date('Y-m-d', strtotime('-1 day', strtotime($rows[$k-1]['transactiondate']))));
                }
                $totalBatta+=$this->calcBatta(array('date1'=>$date1,'date2'=>$date2,'batta'=>$row['batta'],'id_driver'=>$input['id_driver']));
                //echo $date1['date'].'<pre>';print_r($date1);exit;
                    
            }
            //exit("value of ".$totalBatta);
            $this->load->model('settings/driverleave');
            
            $json['data']['totalLeaves']=$this->model_settings_driverleave->getLeaveDays($input);
            $json['data']['totalPaidDays']=$salarydays-$json['data']['totalLeaves'];
            $json['data']['totalBatta']=$totalBatta;//$this->model_settings_driverleave->getLeaveDays($input);
            $json['data']['totalTrips']=$tripsObj->num_rows;
            $json['data']['totalShortage']=$totalShortage;
            $json['data']['totalDamage']=$totalDamage;
            $json['data']['totalOilShortage']=$totalOilShortage;
            $json['data']['totalAdv']=$totalAdv;
            $json['data']['totalTripExp']=$totalTripExp;
            $json['data']['totalFreight']=$totalFreight;
            //echo '<pre>';print_r($input); print_r($json['data']);
            $json['status'] = 1;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }
    
    public function calcBatta($input){
        //echo '<pre>';print_r($input['date1']);print_r($input['date2']);exit;
	$ldays=$this->model_settings_driverleave->getLeaveDays(array('datefrom'=>date_format($input['date1'], 'Y-m-d'),'dateto'=>date_format($input['date2'], 'Y-m-d'),'id_driver'=>$input['id_driver']));
        if(date_format($input['date1'], 'Y-m-d')!=date_format($input['date2'], 'Y-m-d')){
                //echo "if".date_format($input['date1'], 'Y-m-d')." / ".date_format($input['date2'], 'Y-m-d')."<br/>";
		$diff=date_diff($input['date1'],$input['date2']);
		$totalBatta=($diff->format("%a")+1-$ldays)*$input['batta'];
	}else{
		//echo "else".date_format($input['date1'], 'Y-m-d')." / ".date_format($input['date2'], 'Y-m-d')."<br/>";
		$totalBatta=(1-$ldays)*$input['batta'];
	}
        return $totalBatta;
    }

    public function delete() {
        
        $json['status'] = 0;
        if (isset($this->request->post['selected']) && $this->validateDelete(array('perm' => 'delete'))) {
            $this->load->model('settings/driversalary');
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_driversalary->deleteItem($id);
            }
            $json['status'] = 1;
            $json['msg'] = FLASH_DELETE_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    protected function validateForm($input) {
        //echo '<pre>';print_r($this->user->getPermission());
        
        if (!$this->user->hasPermission($input['perm'], 'trucks/trucks')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        //exit;
        //exit($input['perm']."value of ".$this->user->hasPermission($input['perm'], 'settings/materials'));
        return !$this->error;
    }

    protected function validateDelete($input) {
        if (!$this->user->hasPermission($input['perm'], 'trucks/trucks')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        return !$this->error;
    }
}