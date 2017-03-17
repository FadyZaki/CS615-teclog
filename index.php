<?php
error_reporting(-1);
ini_set('display_errors', 'On');

require_once "lib/Smarty.class.php";
require_once "database.php";

//connect to our db
$db = new Db();

//Using 'ACTIVE_NODE_ID' cookie to decide which Note should be displayed to the user 
if(isset($_COOKIE['ACTIVE_NOTE_ID'])) {
    if(!$db->isValid($_COOKIE['ACTIVE_NOTE_ID'])) {
        setcookie("ACTIVE_NOTE_ID", $db->getMaxId());
        $activeNoteId = $db->getMaxId();
    } else {
        $activeNoteId = $_COOKIE['ACTIVE_NOTE_ID'];
    }
}
  
//Added this statement to set the activeNodeId by the max Id in the database 
//if the ACTIV_NODE_ID cookie is not available
else {
    setcookie("ACTIVE_NOTE_ID", $db->getMaxId());
    $activeNoteId = $db->getMaxId();
}

//Decide what the application should do based on the 'action' parameter sent in the request
if(isset($_REQUEST['action'])) {
    switch($_REQUEST['action']) {
        //Delete the current note
        case 'delete':
            if($activeNoteId){
            $db->deleteNote($activeNoteId);
            $newId = $db->getMaxId();
            setcookie("ACTIVE_NOTE_ID", $newId);
            $activeNoteId = $newId;
            }
            break;
        //Update the current note with the text area content
        case 'update':
            if($activeNoteId){
            $db->updateNote($_COOKIE['ACTIVE_NOTE_ID'], $_REQUEST['content']);
            }
            break;
        //Create a new Note
        case 'new':
            $db->createNote("New note.");
            $newId = $db->getMaxId();
            setcookie("ACTIVE_NOTE_ID", $newId);
            $activeNoteId = $newId;
            break;
        //Navigate the note selected by the user
        case 'navigate':
            setcookie("ACTIVE_NOTE_ID", $_REQUEST['id']);
            $activeNoteId = $_REQUEST['id'];
            break;
    }
}

$template = new Smarty();

if(isset($activeNoteId))
    $template->assign("ACTIVE_NOTE_ID", $activeNoteId);
//Retrieve all notes from the database
$template->assign("notes", $db->getNotes());
//Display the application UI
$template->display('index.tpl');

//disconnect
$db->disconnect();
?>