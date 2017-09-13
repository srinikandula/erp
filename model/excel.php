<?php
error_reporting(0);
class ModelExcel  extends Model{

    function clean(&$str, $allowBlanks = FALSE) {
        $result = "";
        $n = strlen($str);
        for ($m = 0; $m < $n; $m++) {
            $ch = substr($str, $m, 1);
            if (($ch == " ") && (!$allowBlanks) || ($ch == "\n") || ($ch == "\r") || ($ch == "\t") || ($ch == "\0") || ($ch == "\x0B")) {
                continue;
            }
            $result .= $ch;
        }
        return $result;
    }

    function import(&$database, $sql) {
        foreach (explode(";\n", $sql) as $sql) {
            $sql = trim($sql);
            if ($sql) {
                //$this->db->query($sql);
                $this->db->query($sql);
            }
        }
    }

    protected function detect_encoding($str) {
        // auto detect the character encoding of a string
        return mb_detect_encoding($str, 'UTF-8,ISO-8859-15,ISO-8859-1,cp1251,KOI8-R');
    }
   
    function getCell(&$worksheet, $row, $col, $default_val = '') {
        $col -= 1; // we use 1-based, PHPExcel uses 0-based column index
        $row += 1; // we use 0-based, PHPExcel used 1-based row index
        return ($worksheet->cellExistsByColumnAndRow($col, $row)) ? $worksheet->getCellByColumnAndRow($col, $row)->getValue() : $default_val;
    }

    function validateHeading(&$data, &$expected) {
        $heading = array();
        $k = PHPExcel_Cell::columnIndexFromString($data->getHighestColumn());
        if ($k != count($expected)) {
            return FALSE;
        }
        $i = 0;
        for ($j = 1; $j <= $k; $j+=1) {
            $heading[] = $this->getCell($data, $i, $j);
        }
        $valid = TRUE;
        for ($i = 0; $i < count($expected); $i+=1) {
            if (!isset($heading[$i])) {
                $valid = FALSE;
                break;
            }
            if (strtolower($heading[$i]) != strtolower($expected[$i])) {
                $valid = FALSE;
                break;
            }
        }

		
        return $valid;
    }

    
 

    function excelDateToDate($readDate) {
        $phpexcepDate = $readDate - 25569; //to offset to Unix epoch
        return strtotime("+$phpexcepDate days", mktime(0, 0, 0, 1, 1, 1970));
    }

     
    protected function clearSpreadsheetCache() {
        $files = glob($_SERVER['DOCUMENT_ROOT'] . "/cache" . 'Spreadsheet_Excel_Writer' . '*');
        //$files = glob('C://xampp/htdocs/standalone' . "/cache" . 'Spreadsheet_Excel_Writer' . '*');
        
        if ($files) {
            foreach ($files as $file) {
                if (file_exists($file)) {
                    @unlink($file);
                    clearstatcache();
                }
            }
        }
    }

