<?php
  include('includes/_global.php');
  $dbc = makeConnection('kfintranet');
  if (!empty($_POST['newServiceID']) && !empty($_POST['newServiceDate'])) {
    $_POST['newServiceDate'];
    $_POST['newServiceID'];
    $_POST['newServiceNotes'];
    $statement = $dbc->prepare('INSERT INTO services (service_item, service_date, service_notes) VALUES(:item, :date, :notes)');
    $statement->bindValue(':item', $_POST['newServiceID']);
    $statement->bindValue(':date', $_POST['newServiceDate']);
    $statement->bindValue(':notes', $_POST['newServiceNotes']);
    $result = $statement->execute();
  }
  $statement = $dbc->prepare('SELECT site_name, site_id FROM sites');
  $result = $statement->execute();
  $sites = $statement->fetchAll();
  $sql = "SELECT
          	item_id AS ID,
          	location_name AS location,
          	site_name AS siteName,
          	site_id AS siteID,
          	type_name AS item_type,
            contractor_name AS contractorName,
            contractor_phone AS contractorPhone,
            contract_notes as contractNotes,
          	intervals_name AS intervalName,
          	COALESCE(
              (SELECT service_date FROM services
                WHERE service_item=item_id LIMIT 1), '1970-01-01') AS lastService,
          	COALESCE(
              DATE_ADD(
                COALESCE(
                  (SELECT service_date FROM services WHERE service_item=item_id LIMIT 1)
                  , '1970-01-01'), INTERVAL intervals_months MONTH)
                  , '2038-01-01') AS nextService,
            DATEDIFF(
              COALESCE(
                DATE_ADD(
                  COALESCE(
                    (SELECT service_date FROM services WHERE service_item=item_id LIMIT 1)
                    , '1970-01-01'), INTERVAL intervals_months MONTH), '2038-01-01')
                    , CURDATE()) AS daysUntilService,
            COALESCE(contract_end, '1970-01-01') AS contractEnd,
            DATEDIFF(COALESCE(contract_end, '1970-01-01'), CURDATE()) as contractLeft,
          	item_name AS item_name,
          	item_notes AS notes,
            COALESCE(
              (SELECT
                CONCAT(
                  GROUP_CONCAT(CONCAT(service_date, '\r\n', service_notes) SEPARATOR '\r\n\r\n'), '\r\n'
                ) FROM services WHERE service_item=item_id
              ),
              'No service history.'
            ) AS service_history
          FROM items
          INNER JOIN sites ON item_site=site_id
          INNER JOIN locations ON item_location=location_id
          INNER JOIN item_types ON item_type=type_id
          INNER JOIN intervals ON item_interval=intervals_id
          INNER JOIN contracts ON item_contract=contract_id
          INNER JOIN contractors ON contract_contractor=contractor_id
          WHERE site_id=:site";
  $statement = $dbc->prepare($sql);
  $sitesData = array();
  foreach ($sites as $site) {
    $statement->bindValue(':site', $site['site_id'], PDO::PARAM_INT);
    $result = $statement->execute();
    $sitesData[$site['site_id']] = array('name'=>$site['site_name'], 'data'=> $statement->fetchAll());
  }

  $tpl = new Smarty;
  $tpl->template_dir = getcwd() . '/templates/';
  $tpl->compile_dir  = getcwd() . '/templates/cache/';
  $tpl->assign('sites', $sitesData);
  $tpl->assign('title', 'Servicing');
  $tpl->display('servicing/services.tpl');
?>