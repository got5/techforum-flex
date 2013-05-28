package org.got5.services
{
  import flash.data.SQLConnection;
  import flash.data.SQLStatement;
  import flash.filesystem.File;
  
  import mx.collections.ArrayCollection;

  public class ConferenceService implements IConferenceService
  {
    private var _sql:SQLConnection;
    
    public function get sql():SQLConnection
    {
      if (!_sql)
      {
        openDatabase();
      }
      return _sql;
    }
    
    private function openDatabase():void
    {
      var file:File = File.documentsDirectory.resolvePath("Conferences.db");
      _sql = new SQLConnection();
      _sql.open(file);
      
      if (!file.exists)
      {
        createDatabase();
        populateDatabase();
      }
    }
    
    private function createDatabase():void
    {
      var request:String = 
        "CREATE TABLE IF NOT EXISTS conference ( "+
        "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
        "title VARCHAR(50), " +
        "lastName VARCHAR(50), " +
        "title VARCHAR(50), " +
        "department VARCHAR(50), " + 
        "managerId INTEGER, " +
        "city VARCHAR(50), " +
        "officePhone VARCHAR(30), " + 
        "cellPhone VARCHAR(30), " +
        "email VARCHAR(30), " +
        "picture VARCHAR(200))";
      var stmt:SQLStatement = new SQLStatement();
      stmt.sqlConnection = _sql;
      stmt.text = request;
      stmt.execute();	
    }
    
    private function populateDatabase():void
    {
      
    }
    
    public function findByTitle(pTitle:String):ArrayCollection
    {
      return new ArrayCollection([]);
    }
    
    public function ConferenceService()
    {
      
    }
  }
}