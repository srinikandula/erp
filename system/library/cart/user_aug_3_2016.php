<?php
namespace Cart;
class User {
	private $user_id;
	private $username;
	private $permission = array();

	public function __construct($registry) {
		//exit("in user");
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');
		$this->cache = $registry->get('cache');
		$this->url = $registry->get('url');
		//echo $this->session->data['user_id']." ".$this->session->data['id_admin_role']." ".$this->session->data['username'];
		if (isset($this->session->data['user_id'])) {
			//echo '<pre>';print_r($this->session->data);exit;
			//exit("in const");

			if ($this->session->data['user_id']) {
				$this->user_id = $this->session->data['user_id'];
				$this->username = $this->session->data['username'];
				$this->user_group_id = $this->session->data['id_admin_role'];

				$this->db->query("UPDATE " . DB_PREFIX . "admin SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE id_admin = '" . (int)$this->session->data['user_id'] . "'");

				//$user_group_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "admin_permission WHERE id_admin_role = '" . (int)$this->session->data['id_admin_role'] . "'");
				//echo '<pre>';print_r($user_group_query);exit;
				//$permissions = json_decode($user_group_query->row['permission'], true);

				//$this->createPermArray($user_group_query);
				//$this->getUserPermissions();
				$this->permission=$this->getUserPermissions();
			} else {
				$this->logout();
			}
		}
	}

	/*public function createPermArray($user_group_query){
		if ($user_group_query->num_rows) {
			foreach ($user_group_query->rows as $key => $value) {
				$page_url=strtolower(str_replace(" ","",$value['modulename']."/".$value['filename']));
				if($value['view']){
					$this->permission['view'][] = $page_url;
				}
				
				if($value['add']){
					$this->permission['add'][] = $page_url;
				}
				if($value['edit']){
					$this->permission['edit'][] = $page_url;
				}
				if($value['delete']){
					$this->permission['delete'][] = $page_url;
				}
				if($value['listall']){
					$this->permission['listall'][] = $page_url;
				}
			}
		}
				//$this->permission=$this->getUserPermissions();
				//echo '<pre>';print_r($user_group_query->rows);print_r($this->permission);exit;
	}*/
	
	public function __construct1($registry) {
		$this->db = $registry->get('db');
		$this->request = $registry->get('request');
		$this->session = $registry->get('session');

		if (isset($this->session->data['user_id'])) {
			

			if (isset($this->session->data['id_admin_role'])) {
				$this->user_id = $this->session->data['user_id'];
				$this->username = $this->session->data['username'];
				$this->user_group_id = $this->session->data['user_group_id'];

				$this->db->query("UPDATE " . DB_PREFIX . "user SET ip = '" . $this->db->escape($this->request->server['REMOTE_ADDR']) . "' WHERE user_id = '" . (int)$this->session->data['user_id'] . "'");

				$user_group_query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");
				echo '<pre>';print_r($user_group_query);exit;
				$permissions = json_decode($user_group_query->row['permission'], true);

				if (is_array($permissions)) {
					foreach ($permissions as $key => $value) {
						$this->permission[$key] = $value;
					}
				}
			} else {
				$this->logout();
			}
		}
	}

	public function login($username, $password) {

		$user_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "admin WHERE username = '" . $this->db->escape($username) . "' AND (password = SHA1(CONCAT(salt, SHA1(CONCAT(salt, SHA1('" . $this->db->escape($password) . "'))))) OR password = '" . $this->db->escape(md5($password)) . "') AND status = '1'");
		//exit("value of ".$user_query->num_rows);	
		if ($user_query->num_rows) {
			$this->session->data['user_id'] = $user_query->row['id_admin'];
			$this->session->data['username'] = $user_query->row['username'];
			$this->session->data['adminname'] = $user_query->row['adminname'];
			$this->session->data['adminemail'] = $user_query->row['adminemail'];
			$this->session->data['id_branch'] = $user_query->row['id_branch'];
			$this->session->data['id_admin_role'] = $user_query->row['id_admin_role'];
			
			$this->user_id = $user_query->row['id_admin'];
			$this->username = $user_query->row['username'];
			$this->user_group_id = $user_query->row['id_admin_role'];

			//$user_group_query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");

			/*$user_group_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "admin_permission WHERE id_admin_role = '" . (int)$user_query->row['id_admin_role'] . "'");

			$this->createPermArray($user_group_query);*/
			
			$this->permission=$this->getUserPermissions();

			return true;
		} else {
			return false;
		}
	}

	public function login1($username, $password) {
		$user_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "user WHERE username = '" . $this->db->escape($username) . "' AND (password = SHA1(CONCAT(salt, SHA1(CONCAT(salt, SHA1('" . $this->db->escape($password) . "'))))) OR password = '" . $this->db->escape(md5($password)) . "') AND status = '1'");

		if ($user_query->num_rows) {
			$this->session->data['user_id'] = $user_query->row['user_id'];

			$this->user_id = $user_query->row['user_id'];
			$this->username = $user_query->row['username'];
			$this->user_group_id = $user_query->row['user_group_id'];

			$user_group_query = $this->db->query("SELECT permission FROM " . DB_PREFIX . "user_group WHERE user_group_id = '" . (int)$user_query->row['user_group_id'] . "'");

			$permissions = json_decode($user_group_query->row['permission'], true);

			if (is_array($permissions)) {
				foreach ($permissions as $key => $value) {
					$this->permission[$key] = $value;
				}
			}

			return true;
		} else {
			return false;
		}
	}

	public function logout() {
		unset($this->session->data['user_id']);

		$this->user_id = '';
		$this->username = '';
	}

	public function hasPermission($key, $value) {
		//echo $key." ".$value.'<pre>';print_r($this->permission);exit;
		/*if (isset($this->permission[$key])) {
			//exit("in if");
			return in_array($value, $this->permission[$key]);*/
		$exp=explode("/",$value);
		if(isset($this->permission[$exp[0]][$exp[1]][$key])){
			return true;
		} else {
			//exit("in else");
			return false;
		}
	}

	public function isLogged() {
		return $this->user_id;
	}

	public function getId() {
		return $this->user_id;
	}

	public function getUserName() {
		return $this->username;
	}

	public function getPermission() {
		return $this->permission;
	}

	public function getGroupId() {
		return $this->user_group_id;
	}

	public function getUserPermissions(){
		$return = $this->cache->get('getUserPermissions');
		if (!$return) {
			//exit("inside getPermissions");
			$user_permissions_query=$this->db->query("select * from " . DB_PREFIX . "admin_permission where status=1 and view=1 and  id_admin_role=".(int)$_SESSION['default']['id_admin_role']." order by modulesortorder asc,filesortorder asc");
			//echo $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true);
			$return=array();
			foreach($user_permissions_query->rows as $row){
				$return[strtolower($row['modulename'])][$row['filename']]=array('title'=>$row['title'],'link'=>$this->url->link(strtolower(str_replace(" ","",$row['modulename']."/".$row['filename'])), 'token=' . $this->session->data['token'], true),'listall'=>$row['listall'],'view'=>$row['view'],'add'=>$row['add'],'edit'=>$row['edit'],'delete'=>$row['delete']);
			}
			$this->cache->set('getUserPermissions', $return);
		}
		//echo '<pre>';print_r($return); print_r($user_permissions_query->rows);exit;
		return $return;
		//$this->permission;
	}
}