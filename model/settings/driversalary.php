<?php
class ModelSettingsDriversalary extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'driver_salary';
		$this->pKey='id_driver_salary';
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
		$sql = "SELECT b.branchcity,b.branchcode,b.branchaddress,d.drivercode,d.drivername,d.drivermobile,d.doj,d.licenceno,d.licencevalidtilldate,d.driveraddress,d.alternateno,d.bankname,d.accountno,d.bankbranch,d.bankifsccode,d.status,d.fixedpermonth,d.batta,d.pertrippercentonfreight,d.pertripcommission,d.deductshortage,d.deductdamage,d.deductoilshortage,ds.* FROM `" . $this->mTable . "` ds left join ".DB_PREFIX."driver d on ds.id_driver=d.id_driver left join ".DB_PREFIX."branch b on b.id_branch=ds.paidby_id_branch  where ".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		
		$sort_data = array(
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

	public function getFilterSql($data,$sql){
		
		if (!empty($data['filter_id_driver'])) {
			$sql .= " AND ds.id_driver='" . (int)$data['filter_id_driver'] . "'";
		}

		if (!empty($data['filter_id_branch'])) {
			$sql .= " AND paidby_id_branch='" . (int)$data['filter_id_branch'] . "'";
		}

		if (!empty($data['filter_closed'])) {
			$sql .= " AND closed='" . (int)$data['filter_closed'] . "'";
		}

		if (!empty($data['filter_fromdate'])  && !empty($data['filter_todate'])) {
			$sql .= " AND settlementdate >='" . $data['filter_fromdate'] . "' AND settlementdate <='" . $data['filter_todate'] . "'";
		}

		return $sql;
	}

	public function getTotalItems($data = array()) {
		$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." ds where ds.".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}