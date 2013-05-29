package org.got5.controllers
{
  import org.got5.model.Conference;
  import org.got5.services.IConferenceService;
  import org.got5.views.ConferencesView;
  
  import spark.components.TextInput;

  public class DetailController
  {
    /** Conferences service. */
    [Inject]
    public var conferenceService:IConferenceService;
    
    /** Variable linked to DetailView.data */
    [ComponentProperty(property="data")]
    public var currentConference:Conference;
    
    [Component]
    public var txtTitle:TextInput;
    
    [Component]
    public var txtCategory:TextInput;
    
    [Component]
    public var txtSpeaker:TextInput;
    
    /** Called on Initialize event on view. */
    public function onSetupRender():void {
      if (currentConference) {
        txtTitle.text = currentConference.title;
        txtCategory.text = currentConference.category;
        txtSpeaker.text = currentConference.speaker;
      }
    }
    
    /** Handler on click event on btnSave. */
    public function onClickFromBtnSave():Class {
      if (currentConference) {
        currentConference.title = txtTitle.text;
        currentConference.category = txtCategory.text;
        currentConference.speaker = txtSpeaker.text;
        
        conferenceService.updateConference(currentConference);
      }
      return ConferencesView;
    }
    
    /** Handler on click event on btnReturn. */
    public function onClickFromBtnReturn():Class {
      return ConferencesView;
    }
  }
}