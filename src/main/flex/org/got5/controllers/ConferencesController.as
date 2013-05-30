package org.got5.controllers
{
  import org.flexmvc.view.DestinationViewVO;
  import org.got5.model.Conference;
  import org.got5.services.IConferenceService;
  import org.got5.views.DetailView;
  import org.got5.views.MenuView;
  
  import spark.components.List;
  
  /** ConferencesView view controller. */
  public class ConferencesController
  {
    /** Conferences service. */
    [Inject]
    public var conferenceService:IConferenceService;
    
    /** Conferences list, from view. */
    [Component]
    public var lstConferences:List;
    
    /** Search field value. */
    [ComponentProperty]
    public var text_txtSearch:String;
    
    /** Search criteria, saved when the view is destroyed. */
    [Persist]
    [ComponentProperty(component='txtSearch', property='text')]
    public var searchCriteria:String;
    
    /** Called when the view is displayed. */
    [SetupRender]
    public function initCriteria():void {
      //If thera was a previous search, we did it again.
      lstConferences.dataProvider = conferenceService.findByTitle(searchCriteria);
    }
    
    /** Handler on clic on btnDelete */
    public function onClickFromBtnDelete():void {
      if (lstConferences.selectedItem is Conference) {
        conferenceService.deleteConference(lstConferences.selectedItem as Conference);
        
        //Refresh the list
        lstConferences.dataProvider = conferenceService.findByTitle(text_txtSearch);
      }
    }
    
    /** Handler on change on txtSearch */
    public function onChangeFromTxtSearch():void {
      lstConferences.dataProvider = conferenceService.findByTitle(searchCriteria);
    }
    
    /** Returns to Main Menu view. */
    public function onClickFromBtnReturn():Class {
      return MenuView;
    }
    
    /** Handler on clic on btnDetail. */
    public function onClickFromBtnDetail():DestinationViewVO {
      return new DestinationViewVO(DetailView, lstConferences.selectedItem);
    }
  }
}