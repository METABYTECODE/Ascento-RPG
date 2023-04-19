GameEvents.Subscribe('on_player_stats_update_creeps', function(data) {

var DataForUpdate = data.playerKilledCreeps;
var updateString = $("#KillCreeps");
  updateString.text = DataForUpdate;
  })

GameEvents.Subscribe('on_player_stats_update_boss', function(data) {

var DataForUpdate = data.playerKilledBoss;
var updateString = $("#KillBoss");
  updateString.text = DataForUpdate;

})


GameEvents.Subscribe('on_player_stats_update_gametime', function(data) {

var DataForUpdate = data.player_gametime;
var updateString = $("#PlayerGameTime");
  updateString.text = DataForUpdate;

})




GameEvents.Subscribe('on_player_stats_update_easy_win', function(data) {

var DataForUpdate = data.player_easy_win;
var updateString = $("#EasyWins");
  updateString.text = DataForUpdate;

})

GameEvents.Subscribe('on_player_stats_update_normal_win', function(data) {

var DataForUpdate = data.player_normal_win;
var updateString = $("#NormalWins");
  updateString.text = DataForUpdate;

})

GameEvents.Subscribe('on_player_stats_update_hard_win', function(data) {

var DataForUpdate = data.player_hard_win;
var updateString = $("#HardWins");
  updateString.text = DataForUpdate;

})

GameEvents.Subscribe('on_player_stats_update_unfair_win', function(data) {

var DataForUpdate = data.player_unfair_win;
var updateString = $("#UnfairWins");
  updateString.text = DataForUpdate;

})

GameEvents.Subscribe('on_player_stats_update_impossible_win', function(data) {

var DataForUpdate = data.player_impossible_win;
var updateString = $("#ImpossibleWins");
  updateString.text = DataForUpdate;

})

GameEvents.Subscribe('on_player_stats_update_hell_win', function(data) {

var DataForUpdate = data.player_hell_win;
var updateString = $("#HellWins");
  updateString.text = DataForUpdate;

})

GameEvents.Subscribe('on_player_stats_update_hardcore_win', function(data) {

var DataForUpdate = data.player_hardcore_win;
var updateString = $("#HardcoreWins");
  updateString.text = DataForUpdate;

})


GameEvents.Subscribe('on_player_get_endless', function(data) {

var modifierNumber = data.modifierNumber;
var modifierValue = data.modifierValue;
var AllModifiers = data.AllModifiers;
var updateString = $("#Endless_Modifier_" + modifierNumber);
  updateString.text = modifierValue;
  })



GameEvents.Subscribe('on_player_update_all_endless', function(data) {

var AllModifiers = data.AllModifiers;


var updateString = $("#Endless_text_top");
  updateString.text = AllModifiers;

    })


GameEvents.Subscribe('on_player_kill_creeps', function(data) {

var DataForUpdate = data.playerKilledCreeps;
var updateString = $("#PlayerCreepsCurrent");
  updateString.text = DataForUpdate;
  if (DataForUpdate >= data.need_kill_creeps){
    updateString.style.color = "green"
  }else{
    updateString.style.color = "white"
  }
})

GameEvents.Subscribe('on_player_kill_boss', function(data) {

var DataForUpdate = data.playerKilledBoss;
var updateString = $("#PlayerBossCurrent");
  updateString.text = DataForUpdate;
  if (DataForUpdate >= data.need_kill_boss){
    updateString.style.color = "green"
  }else{
    updateString.style.color = "white"
  }

})


