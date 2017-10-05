<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['add']) && !empty($_POST['name']) && !empty($_POST['number'])) {
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

  if (isset($_POST['delete']) && !empty($_POST['deleteContractor'])) {
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

  $statement = $dbc->prepare('SELECT contractor_id, contractor_name FROM contractors');
  $statement->execute();
  $results = $statement->fetchAll();

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Contractors');
  $tpl->assign('contractors', $results);

  $tpl->display('servicing/contractors.tpl');
