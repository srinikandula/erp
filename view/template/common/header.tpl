<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title><?php echo $title;?></title>
    <!-- Bootstrap Core CSS -->
    <link href="<?php echo HTTP_SERVER;?>view/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link href="<?php echo HTTP_SERVER;?>view/css/sb-admin.css" rel="stylesheet">
    <!-- Morris Charts CSS -->
    <link href="<?php echo HTTP_SERVER;?>view/css/plugins/morris.css" rel="stylesheet">
    <!-- Custom Fonts -->
    <link href="<?php echo HTTP_SERVER;?>view/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
<!-- jQuery -->

<script src="<?php echo HTTP_SERVER;?>view/js/jquery.js"></script>
<script src="<?php echo HTTP_SERVER;?>view/js/main.js"></script>
<script src="<?php echo HTTP_SERVER;?>view/js/bootstrap.min.js"></script>

    </head>

    <body>

        <div id="wrapper">

            <!-- Navigation -->
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="<?php echo $home;?>">EasyFleet</a>
                </div>
                <!-- Top Menu Items -->
                <ul class="nav navbar-right top-nav">
                    <!-- <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-bell"></i> <b class="caret"></b></a>
                        <ul class="dropdown-menu alert-dropdown">
                            <li>
                                <a href="#">Alert Name <span class="label label-default">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-primary">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-success">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-info">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-warning">Alert Badge</span></a>
                            </li>
                            <li>
                                <a href="#">Alert Name <span class="label label-danger">Alert Badge</span></a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="#">View All</a>
                            </li>
                        </ul>
                    </li> -->
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> <?php echo $_SESSION['default']['adminname'];?> <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="<?php echo $logout; ?>"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
		<?php   //echo '<pre>'; print_r($siteMap);echo '</pre>';
		if(isset($navLinks)){?>
		<div class="collapse navbar-collapse navbar-contextual">
                    <ul class="nav navbar-nav">
		    <?php 
		    if(isset($modulelabel)){
			echo '<li><a style="background-color: #337ab7;color: #fff;font-weight:bold">'.$modulelabel.'</a></li>';
		    }
		    foreach($navLinks as $name=>$link){?>
                        <li <?php if($route==$link['route']){ echo 'class="active"';} ?>><a href="<?php echo $link['link'];?>"  ><?php echo $name;?></a></li>
			<?php }?>
                    </ul>
                </div>
		<?php }?>
                <!--   -->
                <!-- /.navbar-collapse -->
            </nav>
	    <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
                <!-- <div class="collapse navbar-collapse navbar-contextual">
                    <ul class="nav navbar-nav">
                        <li><a href="#">Transporter</a></li>
                        <li><a href="#"> Truck Owner</a></li>
                        <li><a href="#">Commission Agent</a></li>
                        <li><a href="#">Load Owner</a></li>
                        <li><a href="#">Manufacturer</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Trucks</a></li>
                        <li><a href="#">Rates</a></li>
                    </ul>
                </div> -->