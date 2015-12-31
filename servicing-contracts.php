<?php
  include('includes/_global.php');
  $dbc = makeConnection('servicing');

  $statement = $dbc->prepare('SELECT location_id, location_name, site_name
    FROM locations
    INNER JOIN sites ON location_site=site_id
    ORDER BY location_site, location_name');
  $result = $statement->execute();
  $locations = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT site_id, site_name FROM sites');
  $result = $statement->execute();
  $sites = $statement->fetchAll();

  $statement = $dbc->prepare('SELECT contract_id, contractor_name, contract_start, contract_end FROM contracts
    INNER JOIN contractors ON contract_contractor=contractor_id');
  $result = $statement->execute();
  $contracts = $statement->fetchAll();

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';

  $tpl->assign('title', 'Locations');
  $tpl->assign('locations', $locations);
  $tpl->assign('sites', $sites);
  $tpl->assign('contracts', $contracts);
  $tpl->display('servicing/contracts.tpl');
