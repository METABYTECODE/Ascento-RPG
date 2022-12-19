

var rootPanel = $("#OnlineTable");


GameEvents.Subscribe('on_player_online_save', function(data) {

  var playersOnlineNow = data.playersOnlineNow;
  
  var playersOnlineNowEasy = data.playersOnlineNowEasy;
  var playersOnlineNowNormal = data.playersOnlineNowNormal;
  var playersOnlineNowHard = data.playersOnlineNowHard;
  var playersOnlineNowUnfair = data.playersOnlineNowUnfair;
  var playersOnlineNowImpossible = data.playersOnlineNowImpossible;
  var playersOnlineNowHell = data.playersOnlineNowHell;
  var playersOnlineNowHardcore = data.playersOnlineNowHardcore;
  
  var updateOnline = $("#PlayersOnline");
  updateOnline.text = "Online: " + playersOnlineNow;
  
  var updateOnline = $("#PlayersOnlineEasy");
  updateOnline.text = playersOnlineNowEasy;
  
  var updateOnline = $("#PlayersOnlineNormal");
  updateOnline.text = playersOnlineNowNormal;
  
  var updateOnline = $("#PlayersOnlineHard");
  updateOnline.text = playersOnlineNowHard;
  
  var updateOnline = $("#PlayersOnlineUnfair");
  updateOnline.text = playersOnlineNowUnfair;
  
  var updateOnline = $("#PlayersOnlineImpossible");
  updateOnline.text = playersOnlineNowImpossible;
  
  var updateOnline = $("#PlayersOnlineHell");
  updateOnline.text = playersOnlineNowHell;
  
  var updateOnline = $("#PlayersOnlineHardcore");
  updateOnline.text = playersOnlineNowHardcore;


})



function ShowAllOnlinePlayers(event){

  var updateVisible = $("#OnlineTableFull");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }else{
    updateVisible.visible = true
  }
  
}


GameEvents.Subscribe('hide_hero_stats_panel', function(data) {

  var updateVisible = $("#OnlineTable");
      updateVisible.visible = false
    
  })

