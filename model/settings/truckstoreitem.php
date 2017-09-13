<?php
class ModelSettingsTruckstoreitem extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'truck_store_item';
		$this->pKey='id_truck_store_item';
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
	
		//$sql="SELECT * from ".$this->mTable." where ".$this->pKey."!=0";
		$sql="SELECT tsi.*,t.truckno,b.branchcity,b.branchcode,b.isheadoffice,si.itemname,si.make,si.type from ".$this->mTable." tsi left join  ".DB_PREFIX."branch b on b.id_branch=tsi.id_branch left join ".DB_PREFIX."truck t  on t.id_truck=tsi.id_truck left join ".DB_PREFIX."store_item si on tsi.id_store_item=si.id_store_item where tsi.".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		
		$sort_data = array(
			'id_truck_store_item',
			'dateattached',
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
		//print($sql);
		$query = $this->db->query($sql);
		return $query;
	}

	public function getFilterSql($data,$sql){
		//echo '<pre>';print_r($data);echo '</pre>';	
		if (!empty($data['filter_id_truck'])) {
			$sql .= " AND tsi.id_truck = '" . (int)$data['filter_id_truck'] . "'";
		}

		if (!empty($data['filter_id_branch'])) {
			$sql .= " AND tsi.id_branch = '" . (int)$data['filter_id_branch'] . "'";
		}

		if (!empty($data['filter_id_store_item'])) {
			$sql .= " AND tsi.id_store_item = '" . (int)$data['filter_id_store_item'] . "'";
		}

		if (!empty($data['filter_fromdate'])  && !empty($data['filter_todate'])) {
			$sql .= " AND (tsi.dateattached >= '" . $data['filter_fromdate'] . "' and tsi.dateattached <= '" . $data['filter_todate'] . "')";
		}

		/*if (!empty($data['filter_id_truck'])) {
			$sql .= " AND id_truck LIKE '" . (int)$data['filter_vendorname'] . "'";
		}*/

		return $sql;
	}

	public function getTotalItems($data = array()) {
		//$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." where ".$this->pKey."!=0";
		$sql="SELECT COUNT(*) AS total from ".$this->mTable." tsi left join  ".DB_PREFIX."branch b on b.id_branch=tsi.id_branch left join ".DB_PREFIX."truck t  on t.id_truck=tsi.id_truck left join ".DB_PREFIX."store_item si on tsi.id_store_item=si.id_store_item where tsi.".$this->pKey."!=0";

		
		$sql=$this->getFilterSql($data,$sql);
		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}