<?php
require __DIR__ . '/../vendor/autoload.php';
session_save_path('.\sessions');
session_start();
if ($debug) {
  error_reporting(E_ALL);
  ini_set('display_errors', 'On');
}
define('BASEPATH', $_SERVER['DOCUMENT_ROOT']);
$connections = array();
include('config.php');

function makeConnection($connection_name = ''){
  global $connections;
  if($connection_name == '') {
    return "No connection type given";
    exit;
  }
  unset($db);
  $driver=$connections[$connection_name]['driver'];
  $dbhost=$connections[$connection_name]['dbhost'];
  $dbname=$connections[$connection_name]['dbname'];
  $dbuser=$connections[$connection_name]['dbuser'];
  $dbpassword=$connections[$connection_name]['dbpassword'];
  if (strlen($dbhost) > 0) {
    try {
      if($driver=="mysql"){
        $db = new PDO("$driver:host=$dbhost;dbname=$dbname", $dbuser, $dbpassword);
      }else{
        $db = new PDO("$driver:SERVER=$dbhost;DATABASE=$dbname", $dbuser, $dbpassword);
      }
      $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
      echo $e->getMessage();
    }
  }
  return $db;
}
