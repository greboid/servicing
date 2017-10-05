<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['deleteLocation']) && !empty($_POST['deleteLocation'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM items WHERE item_location=:location_id');
    $statement->bindParam(":location_id", $_POST['deleteSite']);
    $result = $statement->execute();
    $matches = $statement->fetchAll();
    if ($matches[0]['COUNT(*)'] == 0) {
      $statement = $dbc->prepare('DELETE FROM locations WHERE location_id=:location_id');
      $statement->bindParam(":location_id", $_POST['deleteLocation']);
      $result = $statement->execute();
    }
  }

  if (isset($_POST['addLocation']) && !empty($_POST['name'] && !empty($_POST['site']))) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM locations where location_name=:location_name');
    $statement->bindParam(':location_name', $_POST['name']);
    $result = $statement->execute();
    $matches = $statement->fetchAll();
    if ($matches[0]['COUNT(*)'] == 0) {
      $statement = $dbc->prepare('INSERT INTO locations VALUES (NULL, :site_id, :location_name)');
      $statement->bindParam(':site_id', $_POST['site']);
      $statement->bindParam(':location_name', $_POST['name']);
      $statement->execute();
    }
  }

  $statement = $dbc->prepare('SELECT location_id, location_name, site_name
    FROM locations
    INNER JOIN sites ON location_site=site_id
    ORDER BY location_site, location_name');
  $result = $statement->execute();
  $locations = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT site_id, site_name FROM sites');
  $result = $statement->execute();
  $sites = $statement->fetchAll();

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Service Contracts');
  $tpl->assign('locations', $locations);
  $tpl->assign('sites', $sites);
  $tpl->display('servicing/locations.tpl');
