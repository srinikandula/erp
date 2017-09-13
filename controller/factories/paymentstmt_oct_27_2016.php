<?php

class ControllerFactoriesPaymentstmt extends Controller {

    private $error = array();
    public $viewPathPrefix='factories/paymentstmt';	
    
    public function index() {
        //echo date('Y-m-d', strtotime(date('Y-m-d') . ' -5 day')); 
        //exit(date($this->globalVal['todayDateTime']));   
        //$this->document->setTitle('Factory Payment');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        $this->document->setTitle($data['page']['title']);

        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        $this->load->model('settings/factory');
        $filter_data = array(
                'sort' => 'factoryname',
                'order' => 'asc'
        );
        
        
        $factories=$this->model_settings_factory->getItems($filter_data);
        //$data['factories'] =$factories->rows;
        foreach($factories->rows as $row){
            $data['factories'][$row['id_factory']]=$row;
        }
        
        
        $this->load->model('settings/branch');
        $filter_data = array(
                'sort' => 'branchcity',
                'order' => 'asc'
        );
        $branches=$this->model_settings_branch->getItems($filter_data);
        foreach($branches->rows as $row){
            $data['branches'][$row['id_branch']]=$row;
        }
        
        /*echo '<pre>';print_r($data['factories']);print_r($factories->rows);exit;*/
        //echo '<pre>';print_r($data['trucktypes']);exit;
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        //echo '<pre>';print_r($_GET);exit;
        $this->load->model('settings/factorypayment');
        $route = $this->request->get['route'];
        
        $data['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'datecreated';
        $data['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : 'DESC';
        $data['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : 1;

        $filter_id_factory=isset($this->request->get['filter_id_factory'])?$this->request->get['filter_id_factory']:'';
	$filter_bills_raised=isset($this->request->get['filter_bills_raised'])?1:0;
        $filter_over_due=isset($this->request->get['filter_over_due'])?1:0;
        $filter_closed=isset($this->request->get['filter_closed'])?1:0;
		
        $urlData['filter_id_factory']=$filter_id_factory;
        $urlData['filter_bills_raised']=$filter_bills_raised;
        $urlData['filter_over_due']=$filter_over_due;
        $urlData['filter_closed']=$filter_closed;
        $urlData['sort']=isset($this->request->get['sort']) ? $this->request->get['sort'] : '';
        $urlData['order']=isset($this->request->get['order']) ? $this->request->get['order'] : '';
        $urlData['page']=isset($this->request->get['page']) ? $this->request->get['page'] : '';
        $urlDataIgnore=array();
        $buttonUrl=getUrlString($urlData,$urlDataIgnore);
        $data['delete'] = $this->url->link($route . '/delete', 'token=' . $this->session->data['token'] . $buttonUrl, true);

        $data['items'] = array();

        $filter_data = array(
            'filter_id_factory'=>$filter_id_factory,
            'filter_bills_raised'=>$filter_bills_raised,
            'filter_over_due'=>$filter_over_due,
            'filter_closed'=>$filter_closed,
            'sort' => $data['sort'],
            'order' => $data['order'],
            'start' => ($data['page'] - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );

        $itemTotal = $this->model_settings_factorypayment->getTotalItems($filter_data);
        $results = $this->model_settings_factorypayment->getItems($filter_data);
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
        $this->load->model('settings/trip');
        $this->load->model('settings/factorypaymenthistory');
	foreach ($results->rows as $k=>$result) {
            $trip=$this->model_settings_trip->getTripsByFactoryPaymentID(array("id_factory_payment"=>$result['id_factory_payment']));
            $payments=$this->model_settings_factorypaymenthistory->getItems(array("filter_id_factory_payment"=>$result['id_factory_payment']));
            $data['items'][$k]=$result;
            $data['items'][$k]['id']=$result['id_factory_payment'];
            $data['items'][$k]['trips']=$trip->rows;
            $data['items'][$k]['payments']=$payments->rows;
            $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_factory_payment'] . $buttonUrl, true);
            $data['items'][$k]['sno']=$k+$pageSno;
        }
       // echo '<pre>';print_r($data['items']);echo '</pre>';
        
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
		//echo '<pre>';print_r($data['items']);exit;
        $this->response->setOutput($this->load->view($this->viewPathPrefix.'_list', $data));
    }
    
    public function add() {
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        //if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $this->load->model('settings/factorypayment');
            $cols=$this->request->post['field'];
            $cols['datecreated']=$this->globalVal['todayDateTime'];
	    $cols['datemodified']=$this->globalVal['todayDateTime'];
            //$json_fr=json_decode($_POST['field']['id_factory']);
            /*$cols['id_factory']=$json_fr->id_factory;
            $cols['paymentcycle']=$json_fr->paymentcycle;
            $cols['duedate']=date('Y-m-d', strtotime($cols['billgendate']. ' + '.$json_fr->paymentcycle.' days'));*/
            //$cols['paymentcycle']=$json_fr->paymentcycle;
            $cols['duedate']=date('Y-m-d', strtotime($cols['billgendate']. ' + '.$cols['paymentcycle'].' days'));
            //$cols['closed']=isset($this->request->post['field']['closed'])?1:0;
            $id=$this->model_settings_factorypayment->addItem($cols);
            
            $this->load->model('settings/trip');
            $this->model_settings_trip->updateTripFactoryPayment($id,$_POST['trip']);
            
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
            $json['data']= json_encode($cols);
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        //echo '<pre>';print_r($_POST);
        //exit;
        echo json_encode($json);
    }

    public function edit() {
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        //if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $id=$this->request->post['pkey'];
            $this->load->model('settings/factorypayment');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            /*$json_fr=json_decode($_POST['field']['id_factory']);
            $cols['id_factory']=$json_fr->id_factory;
            $cols['paymentcycle']=$json_fr->paymentcycle;*/
            $cols['duedate']=date('Y-m-d', strtotime($cols['billgendate']. ' + '.$cols['paymentcycle'].' days'));
            //$cols['closed']=isset($this->request->post['field']['closed'])?1:0;
            $this->model_settings_factorypayment->editItem($id, $cols);
            
            $this->load->model('settings/trip');
            $this->model_settings_trip->updateTripFactoryPayment($id,$_POST['trip']);
            
            $json['status'] = 1;
            $json['msg'] = FLASH_EDIT_SUCCESS_MSG;
            $cols['id']=$id;
            $this->load->model('settings/trip');
            $trip=$this->model_settings_trip->getTripsByFactoryPaymentID(array("id_factory_payment"=>$id));
            $cols['trips']=$trip->rows;
            $json['data']= json_encode($cols);
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        //  echo '<pre>';print_r($_POST);exit;
        echo json_encode($json);
    }
    
    public function getTrips() {
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        //if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $this->load->model('settings/trip');
            $input['datefrom']=$this->request->post['datefrom'];
            $input['dateto']=$this->request->post['dateto'];
            //$js_id_factory=json_decode($_POST['id_factory']);
            $input['id_factory']=$this->request->post['id_factory'];
            
            $tripsObj=$this->model_settings_trip->getTripsByFactoryID($input);
            //echo '<pre>';print_r($tripsObj);
            $totalShortage=0;
            $totalDamage=0;
            $totalFreight=0;
            $totalToll=0;
            $totalLoading=0;
            $totalUnloading=0;
            foreach($tripsObj->rows as $k=>$row){
                $json['data']['trips'][$k]=$row;
                $totalShortage+=$row['shortage'];
                $totalDamage+=$row['damage'];
                $totalFreight+= $row['billrate']*$row['qty']; //$row['freight'];//though frieght for factory is factory*qty we just took from individual fields
                $totalToll+=$row['tollcharge'];
                $totalLoading+=$row['loadingcharge'];
                $totalUnloading+=$row['unloadingcharge'];
            }
            $json['data']['totalTrips']=$tripsObj->num_rows;
            $json['data']['totalShortage']=$totalShortage;
            $json['data']['totalDamage']=$totalDamage;
            $json['data']['totalFreight']=$totalFreight;
            $json['data']['totalToll']=$totalToll;
            $json['data']['totalLoading']=$totalLoading;
            $json['data']['totalUnloading']=$totalUnloading;

            //echo '<pre>';print_r($input); print_r($json['data']);
            $json['status'] = 1;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function delete() {
        
        $json['status'] = 0;
        if (isset($this->request->post['selected']) && $this->validateDelete(array('perm' => 'delete'))) {
            $this->load->model('settings/factorypayment');
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_factorypayment->deleteItem($id);
            }
            $json['status'] = 1;
            $json['msg'] = FLASH_DELETE_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }
    
    public function addhistory() {
	//echo '<pre>';print_r($_POST);exit;
	$json['status'] = 0;
	if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
		$this->load->model('settings/factorypaymenthistory');
		$cols=$this->request->post['field'];
		$cols['datecreated']=$this->globalVal['todayDateTime'];
		$id=$this->model_settings_factorypaymenthistory->addItem($cols);
		$this->load->model('settings/factorypayment');
		$this->model_settings_factorypayment->updateFactoryPaymentPayment($cols['id_factory_payment'],$cols['amount']);
		$cols['id_factory_payment_history']=$id;
		$json['status'] = 1;
		$json['msg'] = FLASH_ADD_SUCCESS_MSG;
		$json['data']= json_encode($cols);
	} else {
		$json['msg'] = implode(" , ", $this->error);
	}
	echo json_encode($json);
    }
    
    public function deletehistory() {
        
        $json['status'] = 0;
        $id=(int)$this->request->post['id'];
        $idh=(int)$this->request->post['idh'];
        $paidamount=$this->request->post['paidamount'];
        if ($id) {
            $this->load->model('settings/factorypaymenthistory');
            //$this->model_settings_factorypaymenthistory->deleteItem($idh);
            
            $this->load->model('settings/factorypayment');
            //$this->model_settings_factorypayment->editItem($id,array('paidamount'=>$paidamount));
            
            $json['status'] = 1;
            $json['msg'] = FLASH_DELETE_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    protected function validateForm($input) {
        //echo '<pre>';print_r($this->user->getPermission());
        
        if (!$this->user->hasPermission($input['perm'], 'factories/paymentstmt')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        //exit;
        //exit($input['perm']."value of ".$this->user->hasPermission($input['perm'], 'settings/materials'));
        return !$this->error;
    }

    protected function validateDelete($input) {
        if (!$this->user->hasPermission($input['perm'], 'factories/paymentstmt')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        return !$this->error;
    }
}