<?php
class ModelSettingsAdminpermission extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'admin_permission';
		$this->pKey='id_admin_permission';
		return parent::__construct($className);
	}
	
	public function dataQry($data=array()){
		$return="";
		$comma="";
		foreach($data as $k=>$v){
			$return.=$comma.'`'.$k.'`'."='".$this->db->escape($v)."'";
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

	public function deletePermissionByRole($id) {
		$this->db->query("DELETE FROM ".$this->mTable." WHERE id_admin_role = '" . (int)$id . "'");
	}

	public function getItem($id) {
		$query = $this->db->query("SELECT * from ".$this->mTable." where ".$this->pKey." = '" . (int)$id . "'");

		return $query->row;
	}

	public function getItems($data = array()) {
		
		$sql = "SELECT * FROM `" . $this->mTable . "` where ".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		
		$sort_data = array(
			'modulename'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY modulename";
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

	public function getPermissionsByRole($id){
		$sql="select * from ".DB_PREFIX."admin_permission where status=1 and id_admin_role='".(int)$id."' order by modulesortorder asc,filesortorder asc";
		$query = $this->db->query($sql);
		return $query;
	}

	public function getFilterSql($data,$sql){
		
		if (!empty($data['filter_id_admin_role'])) {
			$sql .= " AND id_admin_role = '" . $this->db->escape($data['filter_id_admin_role']) . "'";
		}
		return $sql;
	}

	public function getTotalItems($data = array()) {
		$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." where ".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}