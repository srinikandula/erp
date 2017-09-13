<?php
class ModelSettingsTruck extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'truck';
		$this->pKey='id_truck';
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

	public function getItemsExpiry(){
		//select * from erp_truck where own=1 and ()
		$expDays=date('Y-m-d', strtotime(date('Y-m-d') . ' -5 day'));
		$sql="SELECT * from ".$this->mTable." where own=1 and (taxpayabledate>='".$expDays."' or pollutionexpdate>='".$expDays."' or nationalpermitexpdate>='".$expDays."' or insuranceexpdate>='".$expDays."' or hubservicedate>='".$expDays."' or fitnessexpdate>='".$expDays."' or dateinservice>='".$expDays."') order by fitnessexpdate,insuranceexpdate,nationalpermitexpdate,pollutionexpdate asc";
		//echo $sql;
		$query = $this->db->query($sql);
		return $query; 
	}

	public function getItems($data = array()) {
		
		$sql = "SELECT *,(select trucktype from ".DB_PREFIX."truck_type tt where tt.id_truck_type=" . $this->mTable . ".id_truck_type) as trucktype FROM `" . $this->mTable . "` where ".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		
		$sort_data = array(
			'id_truck_type',
			'truckno',
			'own',
			'make',
			'makeyear',
			'model',
			'dateinservice',
			'fitnessexpdate',
			'hubservicedate',
			'insuranceexpdate',
			'nationalpermitexpdate',
			'pollutionexpdate',
			'taxpayabledate',
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
		//print($sql);exit;
		$query = $this->db->query($sql);
		return $query;
	}

	public function getFilterSql($data,$sql){
		
		if (!empty($data['filter_material'])) {
			$sql .= " AND material LIKE '" . $this->db->escape($data['filter_material']) . "%'";
		}

		if (!empty($data['filter_id_truck'])) {
			$sql .= " AND id_truck = '" . (int)$this->db->escape($data['filter_id_truck']) . "'";
		}

		if (!empty($data['filter_fromdate']) && !empty($data['filter_todate'])) {
			$sql .= " AND ((dateinservice >= '" . $data['filter_fromdate'] . "' and  dateinservice <= '" . $data['filter_todate'] . "') or (fitnessexpdate >= '" . $data['filter_fromdate'] . "' and  fitnessexpdate <= '" . $data['filter_todate'] . "') or  (hubservicedate >= '" . $data['filter_fromdate'] . "' and  hubservicedate <= '" . $data['filter_todate'] . "') or  (insuranceexpdate >= '" . $data['filter_fromdate'] . "' and  insuranceexpdate <= '" . $data['filter_todate'] . "') or  (nationalpermitexpdate >= '" . $data['filter_fromdate'] . "' and  nationalpermitexpdate <= '" . $data['filter_todate'] . "') or  (pollutionexpdate >= '" . $data['filter_fromdate'] . "' and  pollutionexpdate <= '" . $data['filter_todate'] . "') or  (taxpayabledate >= '" . $data['filter_fromdate'] . "' and  taxpayabledate <= '" . $data['filter_todate'] . "'))";
		}

		//echo "value of ".$data['filter_own'];
		if (isset($data['filter_own']) && $data['filter_own']!="") {
			$sql .= " AND own = '" . (int)$data['filter_own']."'";
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