<?php
class ModelSettingsOtherpayment extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'other_payment';
		$this->pKey='id_other_payment';
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
		$sql="SELECT * from ".$this->mTable." where ".$this->pKey." = '" . (int)$id . "'";
		//$sql = "SELECT b.branchcode,b.branchcity,b.isheadoffice,trp.*,tr.transporter,tr.transportercode,tr.transportercontactperson,tr.transportercontactmobile  FROM `" . $this->mTable . "` trp left join ".DB_PREFIX."transporter tr on trp.id_transporter=tr.id_transporter left join ".DB_PREFIX."branch b on trp.id_branch=b.id_branch where  trp.".$this->pKey."='" . (int)$id . "'";
		$query = $this->db->query($sql);

		return $query->row;
	}

	public function getItems($data = array()) {
		
		//$sql = "SELECT * FROM `" . $this->mTable . "` where ".$this->pKey."!=0";
		$sql = "SELECT b.branchcode,b.branchcity,b.isheadoffice,op.* FROM `" . $this->mTable . "` op left join ".DB_PREFIX."branch b on op.id_branch=b.id_branch where  op.".$this->pKey."!=0";
		
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

	public function getItemsTrans($data = array()) {
		$sql1="";
		$sql2="";
		$sql3="";
		$sql4="";
		$sql5="";
		$sql6="";
		$sql7="";

		if($data['filter_id_branch']!=""){
			$sql1=" and t.driver_id_branch=".(int)$data['filter_id_branch'];
			$sql2=" and t.transporter_id_branch=".(int)$data['filter_id_branch'];
			$sql3=" and fph.id_branch=".(int)$data['filter_id_branch'];
			$sql4=" and fsp.id_branch=".(int)$data['filter_id_branch'];
			$sql5=" and tp.id_branch=".(int)$data['filter_id_branch'];
			$sql6=" and tp.id_branch=".(int)$data['filter_id_branch'];
			$sql7=" and svp.id_branch_payment=".(int)$data['filter_id_branch'];
		}

		$sql="select * from ((select 'Dr' as transtype,concat('Advance given to driver ',t.drivername,' for trip #',t.id_trip) as particulars,concat('Pay Mode: ',t.driver_paymentmode,' Pay ref: ', t.driver_paymentref) as narration ,t.driver_id_branch as id_branch,t.transactiondate as transdate,t.driveradvance as amount from ".DB_PREFIX."trip t where t.transactiondate>='".$data['filter_fromdate']."' and t.transactiondate<='".$data['filter_todate']."' and t.driveradvance!=0 ".$sql1.")
		union all
		(select 'Cr' as transtype,concat('Advance paid by ',t.transporter,' for trip #',t.id_trip) as particulars,concat('Pay Mode: ',t.transporter_paymentmode,' Pay ref: ', t.transporter_paymentref) as narration ,t.transporter_id_branch as id_branch,t.transactiondate as transdate,t.transporteradvance as amount  from ".DB_PREFIX."trip t where t.transactiondate>='".$data['filter_fromdate']."' and t.transactiondate<='".$data['filter_todate']."' and  t.transporteradvance!=0 ".$sql2.") 
		union all
		(select  'Cr' as transtype,concat('Payment Made by factory  for ID #',fph.id_factory_payment) as particulars,concat('Pay Mode: ',fph.paymentmode,' Pay ref: ', fph.paymentref) as narration ,fph.id_branch,fph.datereceived as transdate,fph.amount from ".DB_PREFIX."factory_payment_history fph where fph.datereceived >='".$data['filter_fromdate']."' and fph.datereceived <='".$data['filter_todate']."'".$sql3.")
		union all
		(select 'Dr' as transtype,concat('Payment Made to Fuel Station  for ID #',fsp.id_fuel_station_payment) as particulars,concat('Pay Mode: ',fsp.paymentmode,' Pay ref: ', fsp.paymentref) as narration ,fsp.id_branch,fsp.paidon as transdate,fsp.amount from ".DB_PREFIX."fuel_station_payment fsp where fsp.paidon>='".$data['filter_fromdate']."' and  fsp.paidon<='".$data['filter_todate']."'".$sql4.")
		union all
		(select 'Cr' as transtype,concat('Payment Made by Transporter  for ID #',tp.	id_transporter_payment) as particulars,concat('Pay Mode: ',tp.paymentmode,' Pay ref: ', tp.paymentref) as narration ,tp.id_branch,tp.datereceived as transdate,tp.totalreceivableamount as amount from ".DB_PREFIX."transporter_payment tp where tp.datereceived>='".$data['filter_fromdate']."' and  tp.datereceived<='".$data['filter_todate']."'".$sql5.")
		union all
		(select 'Dr' as transtype,concat('Payment Made to Out Truck  for ID #',tp.	id_truck_payment) as particulars,concat('Pay Mode: ',tp.paymentmode,' Pay ref: ', tp.paymentref) as narration ,tp.id_branch,tp.paidon as transdate,tp.totalpayableamount as amount from ".DB_PREFIX."truck_payment tp where tp.paidon>='".$data['filter_fromdate']."' and  tp.paidon<='".$data['filter_todate']."'".$sql6.")
		union all
		(select 'Dr' as transtype,concat('Payment Made to Store  for ID #',svp.	id_store_vendor_payment) as particulars,concat('Pay Mode: ',svp.paymentmode,' Pay ref: ', svp.paymentreference,' ',svp.comment) as narration ,svp.id_branch_payment as id_branch,svp.datepurchased as transdate,svp.amount from ".DB_PREFIX."store_vendor_payment svp where svp.datepurchased>='".$data['filter_fromdate']."' and  svp.datepurchased<='".$data['filter_todate']."'".$sql7.") ) as drtable order by transdate desc";
		
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

	public function getTotalItemsTrans($data = array()) {
		//$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." where ".$this->pKey."!=0";
		$sql="select count(*) as total from ((select t.driver_id_branch as id_branch from ".DB_PREFIX."trip t where t.transactiondate>='".$data['filter_fromdate']."' and t.transactiondate<='".$data['filter_todate']."' and t.driveradvance!=0)
		union all
		(select t.transporter_id_branch as id_branch  from ".DB_PREFIX."trip t where t.transactiondate>='".$data['filter_fromdate']."' and t.transactiondate<='".$data['filter_todate']."' and  t.transporteradvance!=0)
		union all
		(select  fph.id_branch from ".DB_PREFIX."factory_payment_history fph where fph.datereceived >='".$data['filter_fromdate']."' and fph.datereceived <='".$data['filter_todate']."')
		union all
		(select fsp.id_branch from ".DB_PREFIX."fuel_station_payment fsp where fsp.paidon>='".$data['filter_fromdate']."' and  fsp.paidon<='".$data['filter_todate']."')
		union all
		(select tp.id_branch from ".DB_PREFIX."transporter_payment tp where tp.datereceived>='".$data['filter_fromdate']."' and  tp.datereceived<='".$data['filter_todate']."')
		union all
		(select tp.id_branch from ".DB_PREFIX."truck_payment tp where tp.paidon>='".$data['filter_fromdate']."' and  tp.paidon<='".$data['filter_todate']."')
		union all
		(select svp.id_branch_payment as id_branch from ".DB_PREFIX."store_vendor_payment svp where svp.datepurchased>='".$data['filter_fromdate']."' and  svp.datepurchased<='".$data['filter_todate']."')) as drtable";

		$sql=$this->getFilterSql($data,$sql);
		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}