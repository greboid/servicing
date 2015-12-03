<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Locations');
  $tpl->display('servicing/contracts.tpl');
