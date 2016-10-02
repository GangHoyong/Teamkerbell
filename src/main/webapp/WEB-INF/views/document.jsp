<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]> <html class="lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]> <html class="lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html lang="en"> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Teamkerbell</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../css/wait1.css">
    <link rel="stylesheet" href="../css/jquery-jvectormap-1.2.2.css">


    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script> -->
    <!--  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/../../js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script> -->
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->


    <link rel="stylesheet" href="../css/wait2.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <!-- Main Header -->

    <header class="main-header">

        <!-- Logo -->
        <a href="../dashboard/${user.id}" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>T</b>eam</span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>Teamker</b>Bell</span>
        </a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <!-- Navbar Right Menu -->
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">


                    <li class="dash-icon">
                        <a class="dash-nav">
                            <i class="fa fa-picture-o"></i></a>
                    </li>


                    <li class="dash-icon">
                        <a class="dash-nav">
                            <i class="fa fa-edit"></i>
                        </a>
                    </li>

                    <li class="dash-icon">
                        <a class="dash-nav">
                            <i class="fa fa-file-text-o"></i>
                        </a>
                    </li>
                    <li class="dash-icon">
                        <a class="dash-nav">
                            <i class="fa fa-calendar-o"></i>
                        </a>
                    </li>
                    <!-- Notifications Menu -->
                    <li class="dropdown notifications-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-bell-o"></i>
                            <span class="label label-warning">${alarm.size()}</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">You have ${alarm.size()} notifications</li>
                            <li>
                                <ul class="menu" style="max-height:400px;overflow-y:auto">
                                    <c:forEach var="list" items="${alarm}">
                                        <li id="alarm-${list.alarmidx}">
                                            <a href="#">
                                                <i class="fa fa-users text-aqua"></i><strong>${list.actor.id}</strong>
                                                has invited you
                                                to <strong>${list.project.name}</strong>
                                                <div style="float:right;">
                                                    <button type="button" class="btn btn-primary btn-xs"
                                                            onclick="accept('${list.alarmidx}')">Ok
                                                    </button>
                                                    <button type="button" class="btn btn-default btn-xs"
                                                            onclick="decline('${list.alarmidx}')">Cancel
                                                    </button>
                                                </div>
                                            </a>
                                        </li>
                                    </c:forEach>

                                </ul>
                            </li>
                            <li class="footer"> <!--<a href="#">View all</a></li>-->
                        </ul>
                    </li>

                    <!-- User Account Menu -->
                    <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- The user image in the navbar-->
                            <img src="../${user.img}" class="user-image" alt="" style="width:25px;height:25px">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs">${user.id}</span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- The user image in the menu -->
                            <li class="user-header">
                                <img src="../${user.img}" class="img-circle" alt="User Image"
                                     style="width:30px;height:30px">
                                <p>
                                    ${user.id}
                                </p>
                            </li>
                            <!-- Menu Body -->
                            <li class="user-body">
                                <div class="row">
                                    <div class="col-xs-6 text-center" style="border-right:1px solid;">
                                        <a href="../projectmanager"><i class="fa fa-pencil-square-o"></i> Project
                                            Edit</a>
                                    </div>
                                    <div class="col-xs-6 text-center">
                                        <a href=../userInfo/${user.id}><i class="fa fa-info-circle"></i> MyInfo Edit</a>
                                    </div>

                                </div>
                                <!-- /.row -->
                            </li>
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="#" class="btn btn-default btn-flat">Profile</a>
                                </div>
                                <div class="pull-right">
                                    <a href="../logout" class="btn btn-default btn-flat">Sign out</a>
                                </div>
                            </li>
                        </ul>
                    </li>

                </ul>
            </div>
        </nav>
    </header>    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">

        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">

            <!-- Sidebar user panel (optional) -->
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="../${user.img}" class="img-circle" alt="User Image" style="width:100px;height:100px">
                </div>
                <div class="pull-left info dash-user">
                    <p>${user.id}</p>
                    <!-- Status -->
                    <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <ul class="sidebar-menu">
                <li class="header"> Main Menu</li>
                <!-- Optionally, you can add icons to the links -->

                <li class="treeview">
                    <a href="#"><i class="fa fa-user"></i><span> My Profile</span></a>
                    <ul class="treeview-menu">
                        <li class="active"><a href=../userInfo/${user.id}><i class="fa fa-key"></i> Change user Info</a>
                        </li>
                    </ul>
                </li>
                <li class="treeview active">
                    <a href="#"><i class="fa fa-users"></i><span> Project rooms</span></a>
                    <ul class="treeview-menu">
                        <li>
                            <c:forEach var="list" items="${projects}"> <!-- 컨트롤러에서 넘겨받은 프로젝트를 list에 삽입 -->
                        <li ><a href="../chat/${list.projectidx}"><i class="fa fa-folder-open-o"></i>  <span style="font-size:18px">${list.name} </span></a></li>
                            </c:forEach>
                            <li><a href="../projectmanager"> <i class="fa fa-cogs"></i><span>Edit</span></a></li>
                        </li>
                    </ul>
                </li>

            </ul>
            <!-- /.sidebar-menu -->
        </section>
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">


        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Document
                <small>project result</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Project Edit</a></li>
                <li><a href="#">Document</a></li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="invoice">
            <!-- title row -->
            <div class="row">
                <div class="col-xs-12">
                    <h2 class="page-header">
                        <i class="fa fa-globe"></i> ${project.name}
                        <small class="pull-right">Date : ${date}</small>
                    </h2>
                </div>
                <!-- /.col -->
            </div>
            <!-- info row -->
            <div class="row invoice-info">
                <div class="col-sm-8 invoice-col">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Role</th>
                            <th>Director</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="list" items="${todolist}">
                            <tr>
                                <td>${list.content}</td>
                                <td>${list.user.name}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="col-sm-4 invoice-col">
                    <h4>All Members</h4>
                    <c:forEach var="list" items="${users}">
                        <strong>${list.name}</strong><br>
                    </c:forEach>

                </div>

            </div>
            <!-- /.row -->
            <br>

            <div class="row">

                <canvas id="areaChart" style="height:0px"></canvas>


                <!-- /.col (LEFT) -->
                <div class="col-md-8">

                    <!-- BAR CHART -->
                    <div class="box box-success" id="areaChart">
                        <div class="box-header with-border">
                            <h3 class="box-title">Contribution Chart</h3>
                            <div class="pull-right">
                                <button type="button" class="btn btn-block"
                                        style="width:5%;height:3%;float:left;border-radius:1px;background-color:#D2D6DE"></button>
                                <strong style="float:left;">: Participation </strong>
                                <button type="button" class="btn btn-block"
                                        style=";width:5%;height:3%;float:left;border-radius:1px;background-color:#00A65A"></button>
                                <strong>: TO Do Contribution</strong>
                            </div>
                        </div>
                        <div class="box-body">
                            <div class="chart">
                                <canvas id="barChart" style="height:230px"></canvas>
                            </div>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->

                </div>

            </div>


            <!-- this row will not appear when printing -->
            <div class="row no-print">
                <div class="col-xs-12">
                    <a href="#" class="btn btn-default" onclick="capture()"><i class="fa fa-print"></i>
                        Print</a>
                    <form method="POST" enctype="multipart/form-data" action="file" id="myForm">
                        <input type="hidden" name="file" id="img_val" value=""/>
                    </form>
                    <button type="button" class="btn btn-primary pull-right" onclick="pdf_capture()"
                            style="margin-right: 5px;">
                        <i class="fa fa-download"></i> Generate PDF
                    </button>
                </div>
            </div>
        </section>
        <!-- /.content -->
        <div class="clearfix"></div>

    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <footer class="main-footer">
        <!-- To the right -->
        <div class="pull-right hidden-xs">
            Teamkerbell
        </div>
        <!-- Default to the left -->
        <!-- <strong> &copy; 2015 <a href="#">Company</a>.</strong> All rights reserved.-->
    </footer>

    <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->


