<?php

class Db {
    
    protected $con;
    //Setting the database parameters 
    private $host = "eu-cdbr-azure-north-e.cloudapp.net";
    private $user = "bd80b4620f7590";
    private $pwd = "f82b669d";
    private $db = "acsm_ff9a877681889df";
    
    //Creates a PDO conection & sets error mode to exceptions
    public function __construct(){
    
        try { 
            $this->con = new PDO("mysql:host=$this->host;dbname=$this->db", $this->user, $this->pwd); 
            $this->con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
            $this->con->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
        } 
        catch(PDOException $e) { 
            echo $e->getMessage();
        }
        
    }
    
    //sets the datab to null
    public function disconnect() {
        
        $this->con = null;
        
    }

    //Create table notes in the database
    public function createTable() {
        try {
            $sql = "CREATE TABLE IF NOT EXISTS notes (
                       id INT(11) AUTO_INCREMENT,
                       last_modified TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       content text,
                       PRIMARY KEY(id)
                    );";
            $this->con->query($sql);
            return true;
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    //Drop table notes from the database
    public function dropTable() {
        try {
            $sql = "DROP TABLE notes;";
            $this->con->query($sql);
            return true;
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    //Create a new entry in the table notes
    public function createNote($content) {
        try {
            $query = $this->con->prepare("INSERT INTO notes (content) VALUES (:content);");
            $query->bindParam(':content', $content);
            $query->execute();
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    //Retrieve all notes from the database to be displayed
    public function getNotes() {
        try{
            $query = $this->con->prepare("SELECT * FROM notes ORDER BY last_modified DESC;");
            $query->execute();
            return $query->fetchAll();
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    //Retrieve the note with the minimum id
    public function getMinId() {
        try{
            $query = $this->con->prepare("SELECT min(id) FROM notes;");
            $query->execute();
            return $query->fetch()[0];
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    //Retrieve the note with the maximum id
    public function getMaxId() {
        try{       
            $query = $this->con->prepare("SELECT max(id) FROM notes;");
            $query->execute();
            return $query->fetch()[0];
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    //Check if the note which has this id is available in the database
    public function isValid($id) {
        try{
            $query = $this->con->prepare("SELECT * FROM notes WHERE id = :id;");
            $query->bindParam(':id', $id);
            $query->execute();
            return count($query->fetchAll()) > 0;
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    //Delete note from the database 
    public function deleteNote($id) {
        try{          
            $query = $this->con->prepare("DELETE FROM notes WHERE id = :id;");
            $query->bindParam(':id', $id);
            $query->execute();
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }

    //Update note with new content provided by the user
    public function updateNote($id, $newContent) {
        try{
            $query = $this->con->prepare("UPDATE notes
                                           SET content = :content,
                                               last_modified = CURRENT_TIMESTAMP
                                           WHERE id = :id");
            $query->bindParam(':id', $id);
            $query->bindParam(':content', $newContent);
            $query->execute();
        } catch (PDOException $e) {
            echo $e->getMessage();
        }
    }
    
}
?>