<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (!empty($_POST['deleteItem'])) {
    $statement = $dbc->prepare('DELETE FROM items WHERE item_id=:item_id');
    $statement->bindParam(':item_id', $_POST['deleteItem']);
    $statement->execute();
  }

  if (isset($_POST['addItem'])
            && !empty($_POST['name'])
            && !empty($_POST['location'])
            && !empty($_POST['type'])
            && !empty($_POST['interval'])
            && !empty($_POST['lastServiced'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM locations where location_id=:location_id');
    $statement->bindParam(':location_id', $_POST['location']);
    $result = $statement->execute();
    $locations = $statement->fetch();
    $locations = $locations['COUNT(*)'];

    $statement = $dbc->prepare('SELECT COUNT(*) FROM item_types where type_id=:type_id');
    $statement->bindParam(':type_id', $_POST['type']);
    $result = $statement->execute();
    $types = $statement->fetch();
    $types = $types['COUNT(*)'];

    if (isset($_POST['contract'])) {
      $statement = $dbc->prepare('SELECT COUNT(*) FROM contracts where contract_id=:contract_id');
      $statement->bindParam(':contract_id', $_POST['contract']);
      $result = $statement->execute();
      $contracts = $statement->fetch();
      $contracts = $contracts['COUNT(*)'];
    } else {
      $contracts = '1';
    }

    $statement = $dbc->prepare('SELECT COUNT(*) FROM intervals where intervals_id=:intervals_id');
    $statement->bindParam(':intervals_id', $_POST['interval']);
    $result = $statement->execute();
    $intervals = $statement->fetch();
    $intervals = $intervals['COUNT(*)'];

    if ($locations && $types && $contracts && $intervals) {
      $statement = $dbc->prepare('INSERT INTO items VALUES (NULL, :item_type, :item_location, (SELECT location_site FROM locations where location_id=:item_location), :item_contract, :item_interval, :item_name, :item_notes)');
      $statement->bindParam(':item_type', $_POST['type']);
      $statement->bindParam(':item_location', $_POST['location']);
      $statement->bindValue(':item_contract', isset($_POST['contract']) ? $_POST['contract'] : NULL);
      $statement->bindParam(':item_interval', $_POST['interval']);
      $statement->bindParam(':item_name', $_POST['name']);
      $statement->bindValue(':item_notes', '');
      $result = $statement->execute();
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

  $statement = $dbc->prepare('SELECT type_id, type_name FROM item_types');
  $result = $statement->execute();
  $types = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT contractor_id, contractor_name FROM contractors');
  $result = $statement->execute();
  $contractors = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT contract_id, contractor_name, contract_start, contract_end FROM contracts
    INNER JOIN contractors ON contract_contractor=contractor_id');
  $result = $statement->execute();
  $contracts = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT intervals_id, intervals_name FROM intervals ORDER BY intervals_months');
  $result = $statement->execute();
  $intervals = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT item_id, item_name, site_name
    FROM items
    INNER JOIN sites on item_site=site_id');
  $result = $statement->execute();
  $items = $statement->fetchAll();

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Serviceable Items');
  $tpl->assign('locations', $locations);
  $tpl->assign('sites', $sites);
  $tpl->assign('types', $types);
  $tpl->assign('contracts', $contracts);
  $tpl->assign('contractors', $contractors);
  $tpl->assign('intervals', $intervals);
  $tpl->assign('items', $items);
  $tpl->display('servicing/items.tpl');
?>
