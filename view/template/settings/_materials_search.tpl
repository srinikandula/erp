<div class="row">
<div class="search-container search-row col-md-12">
    <form id="horizontalFormFilter" class="form-horizontal-filter" method="post">
	<input class="search-input" type="text" name="filter_material" placeholder="Material">
	<input class="search-input" type="text" name="filter_materialcode" placeholder="Material Code">
	<input id="submitFilter" class="sbmt-btn" type="submit" name="search" value="Search">
    </form>
</div>
</div>
<script>
$("#submitFilter").on("click", function(e) {
	e.preventDefault();
	var data = $('form#horizontalFormFilter').serialize();
	getList('index.php?route=<?php echo $route;?>/getlist&token=<?php echo $token; ?>&' + data);
});
</script>