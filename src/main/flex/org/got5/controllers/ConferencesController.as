package org.got5.controllers
{
  import org.flexmvc.view.DestinationViewVO;
  import org.got5.services.IConferenceService;
  import org.got5.views.DetailView;
  
  import spark.components.List;
  import spark.components.TextInput;
  
  /** ConferencesView view controller. */
  public class ConferencesController
  {
    /** Conferences service. */
    [Inject]
    public var conferenceService:IConferenceService;
    
    /** Conferences list, from view. */
    [Component]
    public var lstConferences:List;
    
    /** Search field. */
    [Component]
    public var txtSearch:TextInput;
    
    /** Handler on clic onbtnSearch */
    public function onClickFromBtnSearch():void {
      lstConferences.dataProvider = conferenceService.findByTitle(txtSearch.text);
    }
    
    /** Handler on change event on list LstConferences. */
    public function onChangeFromLstConferences():DestinationViewVO {
      return new DestinationViewVO(DetailView);
    }
  }
}