<div class="navigation">
    <a class="prev" href="index.php?month=__prev_month__" onclick="$('#calendar').load('http://www.easygaadi.com/erp/index.php?route=drivers/drivers/calendar&id_driver=<?php echo $_GET['id_driver'];?>&token=<?php echo $_GET['token'];?>&month=__prev_month__&_r=' + Math.random()); return false;"></a>
    <div class="title" >__cal_caption__</div>
    <a class="next" href="index.php?month=__next_month__" onclick="$('#calendar').load('http://www.easygaadi.com/erp/index.php?route=drivers/drivers/calendar&token=<?php echo $_GET['token'];?>&id_driver=<?php echo $_GET['id_driver'];?>&month=__next_month__&_r=' + Math.random()); return false;"></a>
</div>

<table>
    <tr>
        <th class="weekday">sun</th>
        <th class="weekday">mon</th>
        <th class="weekday">tue</th>
        <th class="weekday">wed</th>
        <th class="weekday">thu</th>
        <th class="weekday">fri</th>
        <th class="weekday">sat</th>
    </tr>
    __cal_rows__
</table>