<div class="control-sidebar-bg"></div>


<div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">Make new Project</h4>
            </div>
            <form action="#">
                <div class="modal-body">
                    <div class="form-group">
                        <div class="form-group has-success">
                            <label class="control-label" for="inputSuccess"><i class="fa fa-check"></i> Input the
                                Project name</label>
                            <input type="text" class="form-control" id="inputSuccess" placeholder="Project name...">
                        </div>
                        <div class="has-feedback">
                            <input type="text" class="form-control input-sm" placeholder="Search Project">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>

                        <!-- at fist, not in here, after searching there will be -->
                        <div class="box box-primary" style="width:70%; margin-left:15%; margin-top:5%">
                            <div class="box-body box-profile">
                                <img class="profile-user-img img-responsive img-circle" src="../${user.img}"
                                     alt="User profile picture">
                                <h3 class="profile-username text-center">sieun</h3>
                                <p class="text-muted text-center">kim sieun</p>
                                <a href="#" class="btn btn-primary btn-block"><b>InVite</b></a>
                            </div>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Make</button>
                </div>
            </form>
        </div>
    </div>
</div>

<input id="reloadValue" type="hidden" name="reloadValue" value=""/>
<!-- jQuery 2.1.4 -->
<script src="../js/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="../js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="../js/app.min.js"></script>
<script src="../js/jspdf.min.js"></script>
<script src="../js/html2canvas.js"></script>
<script src="../js/prettydate.min.js"></script>
<!-- ChartJS 1.0.1 -->
<script src="../js/Chart.min.js"></script>
<script src="../js/date.js"></script>
<script>
    function capture() {
        html2canvas($('.content-wrapper'), {
            onrendered: function (canvas) {
                var a = document.createElement('a');
                // toDataURL defaults to png, so we need to request a jpeg, then convert for file download.
                a.href = canvas.toDataURL("image/jpeg").replace("image/jpeg", "image/octet-stream");
                a.download = 'document.jpg';
                a.click();
            }
        });
    }
    function pdf_capture() {
        html2canvas($('.content-wrapper'), {
            onrendered: function (canvas) {
                var doc = new jsPDF();
                doc.setFontSize(40);
                var imgData = canvas.toDataURL('image/jpeg', 1.0);
                doc.addImage(imgData, 'JPEG', 15, 40, 180, 220);
                doc.save("document.pdf");
            }
        });
    }
    $(function () {

/*
        {
            label: "Electronics",
                    fillColor: "rgba(210, 214, 222, 1)",
                strokeColor: "rgba(210, 214, 222, 1)",
                pointColor: "rgba(210, 214, 222, 1)",
                pointStrokeColor: "#c1c7d1",
                pointHighlightFill: "#fff",
                pointHighlightStroke: "rgba(220,220,220,1)",
                data: ${participant}
        },
        */
        // Get context with jQuery - using jQuery's .get() method.
        var areaChartCanvas = $("#areaChart").get(0).getContext("2d");
        // This will get the first returned node in the jQuery collection.
        var areaChart = new Chart(areaChartCanvas);

        var areaChartData = {
            labels: ${usersname},
            ykeys: ['item1', 'item2'],
            datasets: [
                {
                    label: "Digital Goods",
                    fillColor: "rgba(60,141,188,0.9)",
                    strokeColor: "rgba(60,141,188,0.8)",
                    pointColor: "#3b8bba",
                    pointStrokeColor: "rgba(60,141,188,1)",
                    pointHighlightFill: "#fff",
                    pointHighlightStroke: "rgba(60,141,188,1)",
                    data: ${percentage}
                }
            ]
        };

        var areaChartOptions = {
            //Boolean - If we should show the scale at all
            showScale: true,
            //Boolean - Whether grid lines are shown across the chart
            scaleShowGridLines: false,
            //String - Colour of the grid lines
            scaleGridLineColor: "rgba(0,0,0,.05)",
            //Number - Width of the grid lines
            scaleGridLineWidth: 1,
            //Boolean - Whether to show horizontal lines (except X axis)
            scaleShowHorizontalLines: true,
            //Boolean - Whether to show vertical lines (except Y axis)
            scaleShowVerticalLines: true,
            //Boolean - Whether the line is curved between points
            bezierCurve: true,
            //Number - Tension of the bezier curve between points
            bezierCurveTension: 0.3,
            //Boolean - Whether to show a dot for each point
            pointDot: false,
            //Number - Radius of each point dot in pixels
            pointDotRadius: 4,
            //Number - Pixel width of point dot stroke
            pointDotStrokeWidth: 1,
            //Number - amount extra to add to the radius to cater for hit detection outside the drawn point
            pointHitDetectionRadius: 20,
            //Boolean - Whether to show a stroke for datasets
            datasetStroke: true,
            //Number - Pixel width of dataset stroke
            datasetStrokeWidth: 2,
            //Boolean - Whether to fill the dataset with a color
            datasetFill: true,
            //String - A legend template
            //Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
            maintainAspectRatio: true,
            //Boolean - whether to make the chart responsive to window resizing
            responsive: true
        };


        //-------------
        //- BAR CHART -
        //-------------
        var barChartCanvas = $("#barChart").get(0).getContext("2d");
        var barChart = new Chart(barChartCanvas);
        var barChartData = areaChartData;
        var barChartOptions = {
            //Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
            scaleBeginAtZero: true,
            //Boolean - Whether grid lines are shown across the chart
            scaleShowGridLines: true,
            //String - Colour of the grid lines
            scaleGridLineColor: "rgba(0,0,0,.05)",
            //Number - Width of the grid lines
            scaleGridLineWidth: 1,
            //Boolean - Whether to show horizontal lines (except X axis)
            scaleShowHorizontalLines: true,
            //Boolean - Whether to show vertical lines (except Y axis)
            scaleShowVerticalLines: true,
            //Boolean - If there is a stroke on each bar
            barShowStroke: true,
            //Number - Pixel width of the bar stroke
            barStrokeWidth: 2,
            //Number - Spacing between each of the X value sets
            barValueSpacing: 5,
            //Number - Spacing between data sets within X values
            barDatasetSpacing: 1,
            //String - A legend template
            //Boolean - whether to make the chart responsive
            responsive: true,
            maintainAspectRatio: true
        };

        barChartOptions.datasetFill = false;
        barChart.Bar(barChartData, barChartOptions);
    });
</script>

</body>
</html>