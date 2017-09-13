<?php

class ControllerReportsDsalreport extends Controller {

    private $error = array();
    public $viewPathPrefix = 'reports/dsalreport';

    public function index() {

        //$this->document->setTitle('Truck Spares');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        $this->document->setTitle($data['page']['title']);
        $data['route'] = $this->request->get['route'];

        $data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'], true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'], true);

        $data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];

        //Drivers
        $this->load->model('settings/driver');
        $filter_data = array(
            //    'filter_own'=>'1',    
            'sort' => 'drivername',
            'order' => 'asc'
        );
        $driversQry = $this->model_settings_driver->getItems($filter_data);
        //$data['trucks'] =$trucksQry->rows;
        foreach ($driversQry->rows as $row) {
            $data['drivers'][$row['id_driver']] = $row;
        }

        //Branches
        $this->load->model('settings/branch');
        $filter_data = array(
            'sort' => 'branchcity',
            'order' => 'asc'
        );
        $branchesQry = $this->model_settings_branch->getItems($filter_data);
        foreach ($branchesQry->rows as $row) {
            $data['branches'][$row['id_branch']] = $row;
        }
		//exit("here");
        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }

    public function getlist() {
        //echo '<pre>';print_r($_GET);exit;
        $this->load->model('settings/driversalary');
        $route = $this->request->get['route'];

        $data['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'datecreated';
        $data['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : 'DESC';
        $data['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : 1;

        $filter_id_branch = isset($this->request->get['filter_id_branch']) ? $this->request->get['filter_id_branch'] : '';
        $filter_id_driver = isset($this->request->get['filter_id_driver']) ? $this->request->get['filter_id_driver'] : '';
        $filter_fromdate = isset($this->request->get['filter_fromdate']) ? $this->request->get['filter_fromdate'] : '';
        $filter_todate = isset($this->request->get['filter_todate']) ? $this->request->get['filter_todate'] : '';
        $filter_closed = isset($this->request->get['filter_closed']) ? 1 : '';
        
        $urlData['filter_id_driver'] = $filter_id_driver;
        $urlData['filter_id_branch'] = $filter_id_branch;
        $urlData['filter_fromdate'] = $filter_fromdate;
        $urlData['filter_todate'] = $filter_todate;
        $urlData['filter_closed'] = $filter_closed;

        $urlData['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : '';
        $urlData['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : '';
        $urlData['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : '';
        $urlDataIgnore = array();
        $buttonUrl = getUrlString($urlData, $urlDataIgnore);
        $data['delete'] = $this->url->link($route . '/delete', 'token=' . $this->session->data['token'] . $buttonUrl, true);

        $data['items'] = array();

        $filter_data = array(
            'filter_id_driver' => $filter_id_driver,
            'filter_id_branch' => $filter_id_branch,
            'filter_fromdate' => $filter_fromdate,
            'filter_todate' => $filter_todate,
            'filter_closed' => $filter_closed,
            'sort' => $data['sort'],
            'order' => $data['order'],
            'start' => ($data['page'] - 1) * $this->config->get('config_limit_admin'),
            'limit' => $this->config->get('config_limit_admin')
        );
        //echo '<pre>';print_r($filter_data);echo '</pre>';
        $itemTotal = $this->model_settings_driversalary->getTotalItems($filter_data);

        $results = $this->model_settings_driversalary->getItems($filter_data);
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
        foreach ($results->rows as $k => $result) {
            $data['items'][$k] = $result;
            $data['items'][$k]['edit'] = $this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' .$buttonUrl, true);
            $data['items'][$k]['sno'] = $k + $pageSno;
        }


        $urlDataIgnore = array('page');
        $pageUrl = getUrlString($urlData, $urlDataIgnore);

        $pagination = new Pagination();
        $pagination->total = $itemTotal;
        $pagination->page = $data['page'];
        $pagination->limit = $this->config->get('config_limit_admin');
        $pagination->url = $this->url->link($route, 'token=' . $this->session->data['token'] . $pageUrl . '&page={page}', true);
        $data['pagination'] = $pagination->render();

        $data['results'] = sprintf('Showing %d to %d of %d (%d Pages)', ($itemTotal) ? (($data['page'] - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($data['page'] - 1) * $this->config->get('config_limit_admin')) > ($itemTotal - $this->config->get('config_limit_admin'))) ? $itemTotal : ((($data['page'] - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $itemTotal, ceil($itemTotal / $this->config->get('config_limit_admin')));

        $urlData['order'] = $data['order'] == 'ASC' ? 'DESC' : 'ASC';
        $urlDataIgnore = array('sort');
        $sortUrl = getUrlString($urlData, $urlDataIgnore);
        //$data['sort_material'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=material' . $sortUrl, true);
        //$data['sort_materialcode'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=materialcode' . $sortUrl, true);

        $data['selected'] = isset($this->request->post['selected']) ? (array) $this->request->post['selected'] : array();
        //echo '<pre>';print_r($data['items']);exit;
        $this->response->setOutput($this->load->view($this->viewPathPrefix . '_list', $data));
    }
    
    public function download(){
        $filter_id_branch = isset($this->request->get['filter_id_branch']) ? $this->request->get['filter_id_branch'] : '';
        $filter_id_driver = isset($this->request->get['filter_id_driver']) ? $this->request->get['filter_id_driver'] : '';
        $filter_fromdate = isset($this->request->get['filter_fromdate']) ? $this->request->get['filter_fromdate'] : '';
        $filter_todate = isset($this->request->get['filter_todate']) ? $this->request->get['filter_todate'] : '';
        $filter_closed = isset($this->request->get['filter_closed']) ? 1 : '';

        $filter_data = array(
                'filter_id_driver' => $filter_id_driver,
                'filter_id_branch' => $filter_id_branch,
                'filter_fromdate' => $filter_fromdate,
                'filter_todate' => $filter_todate,
                'filter_closed' => $filter_closed,
                'sort' => $data['sort'],
                'order' => 'DESC',
                'start' => 0,
                'limit' => 10000
        );
        $this->load->model('settings/driversalary');
        $results = $this->model_settings_driversalary->getItems($filter_data);
        
        //echo '<pre>';print_r($results->rows);exit;
        $this->load->model('excel');
        $truckObj=$this->model_excel->downloaddsalReport($results->rows);
        exit;
    }
}