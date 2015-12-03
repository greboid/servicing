<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="/favicon.ico">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/bootstrap-theme.min.css" rel="stylesheet">
    <link href="/css/jquery-ui.css" rel="stylesheet" >
    <link href="/css/jquery-ui.min.css" rel="stylesheet">
    <link href="/css/jquery-ui.structure.min.css" rel="stylesheet">
    <link href="/css/jquery-ui.theme.min.css" rel="stylesheet">
    <link href="/css/sweetalert.css" rel="stylesheet" >
    <link href="/css/chosen.min.css" rel="stylesheet" >
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
                <li><a href="/servicing/items"><i class="glyphicon glyphicon-list"></i> Items</a></li>
                <li><a href="/servicing/contracts"><i class="glyphicon glyphicon-cog"></i> Contracts</a></li>
                <li><a href="/servicing/locations"><i class="glyphicon glyphicon-globe"></i> Locations</a></li>
                <li><a href="/servicing/sites"><i class="glyphicon glyphicon-cloud"></i> Sites</a></li>
  				</ul>
  			</div>
  		</div>
    </nav>
    {block name=contents}{/block}
    <script src="/js/jquery.min.js"></script>
    <script src="/js/ie-emulation-modes-warning.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="/js/jquery-ui.js"></script>
    <script src="/js/ie-emulation-modes-warning.js"></script>
    <script src="/js/sweetalert.min.js"></script>
    <script src="/js/chosen.jquery.min.js"></script>
    {block name="footerscripts"}{/block}
  </body>
</html>
