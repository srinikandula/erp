<?php

class ControllerAdministratorAdmin extends Controller {

    private $error = array();
	public $viewPathPrefix='administrator/admin';	
    public function index() {

        //$this->document->setTitle('Admin');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
		$this->document->setTitle($data['page']['title']);
        
        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	//branches
        $this->load->model('settings/branch');
        $filter_data = array(
                'sort' => 'branchcity',
                'order' => 'asc'
        );
        $branchesQry=$this->model_settings_branch->getItems($filter_data);
        foreach($branchesQry->rows as $row){
            $data['branches'][$row['id_branch']]=$row;
        }
        
        //roles
        $this->load->model('settings/adminrole');
        $filter_data = array(
                'sort' => 'role',
                'order' => 'asc'
        );
        $rolesQry=$this->model_settings_adminrole->getItems($filter_data);
        foreach($rolesQry->rows as $row){
            $data['roles'][$row['id_admin_role']]=$row;
        }
        
        
        $data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        
        $this->load->model('settings/admin');
        
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

        $itemTotal = $this->model_settings_admin->getTotalItems($filter_data);
        //exit(" value of ");
        $results = $this->model_settings_admin->getItems($filter_data);
        //echo '<pre>';print_r($results);exit;
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
	//echo '<pre>';print_r($results->rows);
        //exit("here");
        /*foreach ($results->rows as $k=>$result) {
            $data['items'][] = array(
                'id' => $result['id_admin'],
				'adminname' => $result['adminname'],
				'adminemail' => $result['adminemail'],
				'adminmobile' => $result['adminmobile'],
				'username' => $result['username'],
				'id_branch' => $result['id_branch'],
				'id_admin_role' => $result['id_admin_role'],
				'ip' => $result['id_admin'],
				'status' => $result['id_admin'],
                'datecreated' => $result['datecreated'],
                'datemodified' => $result['datemodified'],
                'edit' => $this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_admin'] . $buttonUrl, true),
				'sno'=>$k+$pageSno,
            );
        }*/
        
        foreach ($results->rows as $k=>$result) {
            $data['items'][$k] =$result;
            $data['items'][$k]['id']=$result['id_admin'];
            $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_admin'] . $buttonUrl, true);
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
        $data['sort_adminname'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=adminname' . $sortUrl, true);
        $data['sort_adminemail'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=adminemail' . $sortUrl, true);
        $data['sort_adminmobile'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=adminmobile' . $sortUrl, true);
        $data['sort_username'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=username' . $sortUrl, true);
        $data['sort_status'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=status' . $sortUrl, true);
                
        $data['selected']=isset($this->request->post['selected'])?(array) $this->request->post['selected']:array();	
	
        $this->response->setOutput($this->load->view($this->viewPathPrefix.'_list', $data));
    }
    
    public function add() {
        
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/admin');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['datecreated']=$this->globalVal['todayDateTime'];
            $cols['password']=md5($cols['password']);
            unset($cols['confirmpassword']);
            $this->model_settings_admin->addItem($cols);
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
            $this->load->model('settings/admin');
            $cols=$this->request->post['field'];
            if($cols['password']==""){
                unset($cols['password']);
            }else{
                $cols['password']=md5($cols['password']);
            }
            unset($cols['confirmpassword']);
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $this->model_settings_admin->editItem($this->request->post['pkey'], $cols);
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
            $this->load->model('settings/admin');
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_admin->deleteItem($id);
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
        
        if (!$this->user->hasPermission($input['perm'], 'administrator/admin')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        
        $this->load->model('settings/admin');
        $return=$this->model_settings_admin->isUnique($input['perm'],$this->request->post['field'],$this->request->post['pkey']);
        if (!$return['email']) {
            $this->error['email'] = "Email must be unique";
        }
        
        if (!$return['username']) {
            $this->error['username'] = "Username must be unique";
        }
        
        //exit;
        //exit($input['perm']."value of ".$this->user->hasPermission($input['perm'], 'settings/materials'));
        return !$this->error;
    }

    protected function validateDelete($input) {
        if (!$this->user->hasPermission($input['perm'], 'administrator/admin')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        return !$this->error;
    }
}