GameEvents.Subscribe('on_player_reinc_update', function(data) {


var DataForUpdate = data.player_reincarnation;

var updateString = $("#Reinc_text_top");
  updateString.text = DataForUpdate;



  if (DataForUpdate > 0){
    $("#Reinc_Every_1").style.color = "green"
    $("#Reinc_Every_2").style.color = "green"
    $("#Reinc_1").style.color = "green"
  }

  if (DataForUpdate > 4){
    $("#Reinc_5").style.color = "green"
    $("#Reinc_Every_3").style.color = "green"
  }

  if (DataForUpdate > 9){
    $("#Reinc_10").style.color = "green"
  }

  if (DataForUpdate > 14){
    $("#Reinc_15").style.color = "green"
  }

  if (DataForUpdate > 19){
    $("#Reinc_20").style.color = "green"
  }

  if (DataForUpdate > 24){
    $("#Reinc_25").style.color = "green"
  }

  if (DataForUpdate > 29){
    $("#Reinc_30").style.color = "green"
  }

  if (DataForUpdate > 39){
    $("#Reinc_40").style.color = "green"
  }

  if (DataForUpdate > 49){
    $("#Reinc_50").style.color = "green"
  }

  if (DataForUpdate > 59){
    $("#Reinc_60").style.color = "green"
  }

  if (DataForUpdate > 69){
    $("#Reinc_70").style.color = "green"
  }

  if (DataForUpdate > 79){
    $("#Reinc_80").style.color = "green"
  }

  if (DataForUpdate > 89){
    $("#Reinc_90").style.color = "green"
  }

  if (DataForUpdate > 99){
    $("#Reinc_100").style.color = "green"
  }

  if (DataForUpdate > 124){
    $("#Reinc_125").style.color = "green"
  }

  if (DataForUpdate > 149){
    $("#Reinc_150").style.color = "green"
  }

  if (DataForUpdate > 174){
    $("#Reinc_175").style.color = "green"
  }

  if (DataForUpdate > 199){
    $("#Reinc_200").style.color = "green"
  }

  if (DataForUpdate > 249){
    $("#Reinc_250").style.color = "green"
  }

  if (DataForUpdate > 299){
    $("#Reinc_300").style.color = "green"
  }

  if (DataForUpdate > 349){
    $("#Reinc_350").style.color = "green"
  }

  if (DataForUpdate > 399){
    $("#Reinc_400").style.color = "green"
  }

  if (DataForUpdate > 449){
    $("#Reinc_450").style.color = "green"
  }

  if (DataForUpdate > 499){
    $("#Reinc_500").style.color = "green"
  }

  if (DataForUpdate > 599){
    $("#Reinc_600").style.color = "green"
  }

  if (DataForUpdate > 699){
    $("#Reinc_700").style.color = "green"
  }

  if (DataForUpdate > 799){
    $("#Reinc_800").style.color = "green"
  }

  if (DataForUpdate > 899){
    $("#Reinc_900").style.color = "green"
  }

  if (DataForUpdate > 999){
    $("#Reinc_1000").style.color = "green"
  }

  if (DataForUpdate > 1499){
    $("#Reinc_1500").style.color = "green"
  }

  if (DataForUpdate > 1999){
    $("#Reinc_2000").style.color = "green"
  }

  if (DataForUpdate > 2499){
    $("#Reinc_2500").style.color = "green"
  }

  if (DataForUpdate > 2999){
    $("#Reinc_3000").style.color = "green"
  }

  if (DataForUpdate > 3499){
    $("#Reinc_3500").style.color = "green"
  }

  if (DataForUpdate > 3999){
    $("#Reinc_4000").style.color = "green"
  }

  if (DataForUpdate > 4499){
    $("#Reinc_4500").style.color = "green"
  }

  if (DataForUpdate > 4999){
    $("#Reinc_5000").style.color = "green"
  }

  if (DataForUpdate > 5999){
    $("#Reinc_6000").style.color = "green"
  }

  if (DataForUpdate > 6999){
    $("#Reinc_7000").style.color = "green"
  }

  if (DataForUpdate > 7999){
    $("#Reinc_8000").style.color = "green"
  }

  if (DataForUpdate > 8999){
    $("#Reinc_9000").style.color = "green"
  }

  if (DataForUpdate > 9999){
    $("#Reinc_10000").style.color = "green"
  }

  if (DataForUpdate > 12499){
    $("#Reinc_12500").style.color = "green"
  }

  if (DataForUpdate > 14999){
    $("#Reinc_15000").style.color = "green"
  }

  if (DataForUpdate > 17499){
    $("#Reinc_17500").style.color = "green"
  }

  if (DataForUpdate > 19999){
    $("#Reinc_20000").style.color = "green"
  }

  if (DataForUpdate > 24999){
    $("#Reinc_25000").style.color = "green"
  }

  if (DataForUpdate > 29999){
    $("#Reinc_30000").style.color = "green"
  }

  if (DataForUpdate > 34999){
    $("#Reinc_35000").style.color = "green"
  }

  if (DataForUpdate > 39999){
    $("#Reinc_40000").style.color = "green"
  }

  if (DataForUpdate > 44999){
    $("#Reinc_45000").style.color = "green"
  }

  if (DataForUpdate > 49999){
    $("#Reinc_50000").style.color = "green"
  }

  if (DataForUpdate > 59999){
    $("#Reinc_60000").style.color = "green"
  }

  if (DataForUpdate > 69999){
    $("#Reinc_70000").style.color = "green"
  }

  if (DataForUpdate > 79999){
    $("#Reinc_80000").style.color = "green"
  }

  if (DataForUpdate > 89999){
    $("#Reinc_90000").style.color = "green"
  }

  if (DataForUpdate > 99999){
    $("#Reinc_100000").style.color = "green"
  }

  if (DataForUpdate > 149999){
    $("#Reinc_150000").style.color = "green"
  }

  if (DataForUpdate > 199999){
    $("#Reinc_200000").style.color = "green"
  }

  if (DataForUpdate > 249999){
    $("#Reinc_250000").style.color = "green"
  }

  if (DataForUpdate > 299999){
    $("#Reinc_300000").style.color = "green"
  }

  if (DataForUpdate > 349999){
    $("#Reinc_350000").style.color = "green"
  }

  if (DataForUpdate > 399999){
    $("#Reinc_400000").style.color = "green"
  }

  if (DataForUpdate > 449999){
    $("#Reinc_450000").style.color = "green"
  }

  if (DataForUpdate > 499999){
    $("#Reinc_500000").style.color = "green"
  }

  if (DataForUpdate > 749999){
    $("#Reinc_750000").style.color = "green"
  }

  if (DataForUpdate > 999999){
    $("#Reinc_1000000").style.color = "green"
  }

  })



