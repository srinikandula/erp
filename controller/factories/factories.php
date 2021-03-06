<?php

class ControllerFactoriesFactories extends Controller {

    private $error = array();
    public $viewPathPrefix='factories/factories';	
    
    public function index() {

        //$this->document->setTitle('Factories');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        $this->document->setTitle($data['page']['title']);

        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        
        
        //echo '<pre>';print_r($data['materials']);print_r($data['oRoutes']);exit;
        
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        
        $this->load->model('settings/factory');
        
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

        $itemTotal = $this->model_settings_factory->getTotalItems($filter_data);
        //exit(" value of ");
        $results = $this->model_settings_factory->getItems($filter_data);
        //echo '<pre>';print_r($results);exit;
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
	//echo '<pre>';print_r($results->rows);
        //exit("here");
        $this->load->model('settings/factoryrate');
        $this->load->model('settings/factoryparty');
        foreach ($results->rows as $k=>$result) {
            $factoryRates = $this->model_settings_factoryrate->getItems(array('filter_id_factory' => $result['id_factory'],'limit' => 100,'start'=>0));
            $factoryparties = $this->model_settings_factoryparty->getItems(array('filter_id_factory' => $result['id_factory'],'limit' => 100,'start'=>0));
            $data['items'][] = array(
                'id' => $result['id_factory'],
                'factorycode' => $result['factorycode'],
                'factoryname' => $result['factoryname'],
                'factorycontactname' => $result['factorycontactname'],
                'factorycontactmobile' => $result['factorycontactmobile'],
                'factoryemail' => $result['factoryemail'],
                'billingpersonname' => $result['billingpersonname'],
                'billingpersonmobile' => $result['billingpersonmobile'],
                'paymentcycle' => $result['paymentcycle'],
                'paymentmode' => $result['paymentmode'],
                'city' => $result['city'],
                'address' => $result['address'],
                'status' => $result['status'],
                'datecreated' => $result['datecreated'],
                'datemodified' => $result['datemodified'],
                'factoryRates'=>$factoryRates->rows,
                'factoryParties'=>$factoryparties->rows,
                'edit' => $this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_factory'] . $buttonUrl, true),
		'sno'=>$k+$pageSno,
            );
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
        
        $data['sort_factorycode'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=factorycode' . $sortUrl, true);
        $data['sort_factoryname'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=factoryname' . $sortUrl, true);
        $data['sort_factorycontactname'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=factorycontactname' . $sortUrl, true);
        $data['sort_factorycontactmobile'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=factorycontactmobile' . $sortUrl, true);
        $data['sort_factoryemail'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=factoryemail' . $sortUrl, true);
        $data['sort_billingpersonname'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=billingpersonname' . $sortUrl, true);
        $data['sort_billingpersonmobile'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=billingpersonmobile' . $sortUrl, true);
        $data['sort_paymentcycle'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=paymentcycle' . $sortUrl, true);
        $data['sort_paymentmode'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=paymentmode' . $sortUrl, true);
        $data['sort_city'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=city' . $sortUrl, true);
        $data['sort_status'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=status' . $sortUrl, true);
                
        $data['selected']=isset($this->request->post['selected'])?(array) $this->request->post['selected']:array();	
	
        $this->load->model('settings/material');
        $filter_data = array(
            'sort' => 'material',
            'order' => 'asc'
        );
        //$materialsQry=$this->model_settings_material->getItems($filter_data);
        //$data['materials'] =$materialsQry->rows;
        
        $this->load->model('settings/operatingroute');
        $filter_data = array(
            'sort' => 'fromplace',
            'order' => 'asc'
        );
        $ORQry=$this->model_settings_operatingroute->getItems($filter_data);
        $data['oRoutes'] =$ORQry->rows;
        
        /*
        //parties
        $this->load->model('settings/factoryparty');
        $filter_data = array(
            'sort' => 'partyname',
            'order' => 'asc'
        );
        $partyQry=$this->model_settings_factoryparty->getItems($filter_data);
        $data['parties'] =$partyQry->rows;*/
        
        $this->response->setOutput($this->load->view($this->viewPathPrefix.'_list', $data));
    }
    
    public function add() {
        
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/factory');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['datecreated']=$this->globalVal['todayDateTime'];
            $cols['status']=isset($this->request->post['field']['status'])?1:0;
            $id=$this->model_settings_factory->addItem($cols);
            
            $this->load->model('settings/factoryrate');
            foreach($this->request->post['row'] as $row){
                //echo '<pre>';print_r($row);echo '</pre>';
                $row['id_factory']=$id;
                $row['datecreated']=$this->globalVal['todayDateTime'];
                $row['datemodified']=$this->globalVal['todayDateTime'];
                $this->model_settings_factoryrate->addItem($row);
            }
            
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }
    
    public function addparty() {
        //echo '<pre>';print_r($_POST);exit;
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
            $this->load->model('settings/factoryparty');
            $id=$this->request->post['field']['id_factory_factory_party'];

            foreach($this->request->post['row'] as $row){
                $row['id_factory']=$id;

                if($row['id_factory_party']!=""){
                    $this->model_settings_factoryparty->editItem($row['id_factory_party'],$row);
                }else{
                    unset($row['id_factory_party']);
                    $this->model_settings_factoryparty->addItem($row);
                }
            }
            
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = FLASH_ERROR_MSG;
        }
        echo json_encode($json);
    }

    public function edit() {

        $json['status'] = 0;
        //echo '<pre>';print_r($_POST);echo '</pre>';
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
            $this->load->model('settings/factory');
            $cols=$this->request->post['field'];
            $cols['status']=isset($this->request->post['field']['status'])?1:0;
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $this->model_settings_factory->editItem($this->request->post['pkey'], $cols);
            
            $this->load->model('settings/factoryrate');
            $this->model_settings_factoryrate->deleteByFactoryId($this->request->post['pkey']);
            foreach($this->request->post['row'] as $row){
                //echo '<pre>';print_r($row);echo '</pre>';
                $row['id_factory']=$this->request->post['pkey'];
                $row['datecreated']=$this->globalVal['todayDateTime'];
                $row['datemodified']=$this->globalVal['todayDateTime'];
                $this->model_settings_factoryrate->addItem($row);
            }
            
            $factoryRates = $this->model_settings_factoryrate->getItems(array('filter_id_factory' => $this->request->post['pkey'],'limit' => 100,'start'=>0));
            $cols['factoryRates']=$factoryRates->rows;
            
            $this->load->model('settings/factoryparty');
            $factoryParties = $this->model_settings_factoryparty->getItems(array('filter_id_factory' => $this->request->post['pkey'],'limit' => 100,'start'=>0));
            
            $cols['factoryParties']=$factoryParties->rows;
            $json['status'] = 1;
            $json['msg'] = FLASH_EDIT_SUCCESS_MSG;
            $cols['id']=$this->request->post['pkey'];
            $json['data']= json_encode($cols);
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function delete() {
        
        $json['status'] = 0;
        if (isset($this->request->post['selected']) && $this->validateDelete(array('perm' => 'delete'))) {
            $this->load->model('settings/factory');
            $this->load->model('settings/factoryrate');
            
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_factory->deleteItem($id);
                $this->model_settings_factoryrate->deleteByFactoryId($id);
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
        
        if (!$this->user->hasPermission($input['perm'], 'factories/factories')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        //exit;
        //exit($input['perm']."value of ".$this->user->hasPermission($input['perm'], 'settings/materials'));
        return !$this->error;
    }

    protected function validateDelete($input) {
        if (!$this->user->hasPermission($input['perm'], 'factories/factories')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        return !$this->error;
    }
}