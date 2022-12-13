"use strict";

function OnCreditsPressed() {
	var panel = $("#CreditsRoot");
	panel.visible = !panel.visible;
	Game.EmitSound("ui_chat_slide_out")
}

function OnCreditsCloseButtonPressed() {
	var panel = $("#CreditsRoot");
	panel.visible = !panel.visible;
	Game.EmitSound("ui.profile_close")
}


function OnLoadEvent(event){
  var plyID = Game.GetLocalPlayerID(); 
  var data = {    
    playerID: plyID, 
    msg: event    
  }
  
  GameEvents.SendCustomGameEventToServer("FastLoadEvent",  data); 
}

function OnSaveEvent(event){
  var plyID = Game.GetLocalPlayerID(); 
  var data = {    
    playerID: plyID, 
    msg: event    
  } 
  
  GameEvents.SendCustomGameEventToServer("FastSaveEvent",  data); 
}

GameEvents.Subscribe('on_player_online_coins', function(data) {

  var coins = data.playerCoins;

  var updateCoin = $("#CoinLabel");
  updateCoin.text = coins;
  
})