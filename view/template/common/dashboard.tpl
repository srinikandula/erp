<?php echo $header; ?><div id="page-wrapper">
<?php //echo '<pre>';print_r($_SESSION);echo '</pre>';?>
            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-md-12 col-lg-12">
                        <h1 class="page-header">
                            Dashboard <!-- <small>Statistics Overview</small> -->
                        </h1>
                        <!-- <ol class="breadcrumb">
                            <li class="active">
                                <i class="fa fa-dashboard"></i> Dashboard
                            </li>
                        </ol> -->
                    </div>
                </div>
                <!-- /.row -->

                <!-- <div class="row">
                    <div class="col-md-12 col-lg-12">
                        <div class="alert alert-info alert-dismissable">
                            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                            <i class="fa fa-info-circle"></i>  <strong>Like SB Admin?</strong> Try out <a href="http://startbootstrap.com/template-overviews/sb-admin-2" class="alert-link">SB Admin 2</a> for additional features!
                        </div>
                    </div>
                </div> -->
                <!-- /.row -->
                <div class="sitemap">
                    <div class="sitemap-title">Site Map</div>
                    <!-- <ul class="customer-list">
                        <li>Customer</li>
                        <li><a href="#">Transporter</a></li>
                        <li><a href="#">Truck Owner</a></li>
                        <li><a href="#">Commission Agent</a></li>
                        <li><a href="#">Load Owner</a></li>
                        <li><a href="#">Manufacturer</a></li>
                    </ul> -->
		    <?php foreach($siteMap as $mod=>$data){ if(isset($_SESSION['gps_account_id']) && $_SESSION['gps_account_id']=="" && $mod=='Gps'){ continue;} ?>
                    <ul class="trucks-list">
                        <li><?php echo ucfirst($mod);?></li>
			<?php foreach($data as $dataInfo){?>
                        <!-- <li><a href="<?php echo $dataInfo['link'];?>" target="_blank" ><?php echo $dataInfo['title'];?></a></li> -->
			<li><a href="<?php echo $dataInfo['link'];?>" ><?php echo $dataInfo['title'];?></a></li>
                        <?php }?>
                    </ul>
		    <?php }?>


                </div>
                <!--<div class="row">
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-comments fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">26</div>
                                        <div>New Comments!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-tasks fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">12</div>
                                        <div>New Tasks!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-yellow">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-shopping-cart fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">124</div>
                                        <div>New Orders!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="panel panel-red">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-3">
                                        <i class="fa fa-support fa-5x"></i>
                                    </div>
                                    <div class="col-xs-9 text-right">
                                        <div class="huge">13</div>
                                        <div>Support Tickets!</div>
                                    </div>
                                </div>
                            </div>
                            <a href="#">
                                <div class="panel-footer">
                                    <span class="pull-left">View Details</span>
                                    <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>-->
                <!-- /.row -->

                <!--<div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o fa-fw"></i> Area Chart</h3>
                            </div>
                            <div class="panel-body">
                                <div id="morris-area-chart"></div>
                            </div>
                        </div>
                    </div>
                </div>-->
                <!-- /.row -->

                <div class="row">
                    <!--<div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-long-arrow-right fa-fw"></i> Donut Chart</h3>
                            </div>
                            <div class="panel-body">
                                <div id="morris-donut-chart"></div>
                                <div class="text-right">
                                    <a href="#">View Details <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-clock-o fa-fw"></i> Tasks Panel</h3>
                            </div>
                            <div class="panel-body">
                                <div class="list-group">
                                    <a href="#" class="list-group-item">
                                        <span class="badge">just now</span>
                                        <i class="fa fa-fw fa-calendar"></i> Calendar updated
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">4 minutes ago</span>
                                        <i class="fa fa-fw fa-comment"></i> Commented on a post
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">23 minutes ago</span>
                                        <i class="fa fa-fw fa-truck"></i> Order 392 shipped
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">46 minutes ago</span>
                                        <i class="fa fa-fw fa-money"></i> Invoice 653 has been paid
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">1 hour ago</span>
                                        <i class="fa fa-fw fa-user"></i> A new user has been added
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">2 hours ago</span>
                                        <i class="fa fa-fw fa-check"></i> Completed task: "pick up dry cleaning"
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">yesterday</span>
                                        <i class="fa fa-fw fa-globe"></i> Saved the world
                                    </a>
                                    <a href="#" class="list-group-item">
                                        <span class="badge">two days ago</span>
                                        <i class="fa fa-fw fa-check"></i> Completed task: "fix error on sales page"
                                    </a>
                                </div>
                                <div class="text-right">
                                    <a href="#">View All Activity <i class="fa fa-arrow-circle-right"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>-->
                    <div class="col-md-4 col-lg-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-money fa-fw"></i> Truck Renewals Pending  <span class="btn-xs btn-danger"> Expired </span>   <span class="btn-xs btn-warning"> 5 Days </span></h3>
                            </div>
                            <div class="panel-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>Truck No #</th>
                                                <th>Fitness</th>
                                                <th>Insurance</th>
                                                <th>National Permit</th>
                                                <th>Pollution</th>
                                                <th>Tax Payable On</th>
                                                <th>Hub Service</th>
                                                <th>Date In Service</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php 
					    $expDays=strtotime(date('Y-m-d', strtotime(date('Y-m-d') . ' +5 day')));
					    foreach($truckRenewals as $row){
                                                
                                                
                                                $fitnessexpdate="";
                                                if(strtotime($row['fitnessexpdate'])<$expDays){
                                                    $fitnessexpdate=strtotime($row['fitnessexpdate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
                                                }
                                                
                                                $insuranceexpdate="";
                                                if(strtotime($row['insuranceexpdate'])<$expDays){
                                                        $insuranceexpdate=strtotime($row['insuranceexpdate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
                                                }

                                                $nationalpermitexpdate="";
                                                if(strtotime($row['nationalpermitexpdate'])<$expDays){
                                                        $nationalpermitexpdate=strtotime($row['nationalpermitexpdate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
                                                }

                                                $pollutionexpdate="";
                                                if(strtotime($row['pollutionexpdate'])<$expDays){
                                                        $pollutionexpdate=strtotime($row['pollutionexpdate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
                                                }

                                                $taxpayabledate="";
                                                if(strtotime($row['taxpayabledate'])<$expDays){
                                                        $taxpayabledate=strtotime($row['taxpayabledate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
                                                }

                                                $hubservicedate="";
                                                if(strtotime($row['hubservicedate'])<$expDays){
                                                        $hubservicedate=strtotime($row['hubservicedate'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
                                                }

                                                $dateinservice="";
                                                if(strtotime($row['dateinservice'])<$expDays){
                                                        $dateinservice=strtotime($row['dateinservice'])<=strtotime('now')?'class="btn-danger"':'class="btn-warning"';
                                                }
                                            ?>
                                            <tr>
                                                <td><?php echo $row['truckno'];?></td>
                                                <td <?php echo $fitnessexpdate;?> ><?php echo $row['fitnessexpdate'];?></td>
                                                <td <?php echo $insuranceexpdate;?> ><?php echo $row['insuranceexpdate'];?></td>
                                                <td <?php echo $nationalpermitexpdate;?> ><?php echo $row['nationalpermitexpdate'];?></td>
                                                <td <?php echo $pollutionexpdate;?> ><?php echo $row['pollutionexpdate'];?></td>
                                                <td <?php echo $taxpayabledate;?> ><?php echo $row['taxpayabledate'];?></td>
                                                <td <?php echo $hubservicedate;?> ><?php echo $row['hubservicedate'];?></td>
                                                <td <?php echo $dateinservice;?> ><?php echo $row['dateinservice'];?></td>
                                            </tr>
                                            <?php }?>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="text-right">
                                    <a href="<?php echo $truckexpirydownloadlink;?>">Download <i class="fa fa-download" aria-hidden="true"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
<?php echo $footer; ?>