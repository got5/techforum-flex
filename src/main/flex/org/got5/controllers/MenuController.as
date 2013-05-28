package org.got5.controllers
{
  import org.flexmvc.constants.SymbolConstantsValues;
  import org.got5.services.IConferenceService;
  import org.got5.views.ConferencesView;
  import org.got5.views.MapView;
  
  /** MenuView Controller */
  public class MenuController
  {
    [Symbol]
    public var productionMode:String;
    
    /** Called on INITIALIZE event. */
    [SetupRender]
    public function initMenu():void
    {
      if (productionMode == SymbolConstantsValues.DEVELOPMENT) {
        trace('[DEBUG] Function initMenu() from MainView called on SetupRender phase.');
      }
    }
    
    /** Handler on btnConferences button click. */
    [OnEvent(value="click", component="btnConferences")]
    public function gotoConferences():Class {
      //Redirects to ConferencesView.
      return ConferencesView;
    }
    
    /** Handler on btnMap button click. */
    public function onClickFromBtnMap():Class {
      return MapView;
    }
    
    /** Called on VIEW_DEACTIVATE event. */
    [CleanupRender]
    public function quitMenu():void {
      if (productionMode == SymbolConstantsValues.DEVELOPMENT) {
        trace('[DEBUG] Function quitMenu() from MainView called on CleanupRender phase.');
      }
    }
  }
}