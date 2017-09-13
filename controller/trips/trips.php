<?php

class ControllerTripsTrips extends Controller {

    private $error = array();
    public $viewPathPrefix='trips/trips';	
    
    public function index() {

        //$this->document->setTitle('Trips');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        $this->document->setTitle($data['page']['title']);

        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        //trucks
        $this->load->model('settings/truck');
        $filter_data = array(
                'sort' => 'truckno',
                'order' => 'asc'
        );
        $trucksQry=$this->model_settings_truck->getItems($filter_data);
        $data['trucks'] =$trucksQry->rows;
        
        //materials
        /*$this->load->model('settings/material');
        $filter_data = array(
                'sort' => 'material',
                'order' => 'asc'
        );
        $materialsQry=$this->model_settings_material->getItems($filter_data);
        $data['materials'] =$materialsQry->rows;*/
        
        //factories
        $this->load->model('settings/factory');
        $filter_data = array(
                'filter_status'=>1,
                'sort' => 'factoryname',
                'order' => 'asc'
        );
        $factoriesQry=$this->model_settings_factory->getItems($filter_data);
        $data['factories'] =$factoriesQry->rows;
        
        //transporters
        $this->load->model('settings/transporter');
        $filter_data = array(
                'filter_status'=>1,
                'sort' => 'transporter',
                'order' => 'asc'
        );
        $transportersQry=$this->model_settings_transporter->getItems($filter_data);
        $data['transporters'] =$transportersQry->rows;
        
        //operating_route
        $this->load->model('settings/operatingroute');
        $filter_data = array(
                'filter_status'=>1,
                'sort' => 'fromplace',
                'order' => 'asc'
        );
        $operatingroutesQry=$this->model_settings_operatingroute->getItems($filter_data);
        //$data['operatingroutes'] =$operatingroutesQry->rows;
        foreach($operatingroutesQry->rows as $row){
            $data['operatingroutes'][$row['id_operating_route']]=$row;
        }
        
        
        //drivers
        $this->load->model('settings/driver');
        $filter_data = array(
                'filter_status'=>1,
                'sort' => 'drivername',
                'order' => 'asc'
        );
        $driversQry=$this->model_settings_driver->getItems($filter_data);
        //$data['drivers'] =$driversQry->rows;
        foreach($driversQry->rows as $row){
            $data['drivers'][$row['id_driver']]=$row;
        }
        
        //fuelstation
        $this->load->model('settings/fuelstation');
        $filter_data = array(
                'sort' => 'fuelstationname',
                'order' => 'asc'
        );
        $fuelsQry=$this->model_settings_fuelstation->getItems($filter_data);
        $data['fuels'] =$fuelsQry->rows;
        
        //Branches
        $this->load->model('settings/branch');
        $filter_data = array(
            'sort' => 'branchcity',
            'order' => 'asc'
        );
        $branchQry=$this->model_settings_branch->getItems($filter_data);
        $data['branches'] =$branchQry->rows;
        
        
        //factoryrates
        $this->load->model('settings/factoryrate');
        
        $fratesQry=$this->model_settings_factoryrate->getFactoryRatesByFactory();
        foreach($fratesQry->rows as $row){
            $data['frates'][$row['id_factory']][]=$row;
        }
        foreach($fratesQry->rows as $row){
            $data['fratesById'][$row['id_factory_rate']]=$row;
        }
        //$fratesById
        
        //echo '<pre>';print_r($data['frates']);exit;
        //echo '</pre>';
       
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        //echo '<pre>';print_r($_GET);echo '</pre>';exit;
        $this->load->model('settings/trip');
        
        $route = $this->request->get['route'];
        
        $data['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'datecreated';
        $data['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : 'DESC';
        $data['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : 1;

        $filter_id_transporter=isset($this->request->get['filter_id_transporter'])?$this->request->get['filter_id_transporter']:'';
	$filter_id_factory=isset($this->request->get['filter_id_factory'])?$this->request->get['filter_id_factory']:'';
        $filter_id_driver=isset($this->request->get['filter_id_driver'])?$this->request->get['filter_id_driver']:'';
	$filter_factory_os=isset($this->request->get['filter_factory_os'])?1:0;
        $filter_own=isset($this->request->get['filter_own'])?$this->request->get['filter_own']:'';
		
        $urlData['filter_own']=$filter_own;
        $urlData['filter_id_transporter']=$filter_id_transporter;
        $urlData['filter_id_factory']=$filter_id_factory;
        $urlData['filter_id_driver']=$filter_id_driver;
        $urlData['filter_factory_os']=$filter_factory_os;
        $urlData['sort']=isset($this->request->get['sort']) ? $this->request->get['sort'] : '';
        $urlData['order']=isset($this->request->get['order']) ? $this->request->get['order'] : '';
        $urlData['page']=isset($this->request->get['page']) ? $this->request->get['page'] : '';
        $urlDataIgnore=array();
        $buttonUrl=getUrlString($urlData,$urlDataIgnore);
        $data['delete'] = $this->url->link($route . '/delete', 'token=' . $this->session->data['token'] . $buttonUrl, true);

        $data['items'] = array();

        $filter_data = array(
            'filter_own' => $filter_own,
            'filter_id_transporter' => $filter_id_transporter,
            'filter_id_driver' => $filter_id_driver,
            'filter_id_factory' => $filter_id_factory,
            'filter_factory_os' => $filter_factory_os,
            'sort' => $data['sort'],
            'order' => $data['order'],
            'start' => ($data['page'] - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $itemTotal = $this->model_settings_trip->getTotalItems($filter_data);
        //exit(" value of ");
        $results = $this->model_settings_trip->getItems($filter_data);
        //echo '<pre>';print_r($results);exit;
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
	//echo '<pre>';print_r($results->rows);
        //exit("here");
        $this->load->model('settings/tripfuelstation');
        foreach ($results->rows as $k=>$result) {
            $fuel = $this->model_settings_tripfuelstation->getItems(array('filter_id_trip' => $result['id_trip'],'limit' => 100,'start'=>0));
            $data['items'][$k] =$result;
            $data['items'][$k]['id']=$result['id_trip'];
            $data['items'][$k]['fstations']=$fuel->rows;
            $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_trip'] . $buttonUrl, true);
            $data['items'][$k]['sno']=$k+$pageSno;
        }
        
        //echo '<pre>';print_r($data['items']);exit;
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
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/trip');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['datecreated']=$this->globalVal['todayDateTime'];
            $cols['own']=isset($this->request->post['field']['own'])?1:0;
            $cols['traveltype']=isset($this->request->post['field']['traveltype'])?0:1;
            //exit("value of ".$cols['traveltype']);
            $cols['ispodsubmitted']=isset($this->request->post['field']['ispodsubmitted'])?1:0;
            $cols['ispodreceived']=isset($this->request->post['field']['ispodreceived'])?1:0;
            $expTruck=explode("#", $cols['id_truck']);
            $cols['id_truck']=$expTruck[0];
            $cols['truckno']=$expTruck[1];
            if($cols['own']){
                $json_dr=json_decode($_POST['field']['id_driver']);
                $cols['id_driver']=$json_dr->id_driver;
                $cols['drivername']=$json_dr->drivername;
                $cols['drivercode']=$json_dr->drivercode;
            }else{
                $cols['drivername']=$cols['id_driver_text'];
            }
            unset($cols['id_driver_text']);
            
            if($cols['loadprovider']=='FT'){
                $json_fr=json_decode($_POST['field']['id_factory_route_material']);
                unset($cols['id_factory_route_material']);
                $cols['id_factory_rate']=$json_fr->id_factory_rate;
                $cols['id_operating_route']=$json_fr->id_operating_route;
                //$cols['id_material']=$json_fr->id_material;
                $cols['freight']=$cols['billrate']*$cols['qty'];
                $cols['material']=$json_fr->material;                
                /*$this->load->model('settings/material');
                $matQry=$this->model_settings_material->getItem($json_fr->id_material);
                $cols['material']=$matQry['material'];
                $cols['materialcode']=$matQry['materialcode'];*/
                
                $this->load->model('settings/factory');
                $ftQry=$this->model_settings_factory->getItem($json_fr->id_factory);
                $cols['factoryname']=$ftQry['factoryname'];
                $cols['factorycode']=$ftQry['factorycode'];
                
                $this->load->model('settings/operatingroute');
                $orQry=$this->model_settings_operatingroute->getItem($json_fr->id_operating_route);
                $cols['fromplace']=$orQry['fromplace'];
                $cols['toplace']=$orQry['toplace'];
                $cols['operatingroutecode']=$orQry['operatingroutecode'];
                
            }else if($cols['loadprovider']=='TR'){
                unset($cols['id_factory_route_material']);
                $json_or=json_decode($_POST['field']['id_operating_route']);
                $cols['id_operating_route']=$json_or->id_operating_route;
                $cols['operatingroutecode']=$json_or->operatingroutecode;
                $cols['fromplace']=$json_or->fromplace;
                $cols['toplace']=$json_or->toplace;
                /*$matExp=explode("#",$cols['id_material']);
                $cols['material']=$matExp[0];
                $cols['id_material']=$matExp[1];
                $cols['materialcode']=$matExp[2];*/
                
                $transExp=explode("#",$cols['id_transporter']);
                $cols['id_transporter']=$transExp[1];
                $cols['transporter']=$transExp[0];
                $cols['freight']=$cols['truckrate']*$cols['qty'];
                
                
            }
            //echo '<pre>';print_r($cols);exit;
            $id=$this->model_settings_trip->addItem($cols);
            
            $this->load->model('settings/tripfuelstation');
            foreach($this->request->post['fuel'] as $fuel){
                $id_fuel_station=isset($fuel['id_fuel_station'])?(int)$fuel['id_fuel_station']:"";
                $fuelstationname=isset($fuel['fuelstationname'])?$fuel['fuelstationname']:"";
                if(($id_fuel_station!="" || $fuelstationname!="" ) && ($fuel['qty']!="" && $fuel['amount']!="")){
                    $this->model_settings_tripfuelstation->addItem(array("id_trip"=>$id,"id_fuel_station"=>$id_fuel_station,"fuelstationname"=>$fuelstationname,"qty"=>$fuel['qty'],"priceperltr"=>$fuel['priceperltr'],"amount"=>$fuel['amount']));
                }
            }
            
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        //echo '<pre>';print_r($_POST);exit;
        echo json_encode($json);
    }

    public function edit() {
        //echo '<pre>';print_r($_POST);exit;
        /*$json_fr=json_decode($_POST['field']['id_factory_route_material']);
        $json_dr=json_decode($_POST['field']['id_driver']);
        print_r($json_fr);
        print_r($json_dr);
        exit;*/
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
            $id=$this->request->post['pkey'];
            $this->load->model('settings/trip');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['own']=isset($this->request->post['field']['own'])?1:0;
            $cols['traveltype']=isset($this->request->post['field']['traveltype'])?0:1;
            $cols['ispodsubmitted']=isset($this->request->post['field']['ispodsubmitted'])?1:0;
            $cols['ispodreceived']=isset($this->request->post['field']['ispodreceived'])?1:0;
            
            $expTruck=explode("#", $cols['id_truck']);
            $cols['id_truck']=$expTruck[0];
            $cols['truckno']=$expTruck[1];
            
            if($cols['own']){
                $json_dr=json_decode($_POST['field']['id_driver']);
                /*echo '<pre>';
                //print_r($_POST['field']['id_driver']);
                print_r($cols['id_driver']);
                print_r($json_dr);
                echo $json_dr->id_driver." ".$json_dr->drivercode." ".$json_dr->drivername;
                exit;*/
                $cols['id_driver']=$json_dr->id_driver;
                $cols['drivername']=$json_dr->drivername;
                $cols['drivercode']=$json_dr->drivercode;
            }else{
                $cols['drivername']=$cols['id_driver_text'];
            }
            unset($cols['id_driver_text']);
            
            if($cols['loadprovider']=='FT'){
                $json_fr=json_decode($_POST['field']['id_factory_route_material']);
                unset($cols['id_factory_route_material']);
                $cols['id_factory_rate']=$json_fr->id_factory_rate;
                $cols['id_operating_route']=$json_fr->id_operating_route;
                //$cols['id_material']=$json_fr->id_material;
                $cols['material']=$json_fr->material;
                //unset($cols['id_factory_route_material']);
                $cols['freight']=$cols['billrate']*$cols['qty'];
                /*$this->load->model('settings/material');
                $matQry=$this->model_settings_material->getItem($json_fr->id_material);
                $cols['material']=$matQry['material'];
                $cols['materialcode']=$matQry['materialcode'];*/
                
                $this->load->model('settings/factory');
                $ftQry=$this->model_settings_factory->getItem($json_fr->id_factory);
                $cols['factoryname']=$ftQry['factoryname'];
                $cols['factorycode']=$ftQry['factorycode'];
                
                $this->load->model('settings/operatingroute');
                $orQry=$this->model_settings_operatingroute->getItem($json_fr->id_operating_route);
                $cols['fromplace']=$orQry['fromplace'];
                $cols['toplace']=$orQry['toplace'];
                $cols['operatingroutecode']=$orQry['operatingroutecode'];
                
            }else{
                unset($cols['id_factory_route_material']);
                $expTr=explode("#", $cols['id_transporter']);
                $cols['transporter']=$expTr[0];
                $cols['id_transporter']=$expTr[1];
                $cols['freight']=$cols['truckrate']*$cols['qty'];
                /*$expMt=explode("#", $cols['id_material']);
                $cols['material']=$expMt[0];
                $cols['id_material']=$expMt[1];
                $cols['materialcode']=$expMt[2];*/
                $json_or=json_decode($_POST['field']['id_operating_route']);
                $cols['id_operating_route']=$json_or->id_operating_route;
                $cols['fromplace']=$json_or->fromplace;
                $cols['toplace']=$json_or->toplace;
                $cols['operatingroutecode']=$json_or->operatingroutecode;
            }
            //echo '<pre>';print_r($cols);exit("value of "+$id);
            $this->model_settings_trip->editItem($id, $cols);
            
            $this->load->model('settings/tripfuelstation');
            $this->model_settings_tripfuelstation->deleteItemByTripID($id);
            foreach($this->request->post['fuel'] as $fuel){
                $id_fuel_station=isset($fuel['id_fuel_station'])?(int)$fuel['id_fuel_station']:"";
                    $fuelstationname=isset($fuel['fuelstationname'])?$fuel['fuelstationname']:"";
                if(($id_fuel_station!="" || $fuelstationname!="" ) && ($fuel['qty']!="" && $fuel['amount']!="")){
                    $this->model_settings_tripfuelstation->addItem(array("id_trip"=>$id,"id_fuel_station"=>$id_fuel_station,"fuelstationname"=>$fuelstationname,"qty"=>$fuel['qty'],"priceperltr"=>$fuel['priceperltr'],"amount"=>$fuel['amount']));
                }
            }
            
            $json['status'] = 1;
            $json['msg'] = FLASH_EDIT_SUCCESS_MSG;
            //$cols['id']=$this->request->post['pkey'];
            $data = $this->model_settings_trip->getItem($id);
            $fuelQry = $this->model_settings_tripfuelstation->getItems(array('filter_id_trip' => $id,'limit' => 100,'start'=>0));
            $data['fstations'] =$fuelQry->rows;
            $data['id']=$id;
            $json['data']= json_encode($data);
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        //exit;
        //echo '<pre>';print_r($_POST);exit;
        echo json_encode($json);
    }

    public function delete() {
        
        $json['status'] = 0;
        if (isset($this->request->post['selected']) && $this->validateDelete(array('perm' => 'delete'))) {
            $this->load->model('settings/trip');
            $this->load->model('settings/tripfuelstation');
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_trip->deleteItem($id);
                $this->model_settings_tripfuelstation->deleteItemByTripID($id);
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
        
        if (!$this->user->hasPermission($input['perm'], 'trips/trips')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        //exit;
        //exit($input['perm']."value of ".$this->user->hasPermission($input['perm'], 'settings/materials'));
        return !$this->error;
    }

    protected function validateDelete($input) {
        if (!$this->user->hasPermission($input['perm'], 'trips/trips')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        return !$this->error;
    }
}