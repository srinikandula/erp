<?php
class ModelSettingsMaterial extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'material';
		$this->pKey='id_material';
		return parent::__construct($className);
	}
	
	public function dataQry($data){
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
		
		$sql = "SELECT * FROM `" . $this->mTable . "` where ".$this->pKey."!=0";
		
		if (!empty($data['filter_material'])) {
			$sql .= " AND material LIKE '" . $this->db->escape($data['filter_material']) . "%'";
		}

		if (!empty($data['filter_materialcode'])) {
			$sql .= " AND materialcode LIKE '" . $this->db->escape($data['filter_materialcode']) . "%'";
		}

		$sort_data = array(
			'material',
			'materialcode',
			'datecreated'
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

	public function getTotalItems($data = array()) {
		$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." where ".$this->pKey."!=0";
		
		if (!empty($data['filter_material'])) {
			$sql .= " AND material LIKE '" . $this->db->escape($data['filter_material']) . "%'";
		}

		if (!empty($data['filter_materialcode'])) {
			$sql .= " AND materialcode LIKE '" . $this->db->escape($data['filter_materialcode']) . "%'";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}