    public function downloadTruckExpiry($rows) {
		ob_end_clean();
		//exit("value of ".DIR_SYSTEM);
	 // We use the package from http://pear.php.net/package/Spreadsheet_Excel_Writer/
        chdir(DIR_SYSTEM."library/excel/pear/");
		//exit(DIR_SYSTEM."library/pear");
		require_once "Spreadsheet/Excel/Writer.php";
        chdir(DIR_SYSTEM."library/excel");
        //exit($_SERVER['DOCUMENT_ROOT']);
        // Creating a workbook
        $workbook = new Spreadsheet_Excel_Writer();
        $workbook->setTempDir(DIR_CACHE);
        $workbook->setVersion(8); // Use Excel97/2000 Format
        $priceFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '######0.00'));
        $boxFormat = & $workbook->addFormat(array('Size' => 10, 'vAlign' => 'vequal_space'));
        $weightFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '##0.00'));
        $textFormat = & $workbook->addFormat(array('Size' => 10, 'NumFormat' => "@"));
        // sending HTTP headers
        $workbook->send('truck_expiry_'.date("Y-m-d h:i:s").'.xls');
        // Creating the Truck Details worksheet
        $expDays=strtotime(date('Y-m-d', strtotime(date('Y-m-d') . ' -5 day')));

		$worksheet = & $workbook->addWorksheet('Fitness');
        $worksheet->setInputEncoding('UTF-8');
        $this->populateWorksheet($expDays,'fitnessexpdate',$rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
        $worksheet->freezePanes(array(1, 1, 1, 1));

		$worksheet = & $workbook->addWorksheet('Insurance');
        $worksheet->setInputEncoding('UTF-8');
        $this->populateWorksheet($expDays,'insuranceexpdate',$rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
        $worksheet->freezePanes(array(1, 1, 1, 1));

		$worksheet = & $workbook->addWorksheet('National Permit');
        $worksheet->setInputEncoding('UTF-8');
        $this->populateWorksheet($expDays,'nationalpermitexpdate',$rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
        $worksheet->freezePanes(array(1, 1, 1, 1));

		$worksheet = & $workbook->addWorksheet('Pollution');
        $worksheet->setInputEncoding('UTF-8');
        $this->populateWorksheet($expDays,'pollutionexpdate',$rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
        $worksheet->freezePanes(array(1, 1, 1, 1));

		$worksheet = & $workbook->addWorksheet('Tax Payable');
        $worksheet->setInputEncoding('UTF-8');
        $this->populateWorksheet($expDays,'taxpayabledate',$rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
        $worksheet->freezePanes(array(1, 1, 1, 1));

		$worksheet = & $workbook->addWorksheet('Hub Service');
        $worksheet->setInputEncoding('UTF-8');
        $this->populateWorksheet($expDays,'hubservicedate',$rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
        $worksheet->freezePanes(array(1, 1, 1, 1));

		$worksheet = & $workbook->addWorksheet('Date In Service');
        $worksheet->setInputEncoding('UTF-8');
        $this->populateWorksheet($expDays,'dateinservice',$rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
        $worksheet->freezePanes(array(1, 1, 1, 1));


        
       // Let's send the file

        $workbook->close();

        // Clear the spreadsheet caches
        $this->clearSpreadsheetCache();
        exit;
		
    }

	function populateWorksheet($expDays,$type,$rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
        // Set the column widths
        $j = 0;
        $worksheet->setColumn($j, $j++, strlen('Truck No') + 20);
		$worksheet->setColumn($j, $j++, strlen('Expiry Date') + 20);
		//$worksheet->setColumn($j, $j++, strlen('Mobile') + 20);
		
 
        // The heading row
        $i = 0;
        $j = 0;
        $worksheet->writeString($i, $j++, 'Truck No', $boxFormat);
        $worksheet->writeString($i, $j++, 'Expiry Date', $boxFormat);
        //$worksheet->writeString($i, $j++, 'Mobile', $boxFormat);
       

        $worksheet->setRow($i, 30, $boxFormat);

        // The actual product specials data
        $i += 1;
        $j = 0;
	    //$result_rows=Yii::app()->db->createCommand("select * from wn_subscribe order by dateCreated desc")->QueryAll();
        /*$result_rows[]=array('name'=>'suresh','email'=>'email@gmail.com','mobile'=>'9966332255');
		$result_rows[]=array('name'=>'suresh','email'=>'email@gmail.com','mobile'=>'9966332255');*/
		foreach ($rows as $row) {
			if(strtotime($row[$type])<$expDays){
				$worksheet->setRow($i, 13);
				$worksheet->write($i, $j++, $row['truckno'], $textFormat);
				$worksheet->write($i, $j++, $row[$type], $textFormat);
				//$worksheet->write($i, $j++, $row['mobile'], $textFormat);
				$i += 1;
				$j = 0;
			}	
        }
    }
    
    public function downloadTruckReport($type,$rows) {
	ob_end_clean();
	//exit("value of ".DIR_SYSTEM);
 // We use the package from http://pear.php.net/package/Spreadsheet_Excel_Writer/
	chdir(DIR_SYSTEM."library/excel/pear/");
	//exit(DIR_SYSTEM."library/pear");
	require_once "Spreadsheet/Excel/Writer.php";
	chdir(DIR_SYSTEM."library/excel");
	//exit($_SERVER['DOCUMENT_ROOT']);
	// Creating a workbook
	$workbook = new Spreadsheet_Excel_Writer();
	$workbook->setTempDir(DIR_CACHE);
	$workbook->setVersion(8); // Use Excel97/2000 Format
	$priceFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '######0.00'));
	$boxFormat = & $workbook->addFormat(array('Size' => 10, 'vAlign' => 'vequal_space'));
	$weightFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '##0.00'));
	$textFormat = & $workbook->addFormat(array('Size' => 10, 'NumFormat' => "@"));
	// sending HTTP headers
	$workbook->send('truck_report_'.date("Y-m-d h:i:s").'.xls');
	// Creating the Truck Details worksheet
	if($type=='T'){
		$worksheet = & $workbook->addWorksheet('Trips');
		$worksheet->setInputEncoding('UTF-8');
		$this->populateTruckReportTripWorksheet($rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
		$worksheet->freezePanes(array(1, 1, 1, 1));
	}else if($type=='D'){
		$worksheet = & $workbook->addWorksheet('Diesel');
		$worksheet->setInputEncoding('UTF-8');
		$this->populateTruckReportDieselWorksheet($rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
		$worksheet->freezePanes(array(1, 1, 1, 1));
	}else if($type=='M'){
		$worksheet = & $workbook->addWorksheet('Maintenance');
		$worksheet->setInputEncoding('UTF-8');
		$this->populateTruckReportMaintenanceWorksheet($rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
		$worksheet->freezePanes(array(1, 1, 1, 1));
	}
	$workbook->close();
	// Clear the spreadsheet caches
	$this->clearSpreadsheetCache();
	exit;
}

function populateTruckReportTripWorksheet($rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
	// Set the column widths
	$j = 0;
	$worksheet->setColumn($j, $j++, strlen('Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Truck No') + 20);
	$worksheet->setColumn($j, $j++, strlen('Trip ID') + 20);
	$worksheet->setColumn($j, $j++, strlen('Load Provider') + 20);
	$worksheet->setColumn($j, $j++, strlen('Company') + 20);
	$worksheet->setColumn($j, $j++, strlen('Route') + 20);
	$worksheet->setColumn($j, $j++, strlen('Driver') + 20);
	$worksheet->setColumn($j, $j++, strlen('Freight') + 20);
	$worksheet->setColumn($j, $j++, strlen('Diesel') + 20);
	$worksheet->setColumn($j, $j++, strlen('Repairs') + 20);
	$worksheet->setColumn($j, $j++, strlen('Repairs Comment') + 20);
	

	// The heading row
	$i = 0;
	$j = 0;
	$worksheet->writeString($i, $j++, 'Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Truck No', $boxFormat);
	$worksheet->writeString($i, $j++, 'Trip ID', $boxFormat);
        $worksheet->writeString($i, $j++, 'Load Provider', $boxFormat);
        $worksheet->writeString($i, $j++, 'Company', $boxFormat);
        $worksheet->writeString($i, $j++, 'Route', $boxFormat);
        $worksheet->writeString($i, $j++, 'Driver', $boxFormat);
        $worksheet->writeString($i, $j++, 'Freight', $boxFormat);
        $worksheet->writeString($i, $j++, 'Diesel', $boxFormat);
        $worksheet->writeString($i, $j++, 'Repairs', $boxFormat);
        $worksheet->writeString($i, $j++, 'Repairs Comment', $boxFormat);
   

	$worksheet->setRow($i, 30, $boxFormat);

	// The actual product specials data
	$i += 1;
	$j = 0;

	foreach ($rows as $row) {
            $worksheet->setRow($i, 13);
            $worksheet->write($i, $j++, date(FORMAT_DATETIME_FORMAT, strtotime($row['transactiondate'])), $textFormat);
            $worksheet->write($i, $j++, $row['truckno'], $textFormat);
            $worksheet->write($i, $j++, $row['id_trip'], $textFormat);
            $worksheet->write($i, $j++, $row['loadprovider']=='TR'?'Transporter':'Factory', $textFormat);
            $worksheet->write($i, $j++, $row['loadprovider']=='TR'?$row['transporter']:$row['factoryname'], $textFormat);
            $worksheet->write($i, $j++, $row['operatingroutecode'], $textFormat);
            $worksheet->write($i, $j++, $row['drivername'].'/'.$row['drivermobile'], $textFormat);
            $worksheet->write($i, $j++, $row['loadprovider']=='TR'?$row['qty']*$row['truckrate']:$row['qty']*$row['billrate'], $textFormat);
            $worksheet->write($i, $j++, $row['dieselexp'], $textFormat);
            $worksheet->write($i, $j++, $row['repairexp'], $textFormat);
            $worksheet->write($i, $j++, $row['repairexpcomment'], $textFormat);
            $i += 1;
            $j = 0;
	}
}

	function populateTruckReportDieselWorksheet($rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
	// Set the column widths
	$j = 0;
	$worksheet->setColumn($j, $j++, strlen('Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Truck No') + 20);
	$worksheet->setColumn($j, $j++, strlen('Trip ID') + 20);
	$worksheet->setColumn($j, $j++, strlen('Load Provider') + 20);
	$worksheet->setColumn($j, $j++, strlen('Company') + 20);
	$worksheet->setColumn($j, $j++, strlen('Route') + 20);
	$worksheet->setColumn($j, $j++, strlen('Driver') + 20);
	$worksheet->setColumn($j, $j++, strlen('Freight') + 20);
	$worksheet->setColumn($j, $j++, strlen('Fuel Station') + 20);
	$worksheet->setColumn($j, $j++, strlen('Diesel Qty') + 20);
	$worksheet->setColumn($j, $j++, strlen('Price Per Ltr') + 20);
	$worksheet->setColumn($j, $j++, strlen('Amount') + 20);
	

	// The heading row
	$i = 0;
	$j = 0;
	$worksheet->writeString($i, $j++, 'Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Truck No', $boxFormat);
	$worksheet->writeString($i, $j++, 'Trip ID', $boxFormat);
        $worksheet->writeString($i, $j++, 'Load Provider', $boxFormat);
        $worksheet->writeString($i, $j++, 'Company', $boxFormat);
        $worksheet->writeString($i, $j++, 'Route', $boxFormat);
        $worksheet->writeString($i, $j++, 'Driver', $boxFormat);
        $worksheet->writeString($i, $j++, 'Freight', $boxFormat);
        $worksheet->writeString($i, $j++, 'Fuel Station', $boxFormat);
        $worksheet->writeString($i, $j++, 'Diesel Qty', $boxFormat);
        $worksheet->writeString($i, $j++, 'Price Per Ltr', $boxFormat);
        $worksheet->writeString($i, $j++, 'Amount', $boxFormat);
   

	$worksheet->setRow($i, 30, $boxFormat);

	// The actual product specials data
	$i += 1;
	$j = 0;

	foreach ($rows as $row) {
            $worksheet->setRow($i, 13);
            $worksheet->write($i, $j++, date(FORMAT_DATETIME_FORMAT, strtotime($row['transactiondate'])), $textFormat);
            $worksheet->write($i, $j++, $row['truckno'], $textFormat);
            $worksheet->write($i, $j++, $row['id_trip'], $textFormat);
            $worksheet->write($i, $j++, $row['loadprovider']=='TR'?'Transporter':'Factory', $textFormat);
            $worksheet->write($i, $j++, $row['loadprovider']=='TR'?$row['transporter']:$row['factoryname'], $textFormat);
            $worksheet->write($i, $j++, $row['operatingroutecode'], $textFormat);
            $worksheet->write($i, $j++, $row['drivername'].'/'.$row['drivermobile'], $textFormat);
            $worksheet->write($i, $j++, $row['loadprovider']=='TR'?$row['qty']*$row['truckrate']:$row['qty']*$row['billrate'], $textFormat);
            $worksheet->write($i, $j++, $row['fuelstationname']==""?$row['regfuelstation']:$row['fuelstationname'], $textFormat);
            $worksheet->write($i, $j++, $row['fuelqty'], $textFormat);
            $worksheet->write($i, $j++, $row['priceperltr'], $textFormat);
            $worksheet->write($i, $j++, $row['amount'], $textFormat);
            $i += 1;
            $j = 0;
	}
}

	function populateTruckReportMaintenanceWorksheet($rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
	// Set the column widths
	$j = 0;
	$worksheet->setColumn($j, $j++, strlen('Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Truck No') + 20);
	$worksheet->setColumn($j, $j++, strlen('Price') + 20);
	$worksheet->setColumn($j, $j++, strlen('Description') + 20);
	
	// The heading row
	$i = 0;
	$j = 0;
	$worksheet->writeString($i, $j++, 'Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Truck No', $boxFormat);
	$worksheet->writeString($i, $j++, 'Price', $boxFormat);
        $worksheet->writeString($i, $j++, 'Description', $boxFormat);
   

	$worksheet->setRow($i, 30, $boxFormat);

	// The actual product specials data
	$i += 1;
	$j = 0;

	foreach ($rows as $row) {
            $worksheet->setRow($i, 13);
            $worksheet->write($i, $j++, date(FORMAT_DATETIME_FORMAT, strtotime($row['dateon'])), $textFormat);
            $worksheet->write($i, $j++, $row['truckno'], $textFormat);
            $worksheet->write($i, $j++, $row['price'], $textFormat);
            $worksheet->write($i, $j++, $row['description'], $textFormat);
            $i += 1;
            $j = 0;
	}
    }
    
    public function downloaddsalReport($rows) {
	ob_end_clean();
	//exit("value of ".DIR_SYSTEM);
	// We use the package from http://pear.php.net/package/Spreadsheet_Excel_Writer/
	chdir(DIR_SYSTEM."library/excel/pear/");
	//exit(DIR_SYSTEM."library/pear");
	require_once "Spreadsheet/Excel/Writer.php";
	chdir(DIR_SYSTEM."library/excel");
	//exit($_SERVER['DOCUMENT_ROOT']);
	// Creating a workbook
	$workbook = new Spreadsheet_Excel_Writer();
	$workbook->setTempDir(DIR_CACHE);
	$workbook->setVersion(8); // Use Excel97/2000 Format
	$priceFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '######0.00'));
	$boxFormat = & $workbook->addFormat(array('Size' => 10, 'vAlign' => 'vequal_space'));
	$weightFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '##0.00'));
	$textFormat = & $workbook->addFormat(array('Size' => 10, 'NumFormat' => "@"));
	// sending HTTP headers
	$workbook->send('driver_salary_report_'.date("Y-m-d h:i:s").'.xls');
	// Creating the Truck Details worksheet
	
	$worksheet = & $workbook->addWorksheet('Driver Salary');
	$worksheet->setInputEncoding('UTF-8');
	$this->populatedsalReportWorksheet($rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
	$worksheet->freezePanes(array(1, 1, 1, 1));
	$workbook->close();
	// Clear the spreadsheet caches
	$this->clearSpreadsheetCache();
	exit;
}

function populatedsalReportWorksheet($rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
	// Set the column widths
	$j = 0;
	$worksheet->setColumn($j, $j++, strlen('Settlement Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Payment Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Driver') + 20);
	$worksheet->setColumn($j, $j++, strlen('From Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('To Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Payment Branch') + 20);
	$worksheet->setColumn($j, $j++, strlen('Comment') + 20);
	$worksheet->setColumn($j, $j++, strlen('Closed') + 20);
	$worksheet->setColumn($j, $j++, strlen('Days Paid') + 20);
	$worksheet->setColumn($j, $j++, strlen('Batta') + 20);
	$worksheet->setColumn($j, $j++, strlen('Per Trip Freight Percent') + 20);
	$worksheet->setColumn($j, $j++, strlen('Per Trip Commission') + 20);
	$worksheet->setColumn($j, $j++, strlen('Fixed Pay') + 20);
	$worksheet->setColumn($j, $j++, strlen('Total Trips') + 20);
	$worksheet->setColumn($j, $j++, strlen('Total Freight') + 20);
	$worksheet->setColumn($j, $j++, strlen('Total Adv') + 20);
	$worksheet->setColumn($j, $j++, strlen('Total Trip Exp') + 20);
	$worksheet->setColumn($j, $j++, strlen('Total Shortage') + 20);
	$worksheet->setColumn($j, $j++, strlen('Total Damage') + 20);
	$worksheet->setColumn($j, $j++, strlen('Total Oil Shortage') + 20);
	$worksheet->setColumn($j, $j++, strlen('Total Amount') + 20);
	// The heading row
	$i = 0;
	$j = 0;
	$worksheet->writeString($i, $j++, 'Settlement Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Payment Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Driver', $boxFormat);
	$worksheet->writeString($i, $j++, 'From Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'To Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Payment Branch', $boxFormat);
	$worksheet->writeString($i, $j++, 'Comment', $boxFormat);
	$worksheet->writeString($i, $j++, 'Closed', $boxFormat);
	$worksheet->writeString($i, $j++, 'Days Paid', $boxFormat);
	$worksheet->writeString($i, $j++, 'Batta', $boxFormat);
	$worksheet->writeString($i, $j++, 'Per Trip Freigh Percent', $boxFormat);
	$worksheet->writeString($i, $j++, 'Per Trip Commission', $boxFormat);
	$worksheet->writeString($i, $j++, 'Fixed Pay', $boxFormat);
        $worksheet->writeString($i, $j++, 'Total Trips', $boxFormat);
	$worksheet->writeString($i, $j++, 'Total Freight', $boxFormat);
	$worksheet->writeString($i, $j++, 'Total Adv', $boxFormat);
	$worksheet->writeString($i, $j++, 'Total Trip Exp', $boxFormat);
	$worksheet->writeString($i, $j++, 'Total Shortage', $boxFormat);
	$worksheet->writeString($i, $j++, 'Total Damage', $boxFormat);
	$worksheet->writeString($i, $j++, 'Total Oil Shortage', $boxFormat);
	$worksheet->writeString($i, $j++, 'Total Amount', $boxFormat);
	$worksheet->setRow($i, 30, $boxFormat);

	// The actual product specials data
	$i += 1;
	$j = 0;

	foreach ($rows as $item) {
            $worksheet->setRow($i, 13);
            $worksheet->write($i, $j++, date(FORMAT_DATE_FORMAT, strtotime($item['settlementdate'])), $textFormat);
            $worksheet->write($i, $j++, $item['paidon']!='0000-00-00'?date(FORMAT_DATETIME_FORMAT, strtotime($item['paidon'])):'', $textFormat);
            $worksheet->write($i, $j++, $item['drivername'], $textFormat);
            $worksheet->write($i, $j++, date(FORMAT_DATE_FORMAT, strtotime($item['datefrom'])), $textFormat);
            $worksheet->write($i, $j++, date(FORMAT_DATE_FORMAT, strtotime($item['dateto'])), $textFormat);
            $worksheet->write($i, $j++, $item['branchcity'], $textFormat);
            $worksheet->write($i, $j++, $item['comment'], $textFormat);
            $worksheet->write($i, $j++, $item['closed']==1?'Yes':'No', $textFormat);
            $worksheet->write($i, $j++, $item['dayspaid'], $textFormat);
            $worksheet->write($i, $j++, $item['batta'], $textFormat);
            $worksheet->write($i, $j++, $item['pertrippercentonfreight'], $textFormat);
            $worksheet->write($i, $j++, $item['pertripcommission'], $textFormat);
            $worksheet->write($i, $j++, $item['fixedpermonth'], $textFormat);
            $worksheet->write($i, $j++, $item['totaltrips'], $textFormat);
            $worksheet->write($i, $j++, $item['totalfreight'], $textFormat);
            $worksheet->write($i, $j++, $item['totaladvance'], $textFormat);
            $worksheet->write($i, $j++, $item['totaltripexp'], $textFormat);
            $worksheet->write($i, $j++, $item['totalshortage'], $textFormat);
            $worksheet->write($i, $j++, $item['totaldamage'], $textFormat);
            $worksheet->write($i, $j++, $item['totaloilshortage'], $textFormat);
            $worksheet->write($i, $j++, $item['totalpayableamount'], $textFormat);
            $i += 1;
            $j = 0;
	}
    }
    
    public function downloadTripsReport($rows) {
	ob_end_clean();
	//exit("value of ".DIR_SYSTEM);
	// We use the package from http://pear.php.net/package/Spreadsheet_Excel_Writer/
	chdir(DIR_SYSTEM."library/excel/pear/");
	//exit(DIR_SYSTEM."library/pear");
	require_once "Spreadsheet/Excel/Writer.php";
	chdir(DIR_SYSTEM."library/excel");
	//exit($_SERVER['DOCUMENT_ROOT']);
	// Creating a workbook
	$workbook = new Spreadsheet_Excel_Writer();
	$workbook->setTempDir(DIR_CACHE);
	$workbook->setVersion(8); // Use Excel97/2000 Format
	$priceFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '######0.00'));
	$boxFormat = & $workbook->addFormat(array('Size' => 10, 'vAlign' => 'vequal_space'));
	$weightFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '##0.00'));
	$textFormat = & $workbook->addFormat(array('Size' => 10, 'NumFormat' => "@"));
	// sending HTTP headers
	$workbook->send('trips_report_'.date("Y-m-d h:i:s").'.xls');
	// Creating the Truck Details worksheet
	
	$worksheet = & $workbook->addWorksheet('Trips');
	$worksheet->setInputEncoding('UTF-8');
	$this->populatedTripsReportWorksheet($rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
	$worksheet->freezePanes(array(1, 1, 1, 1));
	$workbook->close();
	// Clear the spreadsheet caches
	$this->clearSpreadsheetCache();
	exit;
}

function populatedTripsReportWorksheet($rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
	// Set the column widths
	$j = 0;
	$worksheet->setColumn($j, $j++, strlen('Trip ID') + 20);
	$worksheet->setColumn($j, $j++, strlen('From-To') + 20);
	$worksheet->setColumn($j, $j++, strlen('OnWards') + 20);
	$worksheet->setColumn($j, $j++, strlen('Material') + 20);
	$worksheet->setColumn($j, $j++, strlen('Freight') + 20);
	$worksheet->setColumn($j, $j++, strlen('Transc Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Dispatch Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Truck No') + 20);
	$worksheet->setColumn($j, $j++, strlen('Own') + 20);
	$worksheet->setColumn($j, $j++, strlen('Booked To') + 20);
	$worksheet->setColumn($j, $j++, strlen('Company') + 20);
	$worksheet->setColumn($j, $j++, strlen('Driver') + 20);
	$worksheet->setColumn($j, $j++, strlen('Driver Adv') + 20);
	// The heading row
	$i = 0;
	$j = 0;
	$worksheet->writeString($i, $j++, 'Trip ID', $boxFormat);
	$worksheet->writeString($i, $j++, 'From-To', $boxFormat);
	$worksheet->writeString($i, $j++, 'OnWards', $boxFormat);
	$worksheet->writeString($i, $j++, 'Material', $boxFormat);
	$worksheet->writeString($i, $j++, 'Freight', $boxFormat);
	$worksheet->writeString($i, $j++, 'Transc Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Dispatch Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Truck No', $boxFormat);
	$worksheet->writeString($i, $j++, 'Own', $boxFormat);
	$worksheet->writeString($i, $j++, 'Booked To', $boxFormat);
	$worksheet->writeString($i, $j++, 'Company', $boxFormat);
	$worksheet->writeString($i, $j++, 'Driver', $boxFormat);
	$worksheet->writeString($i, $j++, 'Driver Adv', $boxFormat);
    
	$worksheet->setRow($i, 30, $boxFormat);

	// The actual product specials data
	$i += 1;
	$j = 0;

	foreach ($rows as $item) {
	    $freight=$item['loadprovider']=='TR'?$item['truckrate']*$item['qty']:$item['billrate']*$item['qty'];
            $worksheet->setRow($i, 13);
            $worksheet->write($i, $j++, $item['id_trip'], $textFormat);
            $worksheet->write($i, $j++, $item['fromplace']."-".$item['toplace'], $textFormat);
            $worksheet->write($i, $j++, $item['traveltype']==1?'Yes':'No', $textFormat);
            $worksheet->write($i, $j++, $item['material'], $textFormat);
            $worksheet->write($i, $j++, $freight, $textFormat);
            $worksheet->write($i, $j++, date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])), $textFormat);
            $worksheet->write($i, $j++, date(FORMAT_DATETIME_FORMAT, strtotime($item['dispatchdate'])), $textFormat);
            $worksheet->write($i, $j++, $item['truckno'], $textFormat);
            $worksheet->write($i, $j++, $item['own']==1?'Yes':'No', $textFormat);
            $worksheet->write($i, $j++, $item['loadprovider']=='FT'?"Factory":"Transporter", $textFormat);
            $worksheet->write($i, $j++, $item['loadprovider']=='FT'?$item['factoryname']:$item['transporter'], $textFormat);
            $worksheet->write($i, $j++, $item['drivername'], $textFormat);
            $worksheet->write($i, $j++, $item['driveradvance'], $textFormat);
            $i += 1;
            $j = 0;
	}
    }
    
    public function downloadFactorypodReport($rows) {
	ob_end_clean();
	//exit("value of ".DIR_SYSTEM);
	// We use the package from http://pear.php.net/package/Spreadsheet_Excel_Writer/
	chdir(DIR_SYSTEM."library/excel/pear/");
	//exit(DIR_SYSTEM."library/pear");
	require_once "Spreadsheet/Excel/Writer.php";
	chdir(DIR_SYSTEM."library/excel");
	//exit($_SERVER['DOCUMENT_ROOT']);
	// Creating a workbook
	$workbook = new Spreadsheet_Excel_Writer();
	$workbook->setTempDir(DIR_CACHE);
	$workbook->setVersion(8); // Use Excel97/2000 Format
	$priceFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '######0.00'));
	$boxFormat = & $workbook->addFormat(array('Size' => 10, 'vAlign' => 'vequal_space'));
	$weightFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '##0.00'));
	$textFormat = & $workbook->addFormat(array('Size' => 10, 'NumFormat' => "@"));
	// sending HTTP headers
	$workbook->send('factorybill_report_'.date("Y-m-d h:i:s").'.xls');
	// Creating the Truck Details worksheet
	
	$worksheet = & $workbook->addWorksheet('Factory Bills');
	$worksheet->setInputEncoding('UTF-8');
	$this->populatedFactorypodReportWorksheet($rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
	$worksheet->freezePanes(array(1, 1, 1, 1));
	$workbook->close();
	// Clear the spreadsheet caches
	$this->clearSpreadsheetCache();
	exit;
}

