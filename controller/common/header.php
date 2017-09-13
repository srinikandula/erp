<?php
class ControllerCommonHeader extends Controller {
	public function index() {
		$data['title'] = $this->document->getTitle();

		/*if ($this->request->server['HTTPS']) {
			$data['base'] = HTTPS_SERVER;
		} else {
			$data['base'] = HTTP_SERVER;
		}

		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
		$data['styles'] = $this->document->getStyles();
		$data['scripts'] = $this->document->getScripts();*/

		if (!isset($this->request->get['token']) || !isset($this->session->data['token']) || ($this->request->get['token'] != $this->session->data['token'])) {
			$data['logged'] = '';

			$data['home'] = $this->url->link('common/dashboard', '', true);
		} else {
			$data['logged'] = true;

			$data['home'] = $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true);
			$data['logout'] = $this->url->link('common/logout', 'token=' . $this->session->data['token'], true);
			$data['route']=$this->request->get['route'];
			
			$exproute=explode("/",$data['route']);
			if(!in_array($data['route'],array('common/dashboard'))){
				$permission = $this->user->getPermission();
				//echo '<pre>';print_r($permission);exit;
				/*foreach($permission as $k=>$v){
					$exp=explode("/",$k);
					if($exp[0]==$exproute[0]){
						$data['navLinks'][$v['title']]=array('route'=>$k,'link'=>$v['link']);
					}
				}*/
				$modulelabel=$permission[$_GET['route']]['modulelabel'];
				foreach($permission as $k=>$v){
					if($v['modulelabel']==$modulelabel){
						$data['navLinks'][$v['title']]=array('route'=>$k,'link'=>$v['link']);
					}
				}
				$data['modulelabel']=$modulelabel;
			}	
		}
	
		
		
		//echo '<pre>';print_r($data['navLinks']);print_r($permission);echo '</pre>';

		//echo "value of ".$this->globalVal['todayDateTime'];
		return $this->load->view('common/header', $data);
	}
}