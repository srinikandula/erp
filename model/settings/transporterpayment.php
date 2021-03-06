<?php
class ModelSettingsTransporterpayment extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'transporter_payment';
		$this->pKey='id_transporter_payment';
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
		//$sql="SELECT * from ".$this->mTable." where ".$this->pKey." = '" . (int)$id . "'"
		$sql = "SELECT b.branchcode,b.branchcity,b.isheadoffice,trp.*,tr.transporter,tr.transportercode,tr.transportercontactperson,tr.transportercontactmobile  FROM `" . $this->mTable . "` trp left join ".DB_PREFIX."transporter tr on trp.id_transporter=tr.id_transporter left join ".DB_PREFIX."branch b on trp.id_branch=b.id_branch where  trp.".$this->pKey."='" . (int)$id . "'";
		$query = $this->db->query($sql);

		return $query->row;
	}

	public function getItems($data = array()) {
		
		//$sql = "SELECT * FROM `" . $this->mTable . "` where ".$this->pKey."!=0";
		$sql = "SELECT b.branchcode,b.branchcity,b.isheadoffice,trp.*,tr.transportercode,tr.transporter,tr.transportercontactperson,tr.transportercontactmobile,tr.city,tr.address FROM `" . $this->mTable . "` trp left join ".DB_PREFIX."transporter tr on trp.id_transporter=tr.id_transporter left join ".DB_PREFIX."branch b on trp.id_branch=b.id_branch where  trp.".$this->pKey."!=0";
		
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
		
		if (!empty($data['filter_id_trip'])) {
			$sql .= " AND id_trip = '" . (int)$data['filter_id_trip'] . "'";
		}
		
		if (!empty($data['filter_id_transporter'])) {
			$sql .= " AND id_transporter = '" . (int)$data['filter_id_transporter'] . "'";
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