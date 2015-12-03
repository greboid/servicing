<?php
  include('includes/_global.php');
  $dbc = makeConnection('kfintranet');

  if (isset($_POST['deleteSite']) && isset($_POST['site']) && !empty($_POST['site'])) {
    //Check site has no items
  }
  if (isset($_POST['addSite']) && isset($_POST['name']) && !empty($_POST['name'])) {
    //Check name unique
  }

  $statement = $dbc->prepare('SELECT site_id, site_name FROM sites');
  $result = $statement->execute();
  $sites = $statement->fetchAll();

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Service Sites');
  $tpl->assign('sites', $sites);
  $tpl->display('servicing/sites.tpl');
