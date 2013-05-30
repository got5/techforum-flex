package org.got5.services
{
  import flash.data.SQLConnection;
  import flash.data.SQLStatement;
  import flash.filesystem.File;
  import flash.filesystem.FileMode;
  import flash.filesystem.FileStream;
  
  import mx.collections.ArrayCollection;
  
  import org.got5.model.Conference;

  public class ConferenceService implements IConferenceService
  {
    private static const DB_FILE_PATH:String = "conferences.db";
    
    private var _sqlConnection:SQLConnection;
    
    public function get sqlConnection():SQLConnection
    {
      if (!_sqlConnection) {
        openDatabase(File.documentsDirectory.resolvePath(DB_FILE_PATH));
      }
      return _sqlConnection;
    }
    
    /** User Service. */
    [Inject]
    public var userService:IUserService;
    
    public function openDatabase(pFile:File):void
    {
      var bDbExists:Boolean = true;
      if (!pFile.exists) {
        bDbExists = false;
      }
      _sqlConnection = new SQLConnection();
      _sqlConnection.open(pFile);
      if (!bDbExists) {
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
        "description VARCHAR(250), " +
        "category VARCHAR(50), " +
        "room VARCHAR(50), " + 
        "day VARCHAR(10), " +
        "speaker VARCHAR(30))";
      
      var stmt:SQLStatement = new SQLStatement();
      stmt.sqlConnection = sqlConnection;
      stmt.text = request;
      stmt.execute();	
    }
    
    private function populateDatabase():void
    {
      var file:File = File.applicationDirectory.resolvePath("conferences.json");
      var stream:FileStream = new FileStream();
      stream.open(file, FileMode.READ);
      var fileContent:String = String(stream.readUTFBytes(stream.bytesAvailable));
      var jsonArray:Object = JSON.parse(fileContent);
      stream.close();
      
      for each (var jsonConf:Object in jsonArray) {
        addConference(new Conference(jsonConf._id, jsonConf.title, null, jsonConf.theme, jsonConf.where, jsonConf.day, jsonConf.author));
      }
    }
    
    public function findByTitle(pTitle:String):ArrayCollection
    {
      var strRequest:String = "SELECT * FROM conference WHERE title LIKE '%" + pTitle + "%' ORDER BY title";
      
      var statement:SQLStatement = new SQLStatement();
      statement.sqlConnection = sqlConnection;
      statement.text = strRequest;
      statement.execute();
      
      var results:Array = statement.getResult().data;
      
      var conferences:Array = [];
      for each (var result:Object in results) {
        conferences.push(new Conference(result.id, result.title, result.description, result.category, 
          result.room, result.day, result.speaker));
      }
      
      return new ArrayCollection(conferences);
    }
    
    public function addConference(pConf:Conference):void {
      var strRequest:String = "INSERT INTO conference (title, description, category, room, day, speaker) VALUES (?, ?, ?, ?, ?, ?)";
      
      var statement:SQLStatement = new SQLStatement();
      statement.sqlConnection = sqlConnection;
      statement.text = strRequest;
      
      statement.parameters[0] = pConf.title;
      statement.parameters[1] = pConf.description;
      statement.parameters[2] = pConf.category;
      statement.parameters[3] = pConf.room;
      statement.parameters[4] = pConf.day;
      statement.parameters[5] = pConf.speaker;
      
      statement.execute();
    }
    
    public function updateConference(pConf:Conference):void {
      var strRequest:String = "UPDATE conference SET title=?, description=?, category=?, room=?, day=?, speaker=? WHERE id=?";
        
      var statement:SQLStatement = new SQLStatement();
      statement.sqlConnection = sqlConnection;
      statement.text = strRequest;
      
      statement.parameters[0] = pConf.title;
      statement.parameters[1] = pConf.description;
      statement.parameters[2] = pConf.category;
      statement.parameters[3] = pConf.room;
      statement.parameters[4] = pConf.day;
      statement.parameters[5] = pConf.speaker;
      statement.parameters[6] = pConf.id;
      
      statement.execute();
    }
    
    public function ConferenceService() {
      
    }
  }
}