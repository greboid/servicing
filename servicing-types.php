<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  if (isset($_POST['deleteType']) && isset($_POST['deleteType']) && !empty($_POST['deleteType'])) {
    $statement = $dbc->prepare('DELETE from item_types where type_id=:id');
    $statement->bindParam(':id', $_POST['deleteType']);
    $statement->execute();
  }
  if (isset($_POST['addType']) && isset($_POST['name']) && !empty($_POST['name'])) {
    $statement = $dbc->prepare('INSERT INTO item_types VALUES(NULL, :name)');
    $statement->bindParam(':name', $_POST['name']);
    $statement->execute();
  }

  $statement = $dbc->prepare('SELECT type_id, type_name FROM item_types');
  $result = $statement->execute();
  $sites = $statement->fetchAll();

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Item Types');
  $tpl->assign('types', $sites);
  $tpl->display('servicing/types.tpl');
