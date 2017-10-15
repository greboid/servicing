<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['editContractor']) && !empty($_POST['editContractorID']) && !empty($_POST['editContractorName']) && !empty($_POST['editContractorPhone'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM contractors where contractor_id=:contractor_id');
    $statement->bindParam(':contractor_id', $_POST['editContractorID']);
    $statement->execute();
    $result = $statement->fetch();
    $result = $result['COUNT(*)'];
    if ($result) {
      $statement = $dbc->prepare('SELECT COUNT(*) FROM contractors where contractor_name=:contractor_name');
      $statement->bindParam(':contractor_name', $_POST['editContractorName']);
      $statement->execute();
      $result = $statement->fetch();
      $result = $result['COUNT(*)'];
      if (!$result) {
        $statement = $dbc->prepare('UPDATE contractors set contractor_name=:name, contractor_phone=:phone WHERE contractor_id=:id');
        $statement->bindParam(':id', $_POST['editContractorID']);
        $statement->bindParam(':name', $_POST['editContractorName']);
        $statement->bindParam(':phone', $_POST['editContractorPhone']);
        $statement->execute();
      } else {
        $_SESSION['flash'][] = "Error editing contractor: New name already exists";
      }
    } else {
      $_SESSION['flash'][] = "Error editing contractor: Contractor ID is invalid";
    }
  }

  if (isset($_POST['addContractor']) && !empty($_POST['name']) && !empty($_POST['number'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM contractors where contractor_name=:contractor_name');
    $statement->bindParam(':contractor_name', $_POST['name']);
    $statement->execute();
    $result = $statement->fetch();
    $result = $result['COUNT(*)'];
    if (!$result) {
        $statement = $dbc->prepare('INSERT INTO contractors VALUES (NULL, :contractor_name, :contractor_phone)');
        $statement->bindParam(':contractor_name', $_POST['name']);
        $statement->bindParam(':contractor_phone', $_POST['number']);
        $statement->execute();
    }
  }

  if (isset($_POST['deleteContractor']) && !empty($_POST['deleteContractor'])) {
    $statement = $dbc->prepare('SELECT COUNT(*) FROM contractors where contractor_id=:contractor_id');
    $statement->bindParam(':contractor_id', $_POST['deleteContractor']);
    $statement->execute();
    $result = $statement->fetch();
    $result = $result['COUNT(*)'];
    if ($result) {
        $statement = $dbc->prepare('DELETE FROM contractors where contractor_id=:contractor_id');
        $statement->bindParam(':contractor_id', $_POST['deleteContractor']);
        $statement->execute();
    }
  }

  $statement = $dbc->prepare('SELECT contractor_id, contractor_name, contractor_phone FROM contractors');
  $statement->execute();
  $results = $statement->fetchAll();

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Contractors');
  $tpl->assign('contractors', $results);
  if (isset($_SESSION['flash'])) {
    $tpl->assign('messages', $_SESSION['flash']);
  }
  $_SESSION['flash'] = array();

  $tpl->display('servicing/contractors.tpl');