GameEvents.Subscribe('hide_hero_stats_panel', function(data) {

  var updateVisible = $("#PlayerEndlessShowTable");
      updateVisible.visible = false

  var updateVisible = $("#PlayerStatsShowTable");
      updateVisible.visible = false

  var updateVisible = $("#PlayerReincShowTable");
      updateVisible.visible = false

  var updateVisible = $("#PlayerStatsCurrentCreeps");
      updateVisible.visible = false

  var updateVisible = $("#PlayerStatsCurrentBoss");
      updateVisible.visible = false
    
  })




GameEvents.Subscribe('on_player_reinc_success', function(data) {

  var updateVisible = $("#PlayerReincDoIt");
      updateVisible.visible = false
  })

GameEvents.Subscribe('on_player_reinc_can_reinc', function(data) {

  var updateVisible = $("#PlayerReincDoIt");
      updateVisible.visible = true
  })





GameEvents.Subscribe("Print", function(event) {
    if (event["printtype"] == "all") {
        let t = Object.assign({}, event);
        delete t["printtype"]
        $.Msg(t);
    } else {
        $.Msg(t["txt"]);
    };
});




function ShowPlayerReincTable(event){

  var updateVisible = $("#PlayerReincTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }else{
    updateVisible.visible = true
  }

  var updateVisible = $("#PlayerStatsTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }

  var updateVisible = $("#PlayerEndlessTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }
  
}

function ShowPlayerStatsTable(event){

  var updateVisible = $("#PlayerStatsTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }else{
    updateVisible.visible = true
  }

  var updateVisible = $("#PlayerEndlessTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }

  var updateVisible = $("#PlayerReincTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }
  
}


function ShowPlayerEndlessTable(event){

  var updateVisible = $("#PlayerEndlessTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }else{
    updateVisible.visible = true
  }

  var updateVisible = $("#PlayerStatsTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }

  var updateVisible = $("#PlayerReincTable");
  if (updateVisible.visible == true){
    updateVisible.visible = false
  }
  
}


function DoItPlayerReinc(event){
  
  GameEvents.SendCustomGameEventToServer("ReincEvent", { playerID: Game.GetLocalPlayerID() });
  
}