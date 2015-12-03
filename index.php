<?php
  include('includes/smarty/libs/Smarty.class.php');
  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';
  $tpl->assign('title', 'Index');
  $tpl->display('index.tpl');
?>
