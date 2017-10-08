<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['editSite']) && !empty($_POST['editSiteID'] && !empty($_POST['editSiteName']))) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM sites where site_id=:type');
    $statement->bindParam(':type', $_POST['editSiteID']);
    $statement->execute();
    $results = $statement->fetch();
    $siteExists = $results['COUNT(*)'];
    if ($siteExists <= 0) {
      $_SESSION['flash'][] = "Error editing site: Site does not exist";
    }

    $statement = $dbc->prepare('SELECT COUNT(*) FROM sites where site_name=:name');
    $statement->bindParam(':name', $_POST['editSiteName']);
    $statement->execute();
    $results = $statement->fetch();
    $nameExists = $results['COUNT(*)'];
    if ($nameExists > 0) {
      $_SESSION['flash'][] = "Error editing site: New name already exists";
    }

    if ($siteExists > 0 && $nameExists <= 0) {
      $statement = $dbc->prepare('UPDATE sites set site_name=:name where site_id=:id');
      $statement->bindParam(':name', $_POST['editSiteName']);
      $statement->bindParam(':id', $_POST['editSiteID']);
      $statement->execute();
    }
  }

  if (isset($_POST['deleteSite']) && isset($_POST['deleteSite']) && !empty($_POST['deleteSite'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM items WHERE item_site=:site_id');
    $statement->bindParam(":site_id", $_POST['deleteSite']);
    $result = $statement->execute();
    $matches = $statement->fetchAll();
    if ($matches[0]['COUNT(*)'] == 0) {
      $statement = $dbc->prepare('DELETE FROM sites WHERE site_id=:site_id');
      $statement->bindParam(":site_id", $_POST['deleteSite']);
      $result = $statement->execute();
    } else {
      $_SESSION['flash'][] = "Error deleting site: Site did not exist.";
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
    } else {
      $_SESSION['flash'][] = "Error adding type: Name already exists.";
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
  if (isset($_SESSION['flash'])) {
    $tpl->assign('messages', $_SESSION['flash']);
  }
  $_SESSION['flash'] = array();
  $tpl->display('servicing/sites.tpl');
