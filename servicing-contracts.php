<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['editContract'])
        && !empty($_POST['editContractID'])
        && !empty($_POST['editContractor'])
        && !empty($_POST['editStartDate'])
        && !empty($_POST['editEndDate'])
        && isset($_POST['editNotes'])) {
    $startDate = new DateTime($_POST['editStartDate']);
    $endDate = new DateTime($_POST['editEndDate']);

    $statement = $dbc->prepare('UPDATE contracts SET
                               contract_contractor=:contractor,
                               contract_start=:start,
                               contract_end=:end,
                               contract_notes=:notes
                               WHERE contract_id=:contractID');
    $statement->bindParam(':contractID', $_POST['editContractID']);
    $statement->bindParam(':contractor', $_POST['editContractor']);
    $statement->bindValue(':start', $startDate->format('Y-m-d'));
    $statement->bindValue(':end', $endDate->format('Y-m-d'));
    $statement->bindParam(':notes', $_POST['editNotes']);
    $statement->execute();

    $statement = $dbc->prepare('UPDATE items set item_contract=-1 WHERE item_contract=:contract');
    $statement->bindParam(':contract', $_POST['editContractID']);
    $result = $statement->execute();
    if (isset($_POST['editItems'])) {
      foreach ($_POST['editItems'] as $item) {
        $statement = $dbc->prepare('UPDATE items set item_contract=:contract WHERE item_id=:item_id');
        $statement->bindParam(':contract', $_POST['editContractID']);
        $statement->bindParam(':item_id', $item);
        $result = $statement->execute();
      }
    }
  }

  if (isset($_POST['add']) && !empty($_POST['contractor'])
      && !empty($_POST['startDate'])
      && !empty($_POST['endDate'])) {
    $contractor = $_POST['contractor'];
    $startDate = new DateTime($_POST['startDate']);
    $endDate = new DateTime($_POST['endDate']);
    $items = !empty($_POST['items']) ? $_POST['items'] : array();
    $notes = !empty($_POST['notes']) ? $_POST['notes'] : '';
    $interval = $startDate->diff($endDate);

    if ($interval->days >= 0) {
      $statement = $dbc->prepare('INSERT INTO contracts VALUES (NULL, :contractor, :start, :end, :notes)');
      $statement->bindParam(':contractor', $contractor);
      $statement->bindValue(':start', $startDate->format('Y-m-d'));
      $statement->bindValue(':end', $endDate->format('Y-m-d'));
      $statement->bindParam(':notes', $notes);
      $statement->execute();
      $id = $dbc->lastInsertId();

      foreach ($items as $item) {
        $statement = $dbc->prepare('UPDATE items set item_contract=:contract WHERE item_id=:item_id');
        $statement->bindParam(':contract', $id);
        $statement->bindParam(':item_id', $item);
        $statement->execute();
      }
    }
  }

  if (!empty($_POST['deleteContract'])) {
    $statement = $dbc->prepare('DELETE FROM contracts where contract_id=:id');
    $statement->bindParam(':id', $_POST['deleteContract']);
    $statement->execute();
    $statement = $dbc->prepare('UPDATE items set item_contract=NULL where item_contract=:id');
    $statement->bindParam(':id', $_POST['deleteContract']);
    $statement->execute();

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

  $statement = $dbc->prepare('SELECT contractor_id, contractor_name FROM contractors');
  $result = $statement->execute();
  $contractors = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT item_id, item_name FROM items');
  $result = $statement->execute();
  $items = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT contract_id, contractor_id, contractor_name, contract_start, contract_end, contract_notes
                             FROM contracts
                             LEFT JOIN contractors ON contract_contractor=contractor_id');
  $result = $statement->execute();
  $contracts = $statement->fetchAll();
  foreach ($contracts as &$value) {
    $statement = $dbc->prepare('SELECT item_id, item_name FROM items WHERE item_contract=:contract');
    $statement->bindParam(':contract', $value['contract_id']);
    $result = $statement->execute();
    $value['contract_items'] = $statement->fetchAll();
  }

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Locations');
  $tpl->assign('locations', $locations);
  $tpl->assign('sites', $sites);
  $tpl->assign('contractors', $contractors);
  $tpl->assign('contracts', $contracts);
  $tpl->assign('items', $items);
  $tpl->display('servicing/contracts.tpl');
