var SaveApprovePanels = {};
var LoadApprovePanels = {};


function OnShowLoadApprove(event){
  var plyID = Game.GetLocalPlayerID(); 

  if (LoadApprovePanels.panel != undefined) {
    LoadApprovePanels.panel.DeleteAsync(0);
    delete LoadApprovePanels.panel;
  }

  var ShowLoadApprovePanel = $.CreatePanel('Panel', $('#LoadLoadApproveSnippet'), '');
  LoadApprovePanels.panel = ShowLoadApprovePanel;
  ShowLoadApprovePanel.BLoadLayoutSnippet("LoadApproveSnippet");

}

function OnCancelLoadEvent(event){
  var plyID = Game.GetLocalPlayerID(); 

  LoadApprovePanels.panel.DeleteAsync(0);
  delete LoadApprovePanels.panel; 
  
}

function OnLoadEvent(event){
  var plyID = Game.GetLocalPlayerID(); 
  var data = {    
    playerID: plyID, 
    msg: event    
  }

  LoadApprovePanels.panel.DeleteAsync(0);
  delete LoadApprovePanels.panel; 
  
  GameEvents.SendCustomGameEventToServer("FastLoadEvent",  data); 
}



function OnShowSaveApprove(event){
  var plyID = Game.GetLocalPlayerID(); 

  if (SaveApprovePanels.panel != undefined) {
    SaveApprovePanels.panel.DeleteAsync(0);
    delete SaveApprovePanels.panel;
  }

  var ShowSaveApprovePanel = $.CreatePanel('Panel', $('#LoadSaveApproveSnippet'), '');
  SaveApprovePanels.panel = ShowSaveApprovePanel;
  ShowSaveApprovePanel.BLoadLayoutSnippet("SaveApproveSnippet");

}

function OnCancelSaveEvent(event){
  var plyID = Game.GetLocalPlayerID(); 

  SaveApprovePanels.panel.DeleteAsync(0);
  delete SaveApprovePanels.panel; 
  
}

function OnSaveEvent(event){
  var plyID = Game.GetLocalPlayerID(); 
  var data = {    
    playerID: plyID, 
    msg: event    
  }

  SaveApprovePanels.panel.DeleteAsync(0);
  delete SaveApprovePanels.panel; 
  
  GameEvents.SendCustomGameEventToServer("FastSaveEvent",  data); 
}