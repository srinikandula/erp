<?php

class ControllerPaymentsStores extends Controller {

    private $error = array();
    public $viewPathPrefix='payments/stores';	
    
    public function index() {

        //$this->document->setTitle('Stores');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        $this->document->setTitle($data['page']['title']);

        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        //Store Vendors
        $this->load->model('settings/storevendor');
        $filter_data = array(
            'sort' => 'vendorname',
            'order' => 'asc'
        );
        $storevendorsQry=$this->model_settings_storevendor->getItems($filter_data);
        foreach($storevendorsQry->rows as $row){
            $data['storevendors'][$row['id_store_vendor']]=$row;
        }
        
        //Store Items
        $this->load->model('settings/storeitem');
        $filter_data = array(
            'sort' => 'itemname',
            'order' => 'asc'
        );
        $storeitemsQry=$this->model_settings_storeitem->getItems($filter_data);
        foreach($storeitemsQry->rows as $row){
            $data['storeitems'][$row['type']][]=$row;
        }
        
        //Branches
        $this->load->model('settings/branch');
        $filter_data = array(
            'sort' => 'branchcode',
            'order' => 'asc'
        );
        $branchsQry=$this->model_settings_branch->getItems($filter_data);
        foreach($branchsQry->rows as $row){
            $data['branchs'][$row['id_branch']]=$row;
        }
        
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        
        $this->load->model('settings/storevendorpayment');
        
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

        $itemTotal = $this->model_settings_storevendorpayment->getTotalItems($filter_data);
        //exit(" value of ");
        $results = $this->model_settings_storevendorpayment->getItems($filter_data);
        //echo '<pre>';print_r($results);exit;
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
	//echo '<pre>';print_r($results->rows);
        //exit("here");
        $this->load->model('settings/storevendoritem');
		$pMode=getPaymentMode();
        foreach ($results->rows as $k=>$result) {
            $items = $this->model_settings_storevendoritem->getItems(array('filter_id_store_vendor_payment' => $result['id_store_vendor_payment'],'limit' => 1000,'start'=>0));
            $data['items'][$k]=$result;
            $data['items'][$k]['items']=$items->rows;
			$data['items'][$k]['paymentmode_desc']=$pMode[$result['paymentmode']];
            $data['items'][$k]['id']=$result['id_store_vendor_payment'];
            $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_store_vendor_payment'] . $buttonUrl, true);
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
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/storevendorpayment');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['datecreated']=$this->globalVal['todayDateTime'];
            $id=$this->model_settings_storevendorpayment->addItem($cols);
            $this->load->model('settings/storevendoritem');
            foreach($_POST['row'] as $row){
                $this->model_settings_storevendoritem->addItem(array("refno"=>$row['refno'],"id_store_item"=>$row['id_store_item'],"qty"=>$row['qty'],"price"=>$row['price'],"id_store_vendor_payment"=>$id));
            }
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function edit() {
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
            $id=$this->request->post['pkey'];
            $this->load->model('settings/storevendorpayment');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $this->model_settings_storevendorpayment->editItem($id, $cols);
            $this->load->model('settings/storevendoritem');
            $this->model_settings_storevendoritem->deleteItemByStoreVendorPaymentID($id);
            foreach($_POST['row'] as $k=>$row){
                $items[$k]=$row;
                $items[$k]['id_store_vendor_payment']=$id;
                $this->model_settings_storevendoritem->addItem(array("refno"=>$row['refno'],"id_store_item"=>$row['id_store_item'],"qty"=>$row['qty'],"price"=>$row['price'],"id_store_vendor_payment"=>$id));
            }
            $json['status'] = 1;
            $json['msg'] = FLASH_EDIT_SUCCESS_MSG;
            $cols['id']=$id;
            $cols['items']=$items;
			$pMode=getPaymentMode();
			$cols['paymentmode_desc']=$pMode[$cols['paymentmode']];
            $json['data']= json_encode($cols);
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function delete() {
        
        $json['status'] = 0;
        if (isset($this->request->post['selected']) && $this->validateDelete(array('perm' => 'delete'))) {
            $this->load->model('settings/storevendorpayment');
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_storevendorpayment->deleteItem($id);
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
        
        if (!$this->user->hasPermission($input['perm'], 'payments/stores')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        //exit;
        //exit($input['perm']."value of ".$this->user->hasPermission($input['perm'], 'settings/materials'));
        return !$this->error;
    }

    protected function validateDelete($input) {
        if (!$this->user->hasPermission($input['perm'], 'payments/stores')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        return !$this->error;
    }
}