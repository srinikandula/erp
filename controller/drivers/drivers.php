<?php

class ControllerDriversDrivers extends Controller {

    private $error = array();
    public $viewPathPrefix = 'drivers/drivers';

    public function index() {

        //$this->document->setTitle('Drivers');
        $data = $this->user->getPageAccessInfo($this->request->get['route']);
        $this->document->setTitle($data['page']['title']);
        $data['route'] = $this->request->get['route'];

        $data['add'] = $this->url->link($data['route'] . '/add', 'token=' . $this->session->data['token'], true);
        $data['delete'] = $this->url->link($data['route'] . '/delete', 'token=' . $this->session->data['token'], true);

        $data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        $data['token'] = $this->request->get['token'];

        $this->response->setOutput($this->load->view($this->viewPathPrefix, $data));
    }

    public function getlist() {

        $this->load->model('settings/driver');

        $route = $this->request->get['route'];

        $data['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'datecreated';
        $data['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : 'DESC';
        $data['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : 1;

        //$filter_material=isset($this->request->get['filter_material'])?$this->request->get['filter_material']:'';
        //$filter_materialcode=isset($this->request->get['filter_materialcode'])?$this->request->get['filter_materialcode']:'';
        //$urlData['filter_material']=$filter_material;
        //$urlData['filter_materialcode']=$filter_materialcode;
        $urlData['sort'] = isset($this->request->get['sort']) ? $this->request->get['sort'] : '';
        $urlData['order'] = isset($this->request->get['order']) ? $this->request->get['order'] : '';
        $urlData['page'] = isset($this->request->get['page']) ? $this->request->get['page'] : '';
        $urlDataIgnore = array();
        $buttonUrl = getUrlString($urlData, $urlDataIgnore);
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

        $itemTotal = $this->model_settings_driver->getTotalItems($filter_data);
        //exit(" value of ");
        $results = $this->model_settings_driver->getItems($filter_data);
        //echo '<pre>';print_r($results);exit;
        $pageSno = !isset($this->request->get['page']) ? 1 : ($this->request->get['page'] * $this->config->get('config_limit_admin')) - 1;
        //echo '<pre>';print_r($results->rows);
        //exit("here");
        foreach ($results->rows as $k => $result) {
            $data['items'][] = array(
                'id' => $result['id_driver'],
                'drivercode' => $result['drivercode'],
                'drivername' => $result['drivername'],
                'drivermobile' => $result['drivermobile'],
                'doj' => $result['doj'],
                'licenceno' => $result['licenceno'],
                'licencevalidtilldate' => $result['licencevalidtilldate'],
                'driveraddress' => $result['driveraddress'],
                'alternateno' => $result['alternateno'],
                'bankname' => $result['bankname'],
                'accountno' => $result['accountno'],
                'bankbranch' => $result['bankbranch'],
                'bankifsccode' => $result['bankifsccode'],
                'status' => $result['status'],
                'fixedpermonth' => $result['fixedpermonth'],
                'batta' => $result['batta'],
                'pertrippercentonfreight' => $result['pertrippercentonfreight'],
                'pertripcommission' => $result['pertripcommission'],
                'datecreated' => $result['datecreated'],
                'datemodified' => $result['datemodified'],
                'edit' => $this->url->link($route . '/edit', 'token=' . $this->session->data['token'] . '&id=' . $result['id_driver'] . $buttonUrl, true),
                'sno' => $k + $pageSno,
            );
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
        $data['sort_drivercode'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=drivercode' . $sortUrl, true);
        $data['sort_drivername'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=drivername' . $sortUrl, true);
        $data['sort_drivermobile'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=drivermobile' . $sortUrl, true);
        $data['sort_doj'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=doj' . $sortUrl, true);
        $data['sort_licencevalidtilldate'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=licencevalidtilldate' . $sortUrl, true);
        $data['sort_status'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=status' . $sortUrl, true);
        $data['sort_fixedpermonth'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=fixedpermonth' . $sortUrl, true);
        $data['sort_batta'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=batta' . $sortUrl, true);
        $data['sort_pertrippercentonfreight'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=pertrippercentonfreight' . $sortUrl, true);
        $data['sort_pertripcommission'] = $this->url->link($route, 'token=' . $this->session->data['token'] . '&sort=pertripcommission' . $sortUrl, true);

        $data['selected'] = isset($this->request->post['selected']) ? (array) $this->request->post['selected'] : array();

        $this->response->setOutput($this->load->view($this->viewPathPrefix . '_list', $data));
    }

    public function add() {

        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'add'))) {
            $this->load->model('settings/driver');
            $cols = $this->request->post['field'];
            $cols['datemodified'] = $this->globalVal['todayDateTime'];
            $cols['datecreated'] = $this->globalVal['todayDateTime'];
            $this->model_settings_driver->addItem($cols);
            $json['status'] = 1;
            $json['msg'] = FLASH_ADD_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function edit() {

        $json['status'] = 0;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm(array('perm' => 'edit'))) {
            $this->load->model('settings/driver');
            $cols = $this->request->post['field'];
            $cols['datemodified'] = $this->globalVal['todayDateTime'];
            $this->model_settings_driver->editItem($this->request->post['pkey'], $cols);
            $json['status'] = 1;
            $cols['id'] = $this->request->post['pkey'];
            $json['data'] = json_encode($cols);
            $json['msg'] = FLASH_EDIT_SUCCESS_MSG;
        } else {
            $json['msg'] = implode(" , ", $this->error);
        }
        echo json_encode($json);
    }

    public function delete() {

        $json['status'] = 0;
        if (isset($this->request->post['selected']) && $this->validateDelete(array('perm' => 'delete'))) {
            $this->load->model('settings/driver');
            foreach ($this->request->post['selected'] as $id) {
                $this->model_settings_driver->deleteItem($id);
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

    public function calendar() {
          
        
$id_driver=$this->request->get['id_driver'];
$getMonth=isset($this->request->get['month'])?$this->request->get['month']:"";
$setM="";
if($getMonth!=""){
$exp=explode("-",$getMonth);
$m=$exp[0]<10?"0".$exp[0]:$exp[0];
$leavedate=$exp[1].'-'.$m;
$setM=$m;

}else{
   $leavedate=date("Y")."-".date("m");
   $setM=date("m");
}

$this->load->model('settings/driverleave');
$rows=$this->model_settings_driverleave->getItems(array("filter_id_driver"=>$id_driver,"filter_leavedate"=>$leavedate.'%'));
$leaves=array();
foreach($rows->rows as $row){
    $leaves[]=$row['leavedate'];
}
//echo $leavedate.'<pre>';print_r($rows); print_r($leaves);echo '</pre>';
// Get current year, month and day
        list($iNowYear, $iNowMonth, $iNowDay) = explode('-', date('Y-m-d'));

// Get current year and month depending on possible GET parameters
        if (isset($_GET['month'])) {
            list($iMonth, $iYear) = explode('-', $_GET['month']);
            $iMonth = (int) $iMonth;
            $iYear = (int) $iYear;
        } else {
            list($iMonth, $iYear) = explode('-', date('n-Y'));
        }

// Get name and number of days of specified month
        $iTimestamp = mktime(0, 0, 0, $iMonth, $iNowDay, $iYear);
        list($sMonthName, $iDaysInMonth) = explode('-', date('F-t', $iTimestamp));

// Get previous year and month
        $iPrevYear = $iYear;
        $iPrevMonth = $iMonth - 1;
        if ($iPrevMonth <= 0) {
            $iPrevYear--;
            $iPrevMonth = 12; // set to December
        }

// Get next year and month
        $iNextYear = $iYear;
        $iNextMonth = $iMonth + 1;
        if ($iNextMonth > 12) {
            $iNextYear++;
            $iNextMonth = 1;
        }

// Get number of days of previous month
        $iPrevDaysInMonth = (int) date('t', mktime(0, 0, 0, $iPrevMonth, $iNowDay, $iPrevYear));

// Get numeric representation of the day of the week of the first day of specified (current) month
        $iFirstDayDow = (int) date('w', mktime(0, 0, 0, $iMonth, 1, $iYear));

// On what day the previous month begins
        $iPrevShowFrom = $iPrevDaysInMonth - $iFirstDayDow + 1;

// If previous month
        $bPreviousMonth = ($iFirstDayDow > 0);

// Initial day
        $iCurrentDay = ($bPreviousMonth) ? $iPrevShowFrom : 1;

        $bNextMonth = false;
        $sCalTblRows = '';
        $leaveStyle="";
// Generate rows for the calendar
        for ($i = 0; $i < 6; $i++) { // 6-weeks range
            $sCalTblRows .= '<tr>';
            for ($j = 0; $j < 7; $j++) { // 7 days a week
                $sClass = '';
                if ($iNowYear == $iYear && $iNowMonth == $iMonth && $iNowDay == $iCurrentDay && !$bPreviousMonth && !$bNextMonth) {
                    $sClass = 'today';
                } elseif (!$bPreviousMonth && !$bNextMonth) {
                    $sClass = 'current';
                }
                $iCurrentDayPre=$iCurrentDay<10?"0".$iCurrentDay:$iCurrentDay;
                $dt=$iYear . '-' . $iMonth . '-' . $iCurrentDayPre;
                $iMonthPre=$iMonth<10?"0".$iMonth:$iMonth;
                $leaveStyle=$sClass!="" && in_array($iYear.'-'.$iMonthPre.'-'.$iCurrentDayPre,$leaves)?"style='border:solid 3px green'":"";
                
                $sCalTblRows .= '<td '.$leaveStyle.' class="' . $sClass . '" id="' . $iYear . '-' . $iMonth . '-' . $iCurrentDayPre . '"><a href="javascript: setDate(\''.$dt.'\')">' . $iCurrentDay.'</a></td>';

                // Next day
                $iCurrentDay++;
                if ($bPreviousMonth && $iCurrentDay > $iPrevDaysInMonth) {
                    $bPreviousMonth = false;
                    $iCurrentDay = 1;
                }
                if (!$bPreviousMonth && !$bNextMonth && $iCurrentDay > $iDaysInMonth) {
                    $bNextMonth = true;
                    $iCurrentDay = 1;
                }
            }
            $sCalTblRows .= '</tr>';
        }

// Prepare replacement keys and generate the calendar
        $aKeys = array(
            '__prev_month__' => "{$iPrevMonth}-{$iPrevYear}",
            '__next_month__' => "{$iNextMonth}-{$iNextYear}",
            '__cal_caption__' => $sMonthName . ', ' . $iYear,
            '__cal_rows__' => $sCalTblRows,
        );
        $sCalendarItself = strtr(file_get_contents(HTTP_SERVER.'view/calendar/templates/calendar.php?id_driver='.$id_driver.'&token='.$_GET['token']), $aKeys);

// AJAX requests - return the calendar
        if (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && $_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest' && isset($_GET['month'])) {
            header('Content-Type: text/html; charset=utf-8');
            echo $sCalendarItself;
            exit;
        }

        $aVariables = array(
            '__calendar__' => $sCalendarItself,
        );
        echo strtr(file_get_contents(HTTP_SERVER.'view/calendar/templates/index.php?token='.$_GET['token']), $aVariables);
    }
    
    public function addleave() {

        $json['status'] = 0;
        $id_driver=(int)$this->request->post['id_driver'];
        $leavedate=$this->request->post['leavedate'];        
        if ($id_driver && $leavedate!="") {
            $json['status'] = 1;
            $this->load->model('settings/driverleave');
            $rows=$this->model_settings_driverleave->getItems(array("filter_id_driver"=>$id_driver,"filter_leavedate"=>$leavedate));
            //echo '<pre>';print_r($rows);exit;
            //exit("value of ".$rows->num_rows);
            if($rows->num_rows){
                //exit("inside");
                foreach($rows->rows as $row){
                    $this->model_settings_driverleave->deleteItem($row['id_driver_leave']);
                    
                }
                $json['add'] = 0;
            }else{
                $this->model_settings_driverleave->addItem(array('id_driver'=>$id_driver,'leavedate'=>$leavedate));
                $json['add'] = 1;
            }
        }
        echo json_encode($json);
    }
}