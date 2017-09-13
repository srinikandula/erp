<?php

class ControllerTrucksTruckspares extends Controller {

    private $error = array();
    public $viewPathPrefix='trucks/truckspares';	
    public function index() {

        //$this->document->setTitle('Truck Spares');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        		$this->document->setTitle($data['page']['title']);
        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        //Fuel Stations
        $this->load->model('settings/truck');
        $filter_data = array(
                'filter_own'=>'1',    
                'sort' => 'truckno',
                'order' => 'asc'
        );
        $trucksQry=$this->model_settings_truck->getItems($filter_data);
        $data['trucks'] =$trucksQry->rows;
        
        
        //Branches
        $this->load->model('settings/branch');
        $filter_data = array(
                'sort' => 'branchcity',
                'order' => 'asc'
        );
        $branchesQry=$this->model_settings_branch->getItems($filter_data);
        $data['branches'] =$branchesQry->rows;
        
        //storeItem
        $this->load->model('settings/storeitem');
        $filter_data = array(
                'sort' => 'itemname',
                'order' => 'asc'
        );
        $storeItemsQry=$this->model_settings_storeitem->getItems($filter_data);
        foreach($storeItemsQry->rows as $row){
            $data['storeItems'][$row['type']][] =$row;
        }
        
        
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        //echo '<pre>';print_r($_GET);exit;
        $this->load->model('settings/truckstoreitem');
        $route = $this->request->get['route'];

        $data['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'datecreated';
        $data['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : 'DESC';
        $data['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : 1;

        $filter_id_truck=isset($this->request->get['filter_id_truck'])?$this->request->get['filter_id_truck']:'';
        $filter_id_branch=isset($this->request->get['filter_id_branch'])?$this->request->get['filter_id_branch']:'';
        $filter_id_store_item=isset($this->request->get['filter_id_store_item'])?$this->request->get['filter_id_store_item']:'';
        $filter_datefrom=isset($this->request->get['filter_datefrom'])?$this->request->get['filter_datefrom']:'';
        $filter_dateto=isset($this->request->get['filter_dateto'])?$this->request->get['filter_dateto']:'';
	//$filter_materialcode=isset($this->request->get['filter_materialcode'])?$this->request->get['filter_materialcode']:'';
		
        $urlData['filter_id_truck']=$filter_id_truck;
        $urlData['filter_id_branch']=$filter_id_branch;
        $urlData['filter_id_store_item']=$filter_id_store_item;
        $urlData['filter_datefrom']=$filter_datefrom;
        $urlData['filter_dateto']=$filter_dateto;

        $urlData['sort']=isset($this->request->get['sort']) ? $this->request->get['sort'] : '';
        $urlData['order']=isset($this->request->get['order']) ? $this->request->get['order'] : '';
        $urlData['page']=isset($this->request->get['page']) ? $this->request->get['page'] : '';
        $urlDataIgnore=array();
        $buttonUrl=getUrlString($urlData,$urlDataIgnore);
        $data['delete'] = $this->url->link($route . '/delete', 'token=' . $this->session->data['token'] . $buttonUrl, true);

        $data['items'] = array();

        $filter_data = array(
            'filter_id_truck' => $filter_id_truck,
            'filter_id_branch' => $filter_id_branch,
            'filter_id_store_item' => $filter_id_store_item,
            'filter_datefrom' => $filter_datefrom,
            'filter_dateto' => $filter_dateto,
            'sort' => $data['sort'],
            'order' => $data['order'],
            'start' => ($data['page'] - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );
        //echo '<pre>';print_r($filter_data);echo '</pre>';
        $itemTotal = $this->model_settings_truckstoreitem->getTotalItems($filter_data);

        $results = $this->model_settings_truckstoreitem->getItems($filter_data);
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
        $storeItems=getStoreItemTypes();
		foreach ($results->rows as $k=>$result) {
            $data['items'][$k] =$result;
            $data['items'][$k]['id']=$result['id_truck_store_item'];
			$data['items'][$k]['type']=$storeItems[$result['type']];
            $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_truck_store_item'] . $buttonUrl, true);
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
        //$data['sort_material'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=material' . $sortUrl, true);
        //$data['sort_materialcode'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=materialcode' . $sortUrl, true);
	
        $data['selected']=isset($this->request->post['selected'])?(array) $this->request->post['selected']:array();	
	
        $this->response->setOutput($this->load->view($this->viewPathPrefix.'_list', $data));
    }
    
    public function add() {
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/truckstoreitem');
            $field=$this->request->post['field'];
            $field['datecreated']=$this->globalVal['todayDateTime'];
            //echo '<pre>';print_r($field);exit;
            $id=$this->model_settings_truckstoreitem->addItem($field);
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function delete() {
        
        $json['status'] = 0;
        if (isset($this->request->post['selected']) && $this->validateDelete(array('perm' => 'delete'))) {
            $this->load->model('settings/truckstoreitem');
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_truckstoreitem->deleteItem($id);
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
        
        if (!$this->user->hasPermission($input['perm'], 'trucks/truckspares')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        //exit;
        //exit($input['perm']."value of ".$this->user->hasPermission($input['perm'], 'settings/materials'));
        return !$this->error;
    }

    protected function validateDelete($input) {
        if (!$this->user->hasPermission($input['perm'], 'trucks/truckspares')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        return !$this->error;
    }
}