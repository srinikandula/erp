<!DOCTYPE><!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Gaadi Technologies-Forgot Password</title>

    <!-- Bootstrap Core CSS -->
    <link href="<?php echo HTTP_SERVER;?>view/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="<?php echo HTTP_SERVER;?>view/css/sb-admin.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <!--link href="css/plugins/morris.css" rel="stylesheet"-->

    <!-- Custom Fonts -->
    <link href="<?php echo HTTP_SERVER;?>view/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<div class="center-div">
    <h3 class="login-eg-title">EasyGaadi</h3>
    <h3>Forgot Password</h3>    
    <div class="login-form-container col-md-4 center-div">
           <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
              <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
        <input type="text" class="form-control" name="account" placeholder="Account" value="<?php echo $account; ?>" required>
	<input type="hidden" class="form-control" name="poizxc" placeholder="Account" value="login">
	<input type="text" class="form-control" name="email" placeholder="Email" value="<?php echo $email; ?>"  required>
        <button type="submit" class="btn btn-primary">Reset</button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="Back" class="btn btn-default"><i class="fa fa-reply"></i></a>
        </form>
    </div>
</div>



 <script src="<?php echo HTTP_SERVER;?>view/js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<?php echo HTTP_SERVER;?>view/js/bootstrap.min.js"></script>
</body>
</html>