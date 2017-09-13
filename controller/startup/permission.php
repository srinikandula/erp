<?php
class ControllerStartupPermission extends Controller {
	public function index() {
		
		if (isset($this->request->get['route'])) {
			$route = '';

			$part = explode('/', $this->request->get['route']);

			if (isset($part[0])) {
				$route .= $part[0];
			}

			if (isset($part[1])) {
				$route .= '/' . $part[1];
			}

			$ignore = array(
				'common/dashboard',
				'common/login',
				'common/logout',
				'common/forgotten',
				'common/reset',
				'error/not_found',
				'error/permission'
			);
			//print("value of ".$route);//exit("in permission");
			if (!in_array($route, $ignore) && !$this->user->hasPermission('view', $route)) {
				//exit("in error permission");
				return new Action('error/permission');
			}/*else{
				exit("in else");
			}
			exit("in permission");*/
		}
		
	}
}
