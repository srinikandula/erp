<?php

class ControllerAdministratorRoles extends Controller {

    private $error = array();
    public $viewPathPrefix='administrator/roles';	
    
    public function index() {

        //$this->document->setTitle('Roles');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        		$this->document->setTitle($data['page']['title']);
        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        /*$this->load->model('settings/trucktype');
        $filter_data = array(
                'sort' => 'trucktype',
                'order' => 'asc'
        );
        $trucktypes=$this->model_settings_adminroletype->getItems($filter_data);
        $data['trucktypes'] =$trucktypes->rows; 
        //echo '<pre>';print_r($data['trucktypes']);exit;
        */
        //echo '<pre>';print_r($this->user->getUserPermissions());exit;
        $permission = $this->user->getPermission();
        foreach($permission as $k=>$v){
                $exp=explode("/",$k);
                $data['siteMap'][$exp[0]][]=$v;
        }
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        
        $this->load->model('settings/adminrole');
        
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

        $itemTotal = $this->model_settings_adminrole->getTotalItems($filter_data);
        //exit(" value of ");
        $results = $this->model_settings_adminrole->getItems($filter_data);
        //echo '<pre>';print_r($results);exit;
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
	//echo '<pre>';print_r($results->rows);
        //exit("here");
        $this->load->model('settings/adminpermission');
        foreach ($results->rows as $k=>$result) {
            $qryPermissions=$this->model_settings_adminpermission->getPermissionsByRole($result['id_admin_role']);
            $data['items'][] = array(
                'id' => $result['id_admin_role'],
                'role' => $result['role'],
                'status' => $result['status'],
                'datecreated' => $result['datecreated'],
                'datemodified' => $result['datemodified'],
                'permissions'=>$qryPermissions->rows,
                'edit' => $this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_admin_role'] . $buttonUrl, true),
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
        $data['sort_role'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=role' . $sortUrl, true);
        $data['sort_status'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=status' . $sortUrl, true);
               
        $data['selected']=isset($this->request->post['selected'])?(array) $this->request->post['selected']:array();	
	
        //echo '<pre>';print_r($data['items']);echo '</pre>';
        $this->response->setOutput($this->load->view($this->viewPathPrefix.'_list', $data));
    }
    
    public function add() {
        
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/adminrole');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['datecreated']=$this->globalVal['todayDateTime'];
            $cols['status']=isset($this->request->post['field']['status'])?1:0;
            $id_admin_role=$this->model_settings_adminrole->addItem($cols);
            
            $this->load->model('settings/adminpermission');
            $qryPermission=$this->model_settings_adminpermission->getItems(array('filter_id_admin_role'=>1,'limit' => 1000,'start'=>0));
            $globalPerm=array();
            foreach($qryPermission->rows as $row){
                $firstCell=  strtolower($row['modulename']).'@'.$row['filename'];
                $globalPerm[$firstCell]['modulename']=$row['modulename'];
                $globalPerm[$firstCell]['filename']=$row['filename'];
                $globalPerm[$firstCell]['title']=$row['title'];
                $globalPerm[$firstCell]['filesortorder']=$row['filesortorder'];
                $globalPerm[$firstCell]['modulesortorder']=$row['modulesortorder'];
            }
            
            foreach($this->request->post['permissions'] as $k=>$row){
                $tableInfo=$row;
                $tableInfo['modulename']=$globalPerm[$k]['modulename'];
                $tableInfo['filename']=$globalPerm[$k]['filename'];
                $tableInfo['title']=$globalPerm[$k]['title'];
                $tableInfo['id_admin_role']=$id_admin_role;
                $tableInfo['status']=1;
                $tableInfo['filesortorder']=$globalPerm[$k]['filesortorder'];
                $tableInfo['modulesortorder']=$globalPerm[$k]['modulesortorder'];
                $this->model_settings_adminpermission->addItem($tableInfo);
            }
            
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function edit() {
        //echo '<pre>';print_r($this->request->post);exit;
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
            $this->load->model('settings/adminrole');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['status']=isset($this->request->post['field']['status'])?1:0;
            $this->model_settings_adminrole->editItem($this->request->post['pkey'], $cols);
            
            $this->load->model('settings/adminpermission');
            $this->model_settings_adminpermission->deletePermissionByRole($this->request->post['pkey']);
            $qryPermission=$this->model_settings_adminpermission->getItems(array('filter_id_admin_role'=>1,'limit' => 1000,'start'=>0));
            $globalPerm=array();
            foreach($qryPermission->rows as $row){
                $firstCell=  strtolower($row['modulename']).'@'.$row['filename'];
                $globalPerm[$firstCell]['modulename']=$row['modulename'];
                $globalPerm[$firstCell]['filename']=$row['filename'];
                $globalPerm[$firstCell]['title']=$row['title'];
                $globalPerm[$firstCell]['filesortorder']=$row['filesortorder'];
                $globalPerm[$firstCell]['modulesortorder']=$row['modulesortorder'];
            }
            
            foreach($this->request->post['permissions'] as $k=>$row){
                $tableInfo=$row;
                $tableInfo['modulename']=$globalPerm[$k]['modulename'];
                $tableInfo['filename']=$globalPerm[$k]['filename'];
                $tableInfo['title']=$globalPerm[$k]['title'];
                $tableInfo['id_admin_role']=$this->request->post['pkey'];
                $tableInfo['status']=1;
                $tableInfo['filesortorder']=$globalPerm[$k]['filesortorder'];
                $tableInfo['modulesortorder']=$globalPerm[$k]['modulesortorder'];
                $this->model_settings_adminpermission->addItem($tableInfo);
            }
            
            $json['status'] = 1;
            $json['msg'] = FLASH_EDIT_SUCCESS_MSG;
            $cols['id']=$this->request->post['pkey'];
            $qryPermissions=$this->model_settings_adminpermission->getPermissionsByRole($this->request->post['pkey']);
            $cols['permissions']=$qryPermissions->rows;
            $json['data']= json_encode($cols);
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function delete() {
        
        $json['status'] = 0;
        if (isset($this->request->post['selected']) && $this->validateDelete(array('perm' => 'delete'))) {
            $this->load->model('settings/adminrole');
            $this->load->model('settings/adminpermission');
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_adminrole->deleteItem($id);
                $this->model_settings_adminpermission->deletePermissionByRole($id);
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
        
        if (!$this->user->hasPermission($input['perm'], 'administrator/roles')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        //exit;
        //exit($input['perm']."value of ".$this->user->hasPermission($input['perm'], 'settings/materials'));
        return !$this->error;
    }

    protected function validateDelete($input) {
        if (!$this->user->hasPermission($input['perm'], 'administrator/roles')) {
            $this->error['warning'] = FLASH_PERMISSION_ERROR_MSG;
        }
        return !$this->error;
    }
}