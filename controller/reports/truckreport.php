<?php

class ControllerReportsTruckreport extends Controller {

    private $error = array();
    public $viewPathPrefix='reports/truckreport';	
    public function index() {

        //$this->document->setTitle('Truck Spares');
        $data['info'] = $this->user->getPageAccessInfo('reports/truckreport');
        //echo '<pre>';print_r($data);echo '</pre>';//exit;
        $this->document->setTitle($data['info']['page']['title']);
        $data['route'] = $this->request->get['route'];
       
	$data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'] , true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'] , true);
		
	//Fuel Stations
        $this->load->model('settings/truck');
        $filter_data = array(
            //    'filter_own'=>'1',    
                'sort' => 'truckno',
                'order' => 'asc'
        );
        $trucksQry=$this->model_settings_truck->getItems($filter_data);
        //$data['trucks'] =$trucksQry->rows;
        foreach($trucksQry->rows as $row){
            $data['trucks'][$row['id_truck']]=$row;
        }
        
        //start
        $this->load->model('settings/trip');
        $route = $this->request->get['route'];

        $data['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'datecreated';
        $data['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : 'DESC';
        $data['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : 1;

        $filter_id_truck=isset($this->request->get['filter_id_truck'])?$this->request->get['filter_id_truck']:'';
        //echo '<pre>';print_r($filter_id_truck);exit;
        $filter_truckdata=isset($this->request->get['filter_truckdata'])?$this->request->get['filter_truckdata']:'';
        $filter_fromdate=isset($this->request->get['filter_fromdate'])?$this->request->get['filter_fromdate']:'';
        $filter_todate=isset($this->request->get['filter_todate'])?$this->request->get['filter_todate']:'';
	//$filter_materialcode=isset($this->request->get['filter_materialcode'])?$this->request->get['filter_materialcode']:'';
	$data['truckdata']=$filter_truckdata;
        if(is_array($filter_id_truck)){
            foreach($filter_id_truck as $k=>$v){
                $urlData['filter_id_truck['.$k.']']=$v;
            }
        }
        $urlData['filter_truckdata']=$filter_truckdata;
        $urlData['filter_fromdate']=$filter_fromdate;
        $urlData['filter_todate']=$filter_todate;

        $urlData['sort']=isset($this->request->get['sort']) ? $this->request->get['sort'] : '';
        $urlData['order']=isset($this->request->get['order']) ? $this->request->get['order'] : '';
        $urlData['page']=isset($this->request->get['page']) ? $this->request->get['page'] : '';
        $urlDataIgnore=array();
        $buttonUrl=getUrlString($urlData,$urlDataIgnore);
        $data['delete'] = $this->url->link($route . '/delete', 'token=' . $this->session->data['token'] . $buttonUrl, true);

        $data['items'] = array();

        $filter_data = array(
            'filter_multiple_id_truck' => $filter_id_truck,
            'filter_truckdata' => $filter_truckdata,
            'filter_fromdate' => $filter_fromdate,
            'filter_todate' => $filter_todate,
            'sort' => $data['sort'],
            'order' => $data['order'],
            'start' => ($data['page'] - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );
        //echo '<pre>';print_r($filter_data);echo '</pre>';
        if($filter_truckdata=='D'){
            $itemTotal = $this->model_settings_trip->getTotalItemsByTripDiesel($filter_data);
            $results = $this->model_settings_trip->getItemsByTripDiesel($filter_data);
        }else if($filter_truckdata=='M'){
            $itemTotal = $this->model_settings_trip->getTotalItemsByTripMaintenance($filter_data);
            $results = $this->model_settings_trip->getItemsByTripMaintenance($filter_data);
        }else{
            $itemTotal = $this->model_settings_trip->getTotalItems($filter_data);
            $results = $this->model_settings_trip->getItems($filter_data);
        }
        
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
        foreach ($results->rows as $k=>$result) {
            $data['items'][$k] =$result;
            //$data['items'][$k]['id']=$result['id_trip'];
	    $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $buttonUrl, true);
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
        //end
        //$data['url']=$this->url->link($data['route'] . '/index', 'token=' . $this->session->data['token'] , true);
        //echo '<pre>';print_r($data);echo '</pre>';exit;
        $data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];
        //echo '<pre>';print_r($data['items']);echo '</pre>';exit;
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }
    
    public function getlist() {
        //echo '<pre>';print_r($_GET);exit;
        $this->load->model('settings/trip');
        $route = $this->request->get['route'];

        $data['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'datecreated';
        $data['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : 'DESC';
        $data['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : 1;

        $filter_id_truck=isset($this->request->get['filter_id_truck'])?$this->request->get['filter_id_truck']:'';
        //echo '<pre>';print_r($filter_id_truck);exit;
        $filter_truckdata=isset($this->request->get['filter_truckdata'])?$this->request->get['filter_truckdata']:'';
        $filter_fromdate=isset($this->request->get['filter_fromdate'])?$this->request->get['filter_fromdate']:'';
        $filter_todate=isset($this->request->get['filter_todate'])?$this->request->get['filter_todate']:'';
	//$filter_materialcode=isset($this->request->get['filter_materialcode'])?$this->request->get['filter_materialcode']:'';
	$data['truckdata']=$filter_truckdata;
        $urlData['filter_id_truck']=$filter_id_truck;
        $urlData['filter_truckdata']=$filter_truckdata;
        $urlData['filter_fromdate']=$filter_fromdate;
        $urlData['filter_todate']=$filter_todate;

        $urlData['sort']=isset($this->request->get['sort']) ? $this->request->get['sort'] : '';
        $urlData['order']=isset($this->request->get['order']) ? $this->request->get['order'] : '';
        $urlData['page']=isset($this->request->get['page']) ? $this->request->get['page'] : '';
        $urlDataIgnore=array();
        $buttonUrl=getUrlString($urlData,$urlDataIgnore);
        $data['delete'] = $this->url->link($route . '/delete', 'token=' . $this->session->data['token'] . $buttonUrl, true);

        $data['items'] = array();

        $filter_data = array(
            'filter_multiple_id_truck' => $filter_id_truck,
            'filter_truckdata' => $filter_truckdata,
            'filter_fromdate' => $filter_fromdate,
            'filter_todate' => $filter_todate,
            'sort' => $data['sort'],
            'order' => $data['order'],
            'start' => ($data['page'] - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );
        
        $itemTotal = $this->model_settings_trip->getTotalItems($filter_data);

        $results = $this->model_settings_trip->getItems($filter_data);
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
        foreach ($results->rows as $k=>$result) {
            $data['items'][$k] =$result;
            $data['items'][$k]['id']=$result['id_trip'];
	    $data['items'][$k]['edit']=$this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_trip'] . $buttonUrl, true);
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
	//echo '<pre>';print_r($data['items']);exit;
        $this->response->setOutput($this->load->view($this->viewPathPrefix.'_list', $data));
    }
    
    public function download(){
        //echo '<pre>';print_r($_GET);EXIT;
        $filter_id_truck=isset($this->request->get['filter_id_truck'])?$this->request->get['filter_id_truck']:'';
        $filter_truckdata=isset($this->request->get['filter_truckdata'])?$this->request->get['filter_truckdata']:'';
        $filter_fromdate=isset($this->request->get['filter_fromdate'])?$this->request->get['filter_fromdate']:'';
        $filter_todate=isset($this->request->get['filter_todate'])?$this->request->get['filter_todate']:'';
        
        $filter_data = array(
            'filter_multiple_id_truck' => $filter_id_truck,
            'filter_truckdata' => $filter_truckdata,
            'filter_fromdate' => $filter_fromdate,
            'filter_todate' => $filter_todate,
            'sort' => $data['sort'],
            'order' => 'DESC',
            'start' => 0,
            'limit' => 10000
        );
        //echo '<pre>';print_r($filter_data);echo '</pre>';
        $this->load->model('settings/trip');
        $type="";
        if($filter_truckdata=='D'){
            $results = $this->model_settings_trip->getItemsByTripDiesel($filter_data);
            $type='D';
        }else if($filter_truckdata=='M'){
            $results = $this->model_settings_trip->getItemsByTripMaintenance($filter_data);
            $type='M';
        }else{
            $results = $this->model_settings_trip->getItems($filter_data);
            $type='T';
        }
        
        //echo '<pre>';print_r($results->rows);exit;
        $this->load->model('excel');
        $truckObj=$this->model_excel->downloadTruckReport($type,$results->rows);
        exit;
    }
 }