package org.got5.controllers
{
  import spark.components.List;
  
  import org.flexmvc.view.DestinationViewVO;
  import org.got5.services.IConferenceService;
  import org.got5.views.DetailView;
  
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
    
    /** Handler on clic on btnSearch */
    public function onClickFromBtnSearch():void {
      lstConferences.dataProvider = conferenceService.findByTitle(text_txtSearch);
    }
    
    /** Handler on change on txtSearch */
    public function onChangeFromTxtSearch():void {
      lstConferences.dataProvider = conferenceService.findByTitle(text_txtSearch);
    }
    
    /** Handler on change event on list LstConferences. */
    public function onChangeFromLstConferences():DestinationViewVO {
      return new DestinationViewVO(DetailView, lstConferences.selectedItem);
    }
  }
}