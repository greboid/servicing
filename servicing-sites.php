<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['deleteSite']) && isset($_POST['deleteSite']) && !empty($_POST['deleteSite'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM items WHERE item_site=:site_id');
    $statement->bindParam(":site_id", $_POST['deleteSite']);
    $result = $statement->execute();
    $matches = $statement->fetchAll();
    if ($matches[0]['COUNT(*)'] == 0) {
      $statement = $dbc->prepare('DELETE FROM sites WHERE site_id=:site_id');
      $statement->bindParam(":site_id", $_POST['deleteSite']);
      $result = $statement->execute();
    }
  }
  if (isset($_POST['addSite']) && isset($_POST['name']) && !empty($_POST['name'])) {
    $statement = $dbc->prepare('SELECT site_id FROM sites where site_name=:site_name');
    $statement->bindParam(":site_name", $_POST['name']);
    $result = $statement->execute();
    $matches = $statement->fetchAll();
    if (empty($matches)) {
      $statement = $dbc->prepare('INSERT INTO sites VALUES (NULL, :site_name)');
      $statement->bindParam(":site_name", $_POST['name']);
      $result = $statement->execute();
    }
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