function populatedFactorypodReportWorksheet($rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
	// Set the column widths
	$j = 0;
	$worksheet->setColumn($j, $j++, strlen('Trip ID') + 20);
	$worksheet->setColumn($j, $j++, strlen('Transc Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Truck No') + 20);
	$worksheet->setColumn($j, $j++, strlen('Qty') + 20);
	$worksheet->setColumn($j, $j++, strlen('Bill Rate') + 20);
	$worksheet->setColumn($j, $j++, strlen('Freight') + 20);
	$worksheet->setColumn($j, $j++, strlen('Factory') + 20);
	$worksheet->setColumn($j, $j++, strlen('Route') + 20);
	$worksheet->setColumn($j, $j++, strlen('POD Received') + 20);
	$worksheet->setColumn($j, $j++, strlen('POD Submitted') + 20);
	$worksheet->setColumn($j, $j++, strlen('Bill Raised') + 20);
	$worksheet->setColumn($j, $j++, strlen('Bill Amount') + 20);
	$worksheet->setColumn($j, $j++, strlen('Balance') + 20);
	// The heading row
	$i = 0;
	$j = 0;
	$worksheet->writeString($i, $j++, 'Trip ID', $boxFormat);
	$worksheet->writeString($i, $j++, 'Transc Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Truck No', $boxFormat);
	$worksheet->writeString($i, $j++, 'Qty', $boxFormat);
	$worksheet->writeString($i, $j++, 'Bill Rate', $boxFormat);
	$worksheet->writeString($i, $j++, 'Freight', $boxFormat);
	$worksheet->writeString($i, $j++, 'Factory', $boxFormat);
	$worksheet->writeString($i, $j++, 'Route', $boxFormat);
	$worksheet->writeString($i, $j++, 'POD Received', $boxFormat);
	$worksheet->writeString($i, $j++, 'POD Submitted', $boxFormat);
	$worksheet->writeString($i, $j++, 'Bill Raised', $boxFormat);
	$worksheet->writeString($i, $j++, 'Bill Amount', $boxFormat);
    $worksheet->writeString($i, $j++, 'Balance', $boxFormat);
	$worksheet->setRow($i, 30, $boxFormat);

	// The actual product specials data
	$i += 1;
	$j = 0;

	foreach ($rows as $item) {
	        $worksheet->setRow($i, 13);
            $worksheet->write($i, $j++, $item['id_trip'], $textFormat);
            $worksheet->write($i, $j++, date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])), $textFormat);
            $worksheet->write($i, $j++, $item['truckno'], $textFormat);
            $worksheet->write($i, $j++, $item['qty'], $textFormat);
            $worksheet->write($i, $j++, $item['billrate'], $textFormat);
            $worksheet->write($i, $j++, $item['qty']*$item['billrate'], $textFormat);
            $worksheet->write($i, $j++, $item['factoryname'], $textFormat);
            $worksheet->write($i, $j++, $item['operatingroutecode'], $textFormat);
            $worksheet->write($i, $j++, $item['ispodreceived']==1?'Yes':'No', $textFormat);
            $worksheet->write($i, $j++, $item['ispodsubmitted']==1?"Yes":"No", $textFormat);
            $worksheet->write($i, $j++, $item['id_factory_payment']==0?'No':'#'.$item['id_factory_payment'], $textFormat);
            $worksheet->write($i, $j++, $item['totalreceivableamount'], $textFormat);
            $worksheet->write($i, $j++, $item['id_factory_payment']!=0?($item['totalreceivableamount']-$item['paidamount']):'', $textFormat);
            $i += 1;
            $j = 0;
	}
}

