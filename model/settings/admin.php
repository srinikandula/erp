<?php
class ModelSettingsAdmin extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'admin';
		$this->pKey='id_admin';
		return parent::__construct($className);
	}
	
	public function dataQry($data=array()){
		$return="";
		$comma="";
		foreach($data as $k=>$v){
			$return.=$comma.$k."='".$this->db->escape($v)."'";
			$comma=",";
		}
		return $return;
	}

	public function addItem($data) {
		
		$this->db->query("INSERT INTO ".$this->mTable." SET ".$this->dataQry($data));
		return $this->db->getLastId();
	}

	public function editItem($id, $data) {
		$this->db->query("update ".$this->mTable." SET ".$this->dataQry($data)." where ".$this->pKey."=".(int)$id);
	}

	public function deleteItem($id) {
		$this->db->query("DELETE FROM ".$this->mTable." WHERE ".$this->pKey." = '" . (int)$id . "'");
	}

	public function getItem($id) {
		$query = $this->db->query("SELECT * from ".$this->mTable." where ".$this->pKey." = '" . (int)$id . "'");

		return $query->row;
	}

	public function getItems($data = array()) {
		
		//$sql = "SELECT * FROM `" . $this->mTable . "` where ".$this->pKey."!=0";
		$sql = "SELECT a.*,b.branchcity,b.isheadoffice,ar.role FROM `" . $this->mTable . "` a left join ".DB_PREFIX."admin_role ar on a.id_admin_role=ar.id_admin_role left join ".DB_PREFIX."branch b on b.id_branch=a.id_branch where ".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		
		$sort_data = array(
			'adminname',
			'adminemail',
			'adminmobile',
			'username',
			'datecreated',
			'status'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY datecreated";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
		//exit($sql);
		$query = $this->db->query($sql);
		return $query;
	}

	public function getFilterSql($data,$sql){
		
		if (!empty($data['filter_material'])) {
			$sql .= " AND material LIKE '" . $this->db->escape($data['filter_material']) . "%'";
		}

		if (!empty($data['filter_materialcode'])) {
			$sql .= " AND materialcode LIKE '" . $this->db->escape($data['filter_materialcode']) . "%'";
		}
		return $sql;
	}

	public function getTotalItems($data = array()) {
		$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." where ".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function isUnique($type,$input,$id){
		if($type=='add'){
			$sql="select count(*) as total from ".$this->mTable." where adminemail like '".$input['adminemail']."'";
			$query = $this->db->query($sql);
			$email=$query->row['total']>0?0:1;

			$sql="select count(*) as total from ".$this->mTable." where username like '".$input['username']."'";
			$query = $this->db->query($sql);
			$username=$query->row['total']>0?0:1;
		
		}else{
			$sql="select count(*) as total from ".$this->mTable." where id_admin!=".$id." and adminemail like '".$input['adminemail']."'";
			$query = $this->db->query($sql);
			$email=$query->row['total']>0?0:1;

			$sql="select count(*) as total from ".$this->mTable." where id_admin!=".$id." and username like '".$input['username']."'";
			$query = $this->db->query($sql);
			$username=$query->row['total']>0?0:1;
		}
		return array('email'=>$email,'username'=>$username);
	}
}