<?php

class ControllerCommonDashboard extends Controller {

    public function index() {
        //echo strtotime('now');
        //exit;
        //echo "value of ".$this->todayDateTime;        
        //echo '<pre>';print_r($this->globalVal);exit;
        $this->document->setTitle('Dashboard');

        $data['token'] = $this->session->data['token'];
        $data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        //$data['siteMap'] = $this->user->getPermission();
        //echo '<pre>';print_r($data['siteMap']);echo '</pre>';
        $permission = $this->user->getPermission();
        /*foreach($permission as $k=>$v){
                $exp=explode("/",$k);
                $data['siteMap'][$exp[0]][]=$v;
        }*/

        foreach($permission as $k=>$v){
            //$exp=explode("/",$k);
            $data['siteMap'][$v['modulelabel']][]=$v;
        }
        
        $this->load->model('settings/truck');
        $truckObj=$this->model_settings_truck->getItemsExpiry();
        $data['truckRenewals']=$truckObj->rows;
        //echo '<pre>';print_r($truckObj->rows);exit;
        $data['truckexpirydownloadlink']=$this->url->link('common/dashboard/downloadtruckexpiry', 'token=' . $this->session->data['token'], true);
        $this->response->setOutput($this->load->view('common/dashboard', $data));
    }
    
    public function downloadtruckexpiry(){
        /*require_once DIR_APPLICATION.'model/excel.php';
        $eObj=new excel();
        $eObj->downloadTruckExpiry();*/
        $this->load->model('settings/truck');
        $truckObj=$this->model_settings_truck->getItemsExpiry();
        //echo '<pre>';print_r($truckObj->rows);exit;        
        $this->load->model('excel');
        $truckObj=$this->model_excel->downloadTruckExpiry($truckObj->rows);
        exit;
    }
}