<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['editType']) && !empty($_POST['editTypeID'] && !empty($_POST['editTypeName']))) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM item_types where type_id=:type');
    $statement->bindParam(':type', $_POST['editTypeID']);
    $statement->execute();
    $results = $statement->fetch();
    $typeExists = $results['COUNT(*)'];
    if ($typeExists <= 0) {
      $_SESSION['flash'][] = "Error editing type: Type does not exist";
    }

    $statement = $dbc->prepare('SELECT COUNT(*) FROM item_types where type_name=:name');
    $statement->bindParam(':name', $_POST['editTypeName']);
    $statement->execute();
    $results = $statement->fetch();
    $nameExists = $results['COUNT(*)'];
    if ($nameExists > 0) {
      $_SESSION['flash'][] = "Error editing type: New name already exists";
    }

    if ($typeExists > 0 && $nameExists <= 0) {
      $statement = $dbc->prepare('UPDATE item_types set type_name=:name where type_id=:id');
      $statement->bindParam(':name', $_POST['editTypeName']);
      $statement->bindParam(':id', $_POST['editTypeID']);
      $statement->execute();
    }
  }

  if (isset($_POST['deleteType']) && !empty($_POST['deleteType'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM items where item_type=:type');
    $statement->bindParam(':type', $_POST['deleteType']);
    $statement->execute();
    $results = $statement->fetch();
    $results = $results['COUNT(*)'];
    if ($results <= 0) {
      $statement = $dbc->prepare('DELETE from item_types where type_id=:id');
      $statement->bindParam(':id', $_POST['deleteType']);
      $statement->execute();
    } else {
      $_SESSION['flash'][] = "Error deleting type: Either did not exist, or had items.";
    }
  }

  if (isset($_POST['addType']) && isset($_POST['newTypeName']) && !empty($_POST['newTypeName'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM item_types where type_name=:name');
    $statement->bindParam(':name', $_POST['newTypeName']);
    $statement->execute();
    $results = $statement->fetch();
    $results = $results['COUNT(*)'];
    if ($results <= 0) {
      $statement = $dbc->prepare('INSERT INTO item_types VALUES(NULL, :name)');
      $statement->bindParam(':name', $_POST['newTypeName']);
      $statement->execute();
    } else {
      $_SESSION['flash'][] = "Error adding type: Name already exists.";
    }
  }

  $statement = $dbc->prepare('SELECT type_id, type_name FROM item_types');
  $result = $statement->execute();
  $sites = $statement->fetchAll();

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Item Types');
  $tpl->assign('types', $sites);
  if (isset($_SESSION['flash'])) {
    $tpl->assign('messages', $_SESSION['flash']);
  }
  $_SESSION['flash'] = array();
  $tpl->display('servicing/types.tpl');