public function downloadTrpodReport($rows) {
	ob_end_clean();
	//exit("value of ".DIR_SYSTEM);
	// We use the package from http://pear.php.net/package/Spreadsheet_Excel_Writer/
	chdir(DIR_SYSTEM."library/excel/pear/");
	//exit(DIR_SYSTEM."library/pear");
	require_once "Spreadsheet/Excel/Writer.php";
	chdir(DIR_SYSTEM."library/excel");
	//exit($_SERVER['DOCUMENT_ROOT']);
	// Creating a workbook
	$workbook = new Spreadsheet_Excel_Writer();
	$workbook->setTempDir(DIR_CACHE);
	$workbook->setVersion(8); // Use Excel97/2000 Format
	$priceFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '######0.00'));
	$boxFormat = & $workbook->addFormat(array('Size' => 10, 'vAlign' => 'vequal_space'));
	$weightFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '##0.00'));
	$textFormat = & $workbook->addFormat(array('Size' => 10, 'NumFormat' => "@"));
	// sending HTTP headers
	$workbook->send('trpod_report_'.date("Y-m-d h:i:s").'.xls');
	// Creating the Truck Details worksheet
	
	$worksheet = & $workbook->addWorksheet('Transporter PODS');
	$worksheet->setInputEncoding('UTF-8');
	$this->populatedTrpodReportWorksheet($rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
	$worksheet->freezePanes(array(1, 1, 1, 1));
	$workbook->close();
	// Clear the spreadsheet caches
	$this->clearSpreadsheetCache();
	exit;
}

