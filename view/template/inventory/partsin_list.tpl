<table id="listMasterTable" class="mtable table table-striped table-bordered table-responsive table-condensed table-hover" style="width:100%">
    <thead>
        <tr>
            <!--<th ></th>-->
            <th >S.No</th>
            <th >Item</th>
	    <th >Desc</th>
	    <th >Make</th>
	    <th >Type</th>
            <th >Ref No</th>
            <th >Qty</th>
	    <th >Price Per Unit</th>
	    <th >Amount</th>
            <th >Branch</th>
            <th >Vendor</th>
	    <th >Date</th>
        </tr>
    </thead>
    <tbody>
        <?php if ($items) {  
                    foreach ($items as $k => $item) { ?>
            <tr id="list_<?php echo $item['id']; ?>"  >
                    <!-- <td><?php if (in_array($item['id'], $selected)) { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" checked="checked" />
                    <?php } else { ?>
                    <input type="checkbox" name="selected[]" value="<?php echo $item['id']; ?>" />
                    <?php }	?></td> -->
                    <td><?php echo $item['sno'];//$k + $page; ?></td>
                    <td id="list_truckno_<?php echo $item['id']; ?>"><?php echo $item['itemname']; ?></td>
		    <td id="list_dateattached_<?php echo $item['id']; ?>"><?php echo $item['description']; ?></td>
                    <td id="list_itemname_<?php echo $item['id']; ?>"><?php echo $item['make']; ?></td>
		    <td id="list_refno_<?php echo $item['id']; ?>"><?php echo $item['type']; ?></td>
                    <td id="list_type_<?php echo $item['id']; ?>"><?php echo $item['refno']; ?></td>
		    <td id="list_cmr_<?php echo $item['id']; ?>"><?php echo $item['qty']; ?></td>
		    <td id="list_cmr_<?php echo $item['id']; ?>"><?php echo $item['price']; ?></td>
		    <td id="list_cmr_<?php echo $item['id']; ?>"><?php echo $item['qty']*$item['price']; ?></td>
		    <td id="list_branchcity_<?php echo $item['id']; ?>"><?php echo $item['branchcity']; ?>
		    </td>
                    <td id="list_comment_<?php echo $item['id']; ?>"><?php echo $item['vendorname']; ?></td>
                    <td id="list_datecreated_<?php echo $item['id']; ?>"><?php echo date(FORMAT_DATE_FORMAT, strtotime($item['datepurchased'])); ?></td>
                    <!-- <td><i class="fa fa-fw fa-edit <?php echo $editPermClass; ?>" onclick='fnEdit(<?php echo json_encode($item); ?>);'></i></td> -->
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