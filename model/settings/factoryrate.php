<?php
class ModelSettingsFactoryrate extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'factory_rate';
		$this->pKey='id_factory_rate';
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

	public function deleteByFactoryId($id) {
		$this->db->query("DELETE FROM ".$this->mTable." WHERE id_factory = '" . (int)$id . "'");
	}

	public function getItem($id) {
		$query = $this->db->query("SELECT * from ".$this->mTable." where ".$this->pKey." = '" . (int)$id . "'");

		return $query->row;
	}

	public function getItems($data = array()) {
		
		$sql = "SELECT * FROM `" . $this->mTable . "` where ".$this->pKey."!=0";
		
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
		
		if (!empty($data['filter_id_factory'])) {
			$sql .= " AND id_factory = '" . $this->db->escape($data['filter_id_factory']) . "'";
		}


		return $sql;
	}

	public function getTotalItems($data = array()) {
		$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." where ".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		$query = $this->db->query($sql);

		return $query->row['total'];
	}
	
	public function getFactoryRatesById($id_factory){
		//$sql="select or.id_op,or.operatingroutecode,or.from,or.to,or.distance,or.tollcharge,or.nooftollgates from ".DB_PREFIX."factory_rate fr,".DB_PREFIX."material mt,".DB_PREFIX."operating_route or where fr.id_factory='".$id_factory."' and fr.id_material=mt.id_material and or.id_operating_route=fr.id_operating_route";
		$sql="";
		$query = $this->db->query($sql);
		return $query->rows;
	}

	public function getFactoryRatesByFactory(){
		//$sql="select from ".DB_PREFIX."factory_rate fr,".DB_PREFIX."factory_party fp,".DB_PREFIX."material m,".DB_PREFIX."operating_route or where fr.id_material=m.id_material and fr.id_operating_route=or.id_operating_route  and fr.id_factory_party=fp.id_factory_party";

		//$sql="select fr.*,m.materialcode,m.material,or.operatingroutecode,or.fromplace,or.toplace,or.distance,or.tollcharge,or.nooftollgates,fp.partyname,fp.partycode,fp.contactname,fp.contactmobile  from ".DB_PREFIX."factory_rate fr left join ".DB_PREFIX."factory_party fp on fr.id_factory_party=fp.id_factory_party	left join ".DB_PREFIX."material m on fr.id_material=m.id_material left join ".DB_PREFIX."operating_route `or`  on fr.id_operating_route=or.id_operating_route";

		$sql="select fr.*,or.operatingroutecode,or.fromplace,or.toplace,or.distance,or.tollcharge,or.nooftollgates,fp.partyname,fp.partycode,fp.contactname,fp.contactmobile  from ".DB_PREFIX."factory_rate fr left join ".DB_PREFIX."factory_party fp on fr.id_factory_party=fp.id_factory_party	 left join ".DB_PREFIX."operating_route `or`  on fr.id_operating_route=or.id_operating_route";

		//echo $sql;exit;
		$query = $this->db->query($sql);
		return $query;
	}
	
}