function populatedTrpodReportWorksheet($rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
	// Set the column widths
	$j = 0;
	$worksheet->setColumn($j, $j++, strlen('Trip ID') + 20);
	$worksheet->setColumn($j, $j++, strlen('Transc Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Truck No') + 20);
	$worksheet->setColumn($j, $j++, strlen('Qty') + 20);
	$worksheet->setColumn($j, $j++, strlen('Truck Rate') + 20);
	$worksheet->setColumn($j, $j++, strlen('Freight') + 20);
	$worksheet->setColumn($j, $j++, strlen('Shortage') + 20);
	$worksheet->setColumn($j, $j++, strlen('Damage') + 20);
	$worksheet->setColumn($j, $j++, strlen('Transporter') + 20);
	$worksheet->setColumn($j, $j++, strlen('Route') + 20);
	$worksheet->setColumn($j, $j++, strlen('POD Received') + 20);
	$worksheet->setColumn($j, $j++, strlen('POD Submitted') + 20);
	$worksheet->setColumn($j, $j++, strlen('Adv') + 20);
	$worksheet->setColumn($j, $j++, strlen('POD Amount') + 20);
	$worksheet->setColumn($j, $j++, strlen('Bill Raised') + 20);
	// The heading row
	$i = 0;
	$j = 0;
	$worksheet->writeString($i, $j++, 'Trip ID', $boxFormat);
	$worksheet->writeString($i, $j++, 'Transc Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Truck No', $boxFormat);
	$worksheet->writeString($i, $j++, 'Qty', $boxFormat);
	$worksheet->writeString($i, $j++, 'Truck Rate', $boxFormat);
	$worksheet->writeString($i, $j++, 'Freight', $boxFormat);
	$worksheet->writeString($i, $j++, 'Shortage', $boxFormat);
	$worksheet->writeString($i, $j++, 'Damage', $boxFormat);
	$worksheet->writeString($i, $j++, 'Transporter', $boxFormat);
	$worksheet->writeString($i, $j++, 'Route', $boxFormat);
	$worksheet->writeString($i, $j++, 'POD Received', $boxFormat);
	$worksheet->writeString($i, $j++, 'POD Submitted', $boxFormat);
    $worksheet->writeString($i, $j++, 'Adv', $boxFormat);
	$worksheet->writeString($i, $j++, 'POD Amount', $boxFormat);
	$worksheet->writeString($i, $j++, 'Bill Raised', $boxFormat);
	$worksheet->setRow($i, 30, $boxFormat);

	// The actual product specials data
	$i += 1;
	$j = 0;

	foreach ($rows as $item) {
	        $worksheet->setRow($i, 13);
            $worksheet->write($i, $j++, $item['id_trip'], $textFormat);
            $worksheet->write($i, $j++, date(FORMAT_DATETIME_FORMAT, strtotime($item['transactiondate'])), $textFormat);
            $worksheet->write($i, $j++, $item['truckno'], $textFormat);
            $worksheet->write($i, $j++, $item['qty'], $textFormat);
            $worksheet->write($i, $j++, $item['truckrate'], $textFormat);
            $worksheet->write($i, $j++, $item['qty']*$item['truckrate'], $textFormat);
            $worksheet->write($i, $j++, $item['shortage'], $textFormat);
            $worksheet->write($i, $j++, $item['damage'], $textFormat);
			$worksheet->write($i, $j++, $item['transporter'], $textFormat);
			$worksheet->write($i, $j++, $item['operatingroutecode'], $textFormat);
            $worksheet->write($i, $j++, $item['ispodreceived']==1?'Yes':'No', $textFormat);
            $worksheet->write($i, $j++, $item['ispodsubmitted']==1?"Yes":"No", $textFormat);
            $worksheet->write($i, $j++, $item['transporteradvance'], $textFormat);
            $worksheet->write($i, $j++, ($item['qty']*$item['truckrate'])-($item['shortage']+$item['damage']+$item['transporteradvance']), $textFormat);
            $worksheet->write($i, $j++, $item['id_transporter_payment']==0?'No':'#'.$item['id_transporter_payment'], $textFormat);
            $i += 1;
            $j = 0;
	}
}

