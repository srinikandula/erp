<?php
class ModelSettingsTrip extends Model {
	public $mTable;
	public $pKey;

	public function __construct($className=__CLASS__){
		$this->mTable=DB_PREFIX.'trip';
		$this->pKey='id_trip';
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
		
		
		$sql = "SELECT t.*,tr.rc_file,tr.pancard_file,f.paymentcycle,fp.totalreceivableamount,fp.paidamount FROM `" . $this->mTable . "` t left join ".DB_PREFIX."factory f on t.id_factory=f.id_factory left join ".DB_PREFIX."factory_payment fp on t.id_factory_payment=fp.id_factory_payment left join ".DB_PREFIX."truck tr on t.id_truck=tr.id_truck  where t.".$this->pKey."!=0";



		$sql=$this->getFilterSql($data,$sql);
		
		$sort_data = array(
			'modulename'
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

	public function getPermissionsByRole($id){
		$sql="select * from ".DB_PREFIX."admin_permission where status=1 and id_admin_role='".(int)$id."' order by modulesortorder asc,filesortorder asc";
		$query = $this->db->query($sql);
		return $query;
	}

	public function getFilterSql($data,$sql){
		//echo '<pre>';print_r($data);exit;
		if (!empty($data['filter_id_admin_role'])) {
			$sql .= " AND id_admin_role = '" . $this->db->escape($data['filter_id_admin_role']) . "'";
		}

		if (!empty($data['filter_id_factory_payment'])) {
			$sql .= " AND id_factory_payment = '" . (int)$data['filter_id_factory_payment'] . "'";
		}

		if (!empty($data['filter_id_transporter'])) {
			$sql .= " AND id_transporter = '" . (int)$data['filter_id_transporter'] . "'";
		}

		if (!empty($data['filter_id_driver'])) {
			$sql .= " AND id_driver = '" . (int)$data['filter_id_driver'] . "'";
		}

		if (!empty($data['filter_id_factory'])) {
			$sql .= " AND f.id_factory = '" . (int)$data['filter_id_factory'] . "'";
		}

		if (!empty($data['filter_factory_os'])) {
			$sql .= " AND t.id_factory!=0 and 	t.id_factory_payment=0 and DATE_ADD(t.transactiondate,INTERVAL f.paymentcycle DAY)<'".date('Y-m-d')."' ";
		}

		if (!empty($data['filter_id_transporter_payment'])) {
			$sql .= " AND id_transporter_payment = '" . (int)$data['filter_id_transporter_payment'] . "'";
		}

		if (!empty($data['filter_loadprovider'])) {
			$sql .= " AND loadprovider = '" . $data['filter_loadprovider'] . "'";
		}

		if (!empty($data['filter_id_truck'])) {
			$sql .= " AND t.id_truck = '" . (int)$data['filter_id_truck'] . "'";
		}

		if (isset($data['filter_multiple_id_truck']) && is_array($data['filter_multiple_id_truck']) && count($data['filter_multiple_id_truck'])) {
			//echo '<pre>';print_r($data['filter_multiple_id_truck']);exit;
			$multipleTruck=implode(",",$data['filter_multiple_id_truck']);
			$sql .= " AND t.id_truck in (".$multipleTruck.")";
		}

		if (isset($data['filter_trbillraised']) && $data['filter_trbillraised']!="") {
			
			$sql .= $data['filter_trbillraised']==0?" AND 	id_transporter_payment = 0":" AND 	id_transporter_payment != 0";
		}

		if (!empty($data['filter_ftbillraised'])) {
			
			$sql .= $data['filter_ftbillraised']==0?" AND 	id_factory_payment = 0":" AND 	id_factory_payment != 0";
		}
		
		if (isset($data['filter_own']) && $data['filter_own']!="") {
			//echo "<pre>";print_r($data);echo "</pre>";
			$sql .= " AND t.own = '" . (int)$data['filter_own'] . "'";
			
		}

		if (!empty($data['filter_ispodsubmitted'])) {
			$sql .= " AND ispodsubmitted = '" . (int)$data['filter_ispodsubmitted'] . "'";
		}

		if (!empty($data['filter_ispodreceived'])) {
			$sql .= " AND ispodreceived = '" . (int)$data['filter_ispodreceived'] . "'";
		}

		if (!empty($data['filter_fromdate']) && !empty($data['filter_todate'])) {
			$sql .= " AND date(transactiondate) >= '" . $data['filter_fromdate'] . "' and  date(transactiondate) <= '" . $data['filter_todate'] . "'";
		}

		return $sql;
	}

	public function getTotalItems($data = array()) {
		//$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." where ".$this->pKey."!=0";
		$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." t left join ".DB_PREFIX."factory f on t.id_factory=f.id_factory where t.".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		//exit($sql);
		$query = $this->db->query($sql);
		return $query->row['total'];
	}


	public function getTripsByDriverID($data = array()) {
		
		$sql = "SELECT 	(select tt.batta from erp_truck_type tt,erp_truck tr where tt.id_truck_type=tr.id_truck_type and tr.id_truck=tp.id_truck) as batta,date(tp.transactiondate) as transactiondate,tp.id_operating_route,tp.id_trip,tp.driveradvance,tp.material,tp.dispatchdate,tp.unloadingdate,tp.truckno,tp.operatingroutecode,tp.fromplace,tp.toplace,tp.freight,tp.billrate,tp.truckrate,tp.qty,tp.bags,tp.loadprovider,tp.transporter,tp.factorycode,tp.tollexp,tp.repairexp,tp.loadingexp,tp.unloadingexp,tp.policeexp,tp.dieselexp,tp.otherexp,tp.parkingexp,tp.tappalexp,tp.assocfeesexp,tp.teleexp,tp.qtyatunloading,tp.bagsatunloading,tp.shortage,tp.damage,tp.oilshortage,tp.ispodreceived,tp.ispodsubmitted FROM `" . $this->mTable . "` tp where tp.id_driver='".(int)$data['id_driver']."' and date(tp.transactiondate)>='".$data['datefrom']."' and  date(tp.transactiondate)<='".$data['dateto']."' order by tp.transactiondate desc";
		
		return $this->db->query($sql);
	}

	public function getTripsByFactoryID($data = array()) {
		
		//$sql = "SELECT 	id_operating_route,id_trip,material,dispatchdate,unloadingdate,truckno,operatingroutecode,fromplace,toplace,freight,billrate,truckrate,qty,bags,loadprovider,transporter,factorycode,tollexp,repairexp,loadingexp,unloadingexp,policeexp,dieselexp,qtyatunloading,bagsatunloading,shortage,damage,oilshortage,ispodreceived,ispodsubmitted FROM `" . $this->mTable . "` where id_factory='".(int)$data['id_factory']."' and date(transactiondate)>='".$data['datefrom']."' and  date(transactiondate)<='".$data['dateto']."'";

		$sql = "SELECT 	fr.tollcharge,fr.loadingcharge,fr.unloadingcharge,t.id_operating_route,t.wait_charges,t.ext_unload_charges,t.id_trip,t.material,t.dispatchdate,t.unloadingdate,t.truckno,t.operatingroutecode,t.fromplace,t.toplace,t.freight,t.billrate,t.truckrate,t.qty,t.bags,t.loadprovider,t.transporter,t.factorycode,t.tollexp,t.repairexp,t.loadingexp,t.unloadingexp,t.policeexp,t.dieselexp,t.qtyatunloading,t.bagsatunloading,t.shortage,t.damage,t.oilshortage,t.ispodreceived,t.ispodsubmitted FROM `" . $this->mTable . "` t left join `" . DB_PREFIX . "factory_rate` fr on t.id_factory_rate=fr.id_factory_rate where t.id_factory='".(int)$data['id_factory']."' and date(t.transactiondate)>='".$data['datefrom']."' and  date(t.transactiondate)<='".$data['dateto']."' and t.id_factory_payment=0";
		
		return $this->db->query($sql);
	}

	public function getTripsByFactoryPaymentID($data = array()) {
		
		$sql = "SELECT 	fr.tollcharge,fr.loadingcharge,fr.unloadingcharge,t.wait_charges,t.ext_unload_charges,t.id_operating_route,t.id_trip,t.material,t.dispatchdate,t.unloadingdate,t.truckno,t.operatingroutecode,t.fromplace,t.toplace,t.freight,t.billrate,t.truckrate,t.qty,t.bags,t.loadprovider,t.transporter,t.factorycode,t.tollexp,t.repairexp,t.loadingexp,t.unloadingexp,t.policeexp,t.dieselexp,t.qtyatunloading,t.bagsatunloading,t.shortage,t.damage,t.oilshortage,t.ispodreceived,t.ispodsubmitted FROM `" . $this->mTable . "` t left join `" . DB_PREFIX . "factory_rate` fr on t.id_factory_rate=fr.id_factory_rate where  t.id_factory_payment='".(int)$data['id_factory_payment']."'";
		
		return $this->db->query($sql);
	}

	public function getTripsByTruckPaymentID($id) {
		$query = $this->db->query("SELECT * from ".$this->mTable." where id_truck_payment='" . (int)$id . "'");
		return $query->rows;
	}

	public function getTripsByTransporterPaymentID($id) {
		$query = $this->db->query("SELECT * from ".$this->mTable." where id_transporter_payment='" . (int)$id . "'");
		return $query->rows;
	}

	public function getTripsByFuelPaymentID($id) {
		$query = $this->db->query("SELECT t.id_trip,t.truckno,t.operatingroutecode,t.transactiondate,t.dispatchdate,t.drivername,t.drivermobile,tfs.qty,tfs.priceperltr from ".$this->mTable." t inner join " . DB_PREFIX . "trip_fuel_station tfs on t.id_trip=tfs.id_trip  and tfs.id_fuel_station_payment='" . (int)$id . "'");
		return $query->rows;
	}

	public function updateTripFactoryPayment($id,$trips){
		$this->db->query("update " . $this->mTable . " set id_factory_payment=0 where id_factory_payment='".(int)$id."'");
		foreach($trips  as $k=>$trip){
                $json_tp=json_decode($trip);
				$this->db->query("update " . $this->mTable . " set id_factory_payment='".(int)$id."' where id_trip='".(int)$json_tp->id_trip."'");
            }
	}

	public function getItemsByTripDiesel($data = array()) {
		
		
		$sql = "SELECT t.*,tfs.fuelstationname,tfs.qty as fuelqty,tfs.priceperltr,tfs.amount,fs.fuelstationname as regfuelstation FROM `" . $this->mTable . "` t inner join ".DB_PREFIX."trip_fuel_station tfs on t.id_trip=tfs.id_trip left join ".DB_PREFIX."fuel_station fs on tfs.id_fuel_station=fs.id_fuel_station  where t.".$this->pKey."!=0";



		$sql=$this->getFilterSql($data,$sql);
		
		$sort_data = array(
			'modulename'
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

	public function getTotalItemsByTripDiesel($data = array()) {
		//$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." where ".$this->pKey."!=0";
		$sql="SELECT COUNT(*) AS total FROM ".$this->mTable." t inner join ".DB_PREFIX."trip_fuel_station tfs on t.id_trip=tfs.id_trip where t.".$this->pKey."!=0";
		
		$sql=$this->getFilterSql($data,$sql);
		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getItemsByTripMaintenance($data = array()) {
		$str1="";
		$str2="";
		if(isset($data['filter_id_truck']) && is_array($data['filter_id_truck'])){
			$str1=" and t.id_truck in (".implode(',',$data['filter_id_truck']).")";
			$str2=" and tsi.id_truck in (".implode(',',$data['filter_id_truck']).")";
		}
		
		if(isset($data['filter_fromdate']) && isset($data['filter_todate'])  && $data['filter_fromdate']!="" && $data['filter_todate']!=""){
			$str1.=" and t.transactiondate>='".$data['filter_fromdate']."' and t.transactiondate<='".$data['filter_todate']."'";
			$str2.=" and tsi.dateattached>='".$data['filter_fromdate']."' and tsi.dateattached<='".$data['filter_todate']."'";
		}
		
		
		$sql="SELECT * FROM ((select concat(repairexpcomment,' For TripID# ',id_trip) as description,truckno,repairexp as price,transactiondate as dateon from ".DB_PREFIX."trip where own=1 and repairexp!=0 ".$str1.") union all (select concat(si.itemname,' refNo: ',tsi.refno) as description ,t.truckno,tsi.price,dateattached as dateon from ".DB_PREFIX."truck_store_item tsi left join ".DB_PREFIX."truck t on t.id_truck=tsi.id_truck left join ".DB_PREFIX."store_item si on tsi.id_store_item=si.id_store_item where tsi.id_truck_store_item!=0  ".$str2.")) as dtable order by dateon desc";
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
		$query = $this->db->query($sql);
		return $query;
	}

	public function getTotalItemsByTripMaintenance($data = array()) {
		
		$str1="";
		$str2="";
		if(isset($data['filter_id_truck']) && is_array($data['filter_id_truck'])){
			$str1=" and t.id_truck in (".implode(',',$data['filter_id_truck']).")";
			$str2=" and tsi.id_truck in (".implode(',',$data['filter_id_truck']).")";
		}
		
		if(isset($data['filter_fromdate']) && isset($data['filter_todate'])  && $data['filter_fromdate']!="" && $data['filter_todate']!=""){
			$str1.=" and t.transactiondate>='".$data['filter_fromdate']."' and t.transactiondate<='".$data['filter_todate']."'";
			$str2.=" and tsi.dateattached>='".$data['filter_fromdate']."' and tsi.dateattached<='".$data['filter_todate']."'";
		}
		
		
		$sql="SELECT count(*) as total FROM ((select transactiondate as dateon from ".DB_PREFIX."trip where own=1 and repairexp!=0 ".$str1.") union all (select dateattached as dateon from ".DB_PREFIX."truck_store_item tsi left join ".DB_PREFIX."truck t on t.id_truck=tsi.id_truck where tsi.id_truck_store_item!=0  ".$str2.")) as dtable";
		

		$query = $this->db->query($sql);

		return $query->row['total'];
	}
}