package org.got5.model
{
	public class Conference
	{
    public var id:int;
    
    public var title:String;
    
    public var description:String;
    
    public var category:String;
    
    public var room:String;
    
    public var day:String;
    
    public var speaker:String;
    
		public function Conference(pId:int, pTitle:String = null, pDescription:String = null, pCat:String = null, 
                               pRoom:String = null, pDay:String = null, pSpeaker:String = null)
		{
      id = pId;
      title = pTitle;
      description = pDescription;
      category = pCat;
      room = pRoom;
      day = pDay;
      speaker = pSpeaker;
		}
	}
}