public function downloadLedgerReport($rows) {
	ob_end_clean();
	//exit("value of ".DIR_SYSTEM);
	// We use the package from http://pear.php.net/package/Spreadsheet_Excel_Writer/
	chdir(DIR_SYSTEM."library/excel/pear/");
	//exit(DIR_SYSTEM."library/pear");
	require_once "Spreadsheet/Excel/Writer.php";
	chdir(DIR_SYSTEM."library/excel");
	//exit($_SERVER['DOCUMENT_ROOT']);
	// Creating a workbook
	$workbook = new Spreadsheet_Excel_Writer();
	$workbook->setTempDir(DIR_CACHE);
	$workbook->setVersion(8); // Use Excel97/2000 Format
	$priceFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '######0.00'));
	$boxFormat = & $workbook->addFormat(array('Size' => 10, 'vAlign' => 'vequal_space'));
	$weightFormat = & $workbook->addFormat(array('Size' => 10, 'Align' => 'right', 'NumFormat' => '##0.00'));
	$textFormat = & $workbook->addFormat(array('Size' => 10, 'NumFormat' => "@"));
	// sending HTTP headers
	$workbook->send('ledger_report_'.date("Y-m-d h:i:s").'.xls');
	// Creating the Truck Details worksheet
	
	$worksheet = & $workbook->addWorksheet('Ledger');
	$worksheet->setInputEncoding('UTF-8');
	$this->populatedLedgerReportWorksheet($rows,$worksheet, $database, $priceFormat, $boxFormat, $textFormat);
	$worksheet->freezePanes(array(1, 1, 1, 1));
	$workbook->close();
	// Clear the spreadsheet caches
	$this->clearSpreadsheetCache();
	exit;
}

