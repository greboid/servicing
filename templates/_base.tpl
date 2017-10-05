<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="/favicon.ico">
    <link href="/bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="/bower_components/bootstrap/dist/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="/bower_components/jquery-ui/themes/base/jquery-ui.min.css" rel="stylesheet">
    <link href="/bower_components/jquery-ui/themes/base/tabs.css" rel="stylesheet">
    <link href="/bower_components/jquery-ui/themes/base/theme.css" rel="stylesheet">
    <link href="/bower_components/sweetalert2/dist/sweetalert2.min.css" rel="stylesheet" >
    <link href="/bower_components/chosen-bootstrap/chosen.bootstrap.min.css" rel="stylesheet" >
    {block name="headerstyles"}{/block}
    <title>Servicing - {$title}</title>
  </head>
  <body role="document">
    <nav class="navbar navbar-default">
  		<div class="container">
  			<div class="navbar-header">
  				<a class="navbar-brand" href="/">Servicing</a>
  			</div>
  			<div id="navbar" class="navbar-header">
  				<ul class="nav navbar-nav">
                <li><a href="/servicing/services"><i class="glyphicon glyphicon-calendar"></i> Services</a></li>
                <li><a href="/servicing/contracts"><i class="glyphicon glyphicon-cog"></i> Contracts</a></li>
                <li><a href="/servicing/items"><i class="glyphicon glyphicon-list"></i> Items</a></li>
                <li><a href="/servicing/contractors"><i class="glyphicon glyphicon-user"></i> Contractors</a></li>
                <li><a href="/servicing/locations"><i class="glyphicon glyphicon-globe"></i> Locations</a></li>
                <li><a href="/servicing/sites"><i class="glyphicon glyphicon-cloud"></i> Sites</a></li>
                <li><a href="/servicing/types"><i class="glyphicon glyphicon-tags"></i> Types</a></li>
  				</ul>
  			</div>
  		</div>
    </nav>
    {block name=contents}{/block}
    <script src="/bower_components/jquery/dist/jquery.min.js"></script>
    <script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="/bower_components/jquery-ui/jquery-ui.min.js"></script>
    <script src="/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>
    <script src="/bower_components/chosen/chosen.jquery.min.js"></script>
    {block name="footerscripts"}{/block}
  </body>
</html>
