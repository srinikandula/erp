<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <!--<th > <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /> </th>-->
            <th >S.No</th>
            <th >Truck No</th>
	    <th >Tons</th>
	    <th >Tyres</th>
	    <th >Fitness</th>
	    <th >Insurance</th>
	    <th >National Permit</th>
	    <th >Pollution</th>
            <th >Tax Payable On</th>
            <th >Hub Service</th>
            <th >Date In Service</th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {
		    $expDays=strtotime(date('Y-m-d', strtotime(date('Y-m-d') . ' +5 day')));
		    foreach ($items as $k => $item) {
			$fitnessexpdate="";
			if(strtotime($item['fitnessexpdate'])<$expDays){
			    $fitnessexpdate=strtotime($item['fitnessexpdate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
			}
			
			$insuranceexpdate="";
			if(strtotime($item['insuranceexpdate'])<$expDays){
				$insuranceexpdate=strtotime($item['insuranceexpdate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
			}

			$nationalpermitexpdate="";
			if(strtotime($item['nationalpermitexpdate'])<$expDays){
				$nationalpermitexpdate=strtotime($item['nationalpermitexpdate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
			}

			$pollutionexpdate="";
			if(strtotime($item['pollutionexpdate'])<$expDays){
				$pollutionexpdate=strtotime($item['pollutionexpdate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
			}

			$taxpayabledate="";
			if(strtotime($item['taxpayabledate'])<$expDays){
				$taxpayabledate=strtotime($item['taxpayabledate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
			}

			$hubservicedate="";
			if(strtotime($item['hubservicedate'])<$expDays){
				$hubservicedate=strtotime($item['hubservicedate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
			}

			$dateinservice="";
			if(strtotime($item['dateinservice'])<$expDays){
				$dateinservice=strtotime($item['dateinservice'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
			}
		    ?>
            <tr >
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td><?php echo $item['truckno']; ?></td>
		    <td><?php echo $item['tons']; ?></td>
		    <td><?php echo $item['tyres']; ?></td>
		    <td  <?php echo $fitnessexpdate;?>  ><?php echo $item['fitnessexpdate']; ?></td>
		    <td <?php echo $insuranceexpdate;?> ><?php echo $item['insuranceexpdate']; ?></td>
		    <td <?php echo $nationalpermitexpdate;?> ><?php echo $item['nationalpermitexpdate']; ?></td>
		    <td <?php echo $pollutionexpdate;?> ><?php echo $item['pollutionexpdate']; ?></td>
		    <td <?php echo $taxpayabledate;?> ><?php echo $item['taxpayabledate']; ?></td>
		    <td <?php echo $hubservicedate;?> ><?php echo $item['hubservicedate']; ?></td>
		    <td <?php echo $dateinservice;?> ><?php echo $item['dateinservice']; ?></td>
	    </tr>
        <?php } ?>
        <?php } else { ?>
            <tr>
                <td class="text-center" colspan="8">No Data Available</td>
            </tr>
        <?php } ?>
    </tbody>
</table>
<?php include(DIR_TEMPLATE.'common/_pagination.tpl');?>