function populatedLedgerReportWorksheet($rows,&$worksheet, &$database, &$priceFormat, &$boxFormat, &$textFormat) {
	// Set the column widths
	$this->load->model('settings/branch');
        $filter_data = array(
                'sort' => 'branchcity',
                'order' => 'asc'
        );
        $branchesQry=$this->model_settings_branch->getItems($filter_data);
        $branches =$branchesQry->rows;
	
	$j = 0;
	$worksheet->setColumn($j, $j++, strlen('Date') + 20);
	$worksheet->setColumn($j, $j++, strlen('Type') + 20);
	$worksheet->setColumn($j, $j++, strlen('Particulars') + 20);
	$worksheet->setColumn($j, $j++, strlen('Narration') + 20);
	$worksheet->setColumn($j, $j++, strlen('Branch') + 20);
	$worksheet->setColumn($j, $j++, strlen('Withdrawal') + 20);
	$worksheet->setColumn($j, $j++, strlen('Deposit') + 20);
	// The heading row
	$i = 0;
	$j = 0;
	$worksheet->writeString($i, $j++, 'Date', $boxFormat);
	$worksheet->writeString($i, $j++, 'Type', $boxFormat);
	$worksheet->writeString($i, $j++, 'Particulars', $boxFormat);
	$worksheet->writeString($i, $j++, 'Narration', $boxFormat);
	$worksheet->writeString($i, $j++, 'Branch', $boxFormat);
	$worksheet->writeString($i, $j++, 'Withdrawal', $boxFormat);
	$worksheet->writeString($i, $j++, 'Deposit', $boxFormat);

	$worksheet->setRow($i, 30, $boxFormat);

	// The actual product specials data
	$i += 1;
	$j = 0;

	foreach ($rows as $item) {
	        $worksheet->setRow($i, 13);
            $worksheet->write($i, $j++, date(FORMAT_DATETIME_FORMAT, strtotime($item['transdate'])), $textFormat);
            $worksheet->write($i, $j++, $item['transtype'], $textFormat);
            $worksheet->write($i, $j++, $item['particulars'], $textFormat);
            $worksheet->write($i, $j++, $item['narration'], $textFormat);
            $worksheet->write($i, $j++, $branches[$item['id_branch']]['branchcity'], $textFormat);
            $worksheet->write($i, $j++, $item['transtype']=='Dr'?$item['amount']:'', $textFormat);
            $worksheet->write($i, $j++, $item['transtype']=='Cr'?$item['amount']:'', $textFormat);
            $i += 1;
            $j = 0;
	}
}
}?>