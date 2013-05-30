package org.got5.services
{
  import mx.collections.ArrayCollection;
  
  import org.got5.model.Conference;

  public interface IConferenceService
  {
    function findByTitle(pTitle:String):ArrayCollection;
    
    function addConference(pConf:Conference):void;
    
    function updateConference(pConf:Conference):void;
    
    function deleteConference(pConf:Conference):void;
  }
}