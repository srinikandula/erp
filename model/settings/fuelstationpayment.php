<?php
class ModelSettingsFuelstationpayment extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'fuel_station_payment';
		$this->pKey='id_fuel_station_payment';
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


	
	public function deleteItemByTripID($id) {
		$this->db->query("DELETE FROM ".$this->mTable." WHERE id_trip = '" . (int)$id . "'");
	}


	public function getItem($id) {
		//$sql="SELECT * from ".$this->mTable." where ".$this->pKey." = '" . (int)$id . "'";
		$sql="SELECT b.branchcity,b.isheadoffice,fsp.*,fs.fuelstationcode,fs.fuelstationname,fs.fuelpersonname,fs.fuelpersonmobile from ".$this->mTable." fsp inner join ".DB_PREFIX."fuel_station fs on fsp.id_fuel_station=fs.id_fuel_station left join ".DB_PREFIX."branch b on fsp.id_branch=b.id_branch  where fsp.".$this->pKey." = '" . (int)$id . "'";
		$query = $this->db->query($sql);

		return $query->row;
	}

	public function getItems($data = array()) {
		
		//$sql = "SELECT * FROM `" . $this->mTable . "` where ".$this->pKey."!=0";
		$sql = "SELECT b.branchcode,b.branchcity,b.isheadoffice,fsp.*,fs.fuelstationcode,fs.fuelstationname as  fuelstation,fs.fuelpersonname,fs.fuelpersonmobile,fs.bankname,fs.accountno,fs.bankbranch,fs.bankifsccode,fs.city FROM `" . $this->mTable . "`fsp left join ".DB_PREFIX."fuel_station fs on fsp.id_fuel_station=fs.id_fuel_station left join ".DB_PREFIX."branch b on fsp.id_branch=b.id_branch where  ".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		
		$sort_data = array(
			'amount',
			'qty'
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
		
		if (!empty($data['filter_id_trip'])) {
			$sql .= " AND id_trip = '" . (int)$data['filter_id_trip'] . "'";
		}
		
		if (!empty($data['filter_id_fuel_station'])) {
			$sql .= " AND id_fuel_station = '" . (int)$data['filter_id_fuel_station'] . "'";
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