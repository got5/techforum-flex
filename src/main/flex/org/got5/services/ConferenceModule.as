package org.got5.services
{
  import org.flexmvc.constants.SymbolConstants;
  import org.flexmvc.constants.SymbolConstantsValues;
  import org.flexmvc.core.BaseModule;
  import org.flexmvc.utils.HashMap;
  import org.got5.controllers.ConferencesController;
  import org.got5.controllers.DetailController;
  import org.got5.controllers.MapController;
  import org.got5.controllers.MenuController;
  import org.got5.views.ConferencesView;
  import org.got5.views.DetailView;
  import org.got5.views.MapView;
  import org.got5.views.MenuView;
  
  public class ConferenceModule extends BaseModule
  {
    override public function get views():Array /* of Class */ {
      return [ MenuView, ConferencesView, MapView, DetailView ];
    }
    
    override public function get controllers():Array /* of Class */ {
      return [ MenuController, ConferencesController, MapController, DetailController ];
    }
    
    override public function contributeApplicationDefaults(pConstantsMap:HashMap):void {
      super.contributeApplicationDefaults(pConstantsMap);
      
      //Default application view.
      pConstantsMap.put(SymbolConstants.FIRST_VIEW, MenuView);
      
      pConstantsMap.put(SymbolConstants.PRODUCTION_MODE, SymbolConstantsValues.DEVELOPMENT);
    }
    
    /** Used to store the services. The key is the service interface, the value is the implementation. */
    override public function bindServices(pServicesMap:HashMap):void {
      pServicesMap.put(IConferenceService, ConferenceService);
    }
  }
}