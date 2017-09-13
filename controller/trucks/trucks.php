<?php

class ControllerTrucksTrucks extends Controller {

    private $error = array();
    public $viewPathPrefix='trucks/trucks';	
    
    public function index() {

        //$this->document->setTitle('Trucks');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        		$this->document->setTitle($data['page']['title']);

        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	$data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        
        $this->load->model('settings/trucktype');
        $filter_data = array(
                'sort' => 'trucktype',
                'order' => 'asc'
        );
        $trucktypes=$this->model_settings_trucktype->getItems($filter_data);
        $data['trucktypes'] =$trucktypes->rows; 
        //echo '<pre>';print_r($data['trucktypes']);exit;
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        
        $this->load->model('settings/truck');
        
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

        $itemTotal = $this->model_settings_truck->getTotalItems($filter_data);
        //exit(" value of ");
        $results = $this->model_settings_truck->getItems($filter_data);
        //echo '<pre>';print_r($results);exit;
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
	//echo '<pre>';print_r($results->rows);
        //exit("here");
        foreach ($results->rows as $k=>$result) {
            $data['items'][$k]=$result;
            $data['items'][$k]['id']=$result['id_truck'];
            $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_truck'] . $buttonUrl, true);
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
        $data['sort_truckno'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=truckno' . $sortUrl, true);
        $data['sort_own'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=own' . $sortUrl, true);
            $data['sort_make'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=make' . $sortUrl, true);
        $data['sort_makeyear'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=makeyear' . $sortUrl, true);
        $data['sort_model'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=model' . $sortUrl, true);
        $data['sort_dateinservice'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=dateinservice' . $sortUrl, true);
        $data['sort_fitnessexpdate'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=fitnessexpdate' . $sortUrl, true);
        $data['sort_hubservicedate'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=hubservicedate' . $sortUrl, true);
        $data['sort_insuranceexpdate'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=insuranceexpdate' . $sortUrl, true);
        $data['sort_nationalpermitexpdate'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=nationalpermitexpdate' . $sortUrl, true);
        $data['sort_pollutionexpdate'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=pollutionexpdate' . $sortUrl, true);
        $data['sort_taxpayabledate'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=taxpayabledate' . $sortUrl, true);
                
        $data['selected']=isset($this->request->post['selected'])?(array) $this->request->post['selected']:array();	
	
        $this->response->setOutput($this->load->view($this->viewPathPrefix.'_list', $data));
    }
    
    public function add() {
        
        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/truck');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['datecreated']=$this->globalVal['todayDateTime'];
            $cols['own']=isset($this->request->post['field']['own']);
            $id=$this->model_settings_truck->addItem($cols);
            
            if(!$cols['own'])
            {
                $account=isset($_SESSION['account'])?$_SESSION['account']:"";
                $data = $_FILES['field_pancard_file'];
                $data['input']['prefix'] = $account.'_pancard_file_' . $id;
                $data['input']['path'] = getPathTruckDocs();//DIR_APPLICATION."uploads/truckdocs/";
                $data['input']['prev_file'] = $_POST['prev_pancard_file'];
                $upload = fileUpload($data);
                $up['pancard_file']=$upload['file'];
                //print_r($upload);
                
                $data = $_FILES['field_rc_file'];
                $data['input']['prefix'] = $account.'_rc_file_' . $id;
                $data['input']['path'] = getPathTruckDocs();//DIR_APPLICATION."uploads/truckdocs/";
                $data['input']['prev_file'] = $_POST['prev_rc_file'];
                $upload = fileUpload($data);
                $up['rc_file']=$upload['file'];
                //print_r($upload);
            $this->model_settings_truck->editItem($id, $up);
			}
            //print_r($_FILES);print_r($cols);echo "value of ".$this->request->post['pkey'];exit;
            
            
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function edit() {

        $json['status'] = 0;
        //echo "<pre>";
        //echo '<pre>';print_r($_FILES);print_r($_POST);exit;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
            $this->load->model('settings/truck');
            $cols=$this->request->post['field'];
            $cols['datemodified']=$this->globalVal['todayDateTime'];
            $cols['own']=isset($this->request->post['field']['own']);
            if(!$cols['own'])
            {
                $account=isset($_SESSION['account'])?$_SESSION['account']:"";
                $data = $_FILES['field_pancard_file'];
                $data['input']['prefix'] = $account.'_pancard_file_' . $this->request->post['pkey'];
                $data['input']['path'] = getPathTruckDocs();//DIR_APPLICATION."uploads/truckdocs/";
                $data['input']['prev_file'] = $_POST['prev_pancard_file'];
                $upload = fileUpload($data);
                $cols['pancard_file']=$upload['file'];
                //print_r($upload);
                
                $data = $_FILES['field_rc_file'];
                $data['input']['prefix'] = $account.'_rc_file_' . $this->request->post['pkey'];
                $data['input']['path'] = getPathTruckDocs();//DIR_APPLICATION."uploads/truckdocs/";
                $data['input']['prev_file'] = $_POST['prev_rc_file'];
                $upload = fileUpload($data);
                $cols['rc_file']=$upload['file'];
                //print_r($upload);
            }
            //print_r($_FILES);print_r($cols);echo "value of ".$this->request->post['pkey'];exit;
            $this->model_settings_truck->editItem($this->request->post['pkey'], $cols);
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
            $this->load->model('settings/truck');
            foreach ($this->request->post['selected'] as $id) {
                $row=$this->model_settings_truck->getItem($id);
                @unlink(getPathTruckDocs().$row['rc_file']);
                @unlink(getPathTruckDocs().$row['pancard_file']);
                $this->model_settings_truck->deleteItem($id);
                //echo getPathTruckDocs().$row['rc_file']." ".getPathTruckDocs().$row['pancard_file'];exit;
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