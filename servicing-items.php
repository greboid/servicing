<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['editItem'])
        && !empty($_POST['editItemID'])
        && !empty($_POST['editItemName'])
        && !empty($_POST['editItemLocation'])
        && !empty($_POST['editItemType'])
        && !empty($_POST['editItemInterval'])
      ) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM items where item_id=:id');
    $statement->bindParam(':id', $_POST['editItemID']);
    $statement->execute();
    $results = $statement->fetch();
    $idExists = $results['COUNT(*)'];
    if ($idExists <= 0) {
      $_SESSION['flash'][] = "Error editing item: ID does not exist";
    }

    $statement = $dbc->prepare('SELECT COUNT(*) FROM items where item_name=:name');
    $statement->bindParam(':name', $_POST['editItemName']);
    $statement->execute();
    $results = $statement->fetch();
    $nameExists = $results['COUNT(*)'];
    if ($nameExists > 0) {
      $_SESSION['flash'][] = "Error editing item: Name Exists";
    }

    $statement = $dbc->prepare('SELECT COUNT(*) FROM locations where location_id=:id');
    $statement->bindParam(':id', $_POST['editItemLocation']);
    $statement->execute();
    $results = $statement->fetch();
    $locationExists = $results['COUNT(*)'];
    if ($locationExists <= 0) {
      $_SESSION['flash'][] = "Error editing item: Location does not exist";
    }

    $statement = $dbc->prepare('SELECT COUNT(*) FROM item_types where type_id=:id');
    $statement->bindParam(':id', $_POST['editItemType']);
    $statement->execute();
    $results = $statement->fetch();
    $typeExists = $results['COUNT(*)'];
    if ($typeExists <= 0) {
      $_SESSION['flash'][] = "Error editing item: Type does not exist";
    }

    $statement = $dbc->prepare('SELECT COUNT(*) FROM intervals where intervals_id=:id');
    $statement->bindParam(':id', $_POST['editItemInterval']);
    $statement->execute();
    $results = $statement->fetch();
    $intervalExists = $results['COUNT(*)'];
    if ($intervalExists <= 0) {
      $_SESSION['flash'][] = "Error editing item: Interval does not exist";
    }

    if ($idExists > 0 && $nameExists <= 0 && $locationExists > 0 && $typeExists > 0 && $intervalExists > 0) {
      $statement = $dbc->prepare('UPDATE items
                                 SET
                                  item_name=:name,
                                  item_location=:location,
                                  item_type=:type,
                                  item_interval=:interval,
                                  item_site=(SELECT location_site FROM locations where location_id=:location)
                                 WHERE item_id=:id');
      $statement->bindParam(':id', $_POST['editItemID'], PDO::PARAM_INT);
      $statement->bindParam(':name', $_POST['editItemName'], PDO::PARAM_STR);
      $statement->bindParam(':location', $_POST['editItemLocation'], PDO::PARAM_INT);
      $statement->bindParam(':type', $_POST['editItemType'], PDO::PARAM_INT);
      $statement->bindParam(':interval', $_POST['editItemInterval'], PDO::PARAM_INT);
      $statement->execute();
    }
  }

  if (isset($_POST['deleteItem']) && !empty($_POST['deleteItem'])) {
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
      $statement = $dbc->prepare('INSERT INTO items VALUES (NULL, :item_type, :item_location, (SELECT location_
       FROM locations where location_id=:item_location), :item_contract, :item_interval, :item_name, :item_notes)');
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

  $statement = $dbc->prepare('SELECT item_id, item_name, item_location, item_type, item_interval, site_name, location_name, intervals_name, type_name
    FROM items
    INNER JOIN intervals on item_interval=intervals_id
    INNER JOIN item_types on item_type=type_id
    INNER JOIN locations on item_location=location_id
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
  if (isset($_SESSION['flash'])) {
    $tpl->assign('messages', $_SESSION['flash']);
  }
  $_SESSION['flash'] = array();

  $tpl->display('servicing/items.tpl');
?>
