package org.got5.services
{
  import mx.collections.ArrayCollection;

  public interface IConferenceService
  {
    function findByTitle(pTitle:String):ArrayCollection;
  }
}