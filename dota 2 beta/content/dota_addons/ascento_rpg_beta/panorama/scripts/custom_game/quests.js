GameEvents.Subscribe('quest_interacted', QuestInteraction);

var PlayerTables 	= GameUI.CustomUIConfig().PlayerTables 										// PlayerTables kullanmak için
var playerId 		= Game.GetLocalPlayerID();
var heroId 			= Players.GetPlayerHeroEntityIndex(playerId);							
var playerQuests	= 'player_' + playerId + '_taken';											// Table ismi
var mainPanel 		= $.GetContextPanel().GetParent()											// En üstteki panel.
var qPanels 		= {}

PlayerTables.SubscribeNetTableListener(playerQuests, OnQuestTableChange)
/*----------------------------------------------------------------- Q.TABLE EVENTS -----------------------------------------------------------------*/
function OnQuestTableChange(playerQuests, changes, deletions){

	if (Object.keys(changes).length != 0){
		var quest 		= changes[Object.keys(changes)[0]]
		var questTitle 	= quest.title
		var questObj 	= quest.objectives
		var questCur 	= questObj["current"]
		var questReq 	= questObj["required"]
		var questAction = questObj["action"][0].toUpperCase()+questObj["action"].substring(1)
		var questObject = questObj["object"][0]+questObj["object"].substring(1)
		var qPanel 		= qPanels[Object.keys(changes)[0]]
			qPanel.FindChildTraverse('SideQuestTitleLabel').text = questTitle

		if (questAction == "Talk"){
			qPanel.FindChildTraverse('ProgressBarInfo').text = questAction + " with " + questObject
		} else if (questAction == "Collect"){
			var uText = questObject.substring(5)[0].toUpperCase()
			var rText = questObject.substring(6).replace(new RegExp("_", 'g'), () => " ")
			qPanel.FindChildTraverse('ProgressBarInfo').text = questAction + " " + questReq + " " + uText+rText
		} else if (questAction == "Kill"){
			qPanel.FindChildTraverse('ProgressBarInfo').text = questAction + " " + questReq + " " + $.Localize("#" + questObject)
		}

		if (questReq >= 1){
			qPanel.FindChildTraverse("ProgressBarObjectives").text = questCur +  " / " + questReq;
		}
		if (questCur >= questReq){
			qPanel.FindChildTraverse("ProgressBarInfo").text = "Take your reward";
			Game.EmitSound("SCAN_MINIMAP.ACTIVATE")
		}
		qPanel.FindChildTraverse("ProgressBarBackground").style.width = (questCur/questReq)*100 + "%";
	}
}
/*----------------------------------------------------------------- Q.TABLE EVENTS -----------------------------------------------------------------*/
/*----------------------------------------------------------------- INTERACTION -----------------------------------------------------------------*/
function QuestInteraction(data){

	quest 			= data
	var questTitle 	= quest.title
	var questDesc 	= quest.description
	var questGold 	= quest.rewards.gold
	var questXP 	= quest.rewards.experience
	var questObj 	= quest.objectives
	var questAction = questObj["action"][0].toUpperCase()+questObj["action"].substring(1)
	var questObject = questObj["object"][0]+questObj["object"].substring(1)
	var questReq 	= questObj["required"]
	var questCur 	= questObj["current"]

	mainPanel.FindChildTraverse('TitleLabel').text 						= questTitle
	mainPanel.FindChildTraverse('DescriptionLabel').text 				= questDesc
	mainPanel.FindChildTraverse('GoldLabel').text 						= "Gold: " + questGold
	mainPanel.FindChildTraverse('XPLabel').text 						= "XP: " + questXP
	mainPanel.FindChildTraverse('InteractionPanel').style.visibility	= "visible";

	Game.EmitSound("SHOP.PANELUP")

	if (questAction == "Talk"){
		mainPanel.FindChildTraverse('ObjectivesLabel').text = questAction + " with " + questObject
	} else if (questAction == "Collect"){
		var uText = questObject.substring(5)[0].toUpperCase()
		var rText = questObject.substring(6).replace(new RegExp("_", 'g'), () => " ")
		mainPanel.FindChildTraverse('ObjectivesLabel').text = questAction + " " + questReq + " " + uText+rText
	} else if (questAction == "Kill"){
		mainPanel.FindChildTraverse('ObjectivesLabel').text = questAction + " " + questReq + " " + $.Localize("#" + questObject)
	}

	if (questCur >= questReq){
		mainPanel.FindChildTraverse('CompleteButton').style.visibility 	= "visible"
		mainPanel.FindChildTraverse('AcceptButton').style.visibility 	= "collapse"
	}
	else{
		mainPanel.FindChildTraverse('CompleteButton').style.visibility 	= "collapse"
		mainPanel.FindChildTraverse('AcceptButton').style.visibility 	= "visible"
	}
}
/*----------------------------------------------------------------- INTERACTION -----------------------------------------------------------------*/
/*----------------------------------------------------------------- ACCEPT QUEST -----------------------------------------------------------------*/

function AcceptQuest(){

	var panel 		= $.CreatePanel ('Panel', $('#SideQuestPanel'), 'ProgressPanel');
		panel.BLoadLayoutSnippet("ProgressPanelSnippet")
		qPanels[quest.qId] = panel

	mainPanel.FindChildTraverse('InteractionPanel').style.visibility 	= "collapse";
	GameEvents.SendCustomGameEventToServer("quest_accepted", {quest})
	Game.EmitSound("MINIMAP_RADAR.TARGET")
}
/*----------------------------------------------------------------- ACCEPT QUEST -----------------------------------------------------------------*/
/*----------------------------------------------------------------- COMPLETE QUEST -----------------------------------------------------------------*/
function CompleteQuest(){
	mainPanel.FindChildTraverse('InteractionPanel').style.visibility = "collapse"
	qPanels[quest.qId].DeleteAsync(0)
	GameEvents.SendCustomGameEventToServer("quest_completed", {quest})
	Game.EmitSound("GENERAL.COINS")
}
/*----------------------------------------------------------------- COMPLETE QUEST -----------------------------------------------------------------*/
/*----------------------------------------------------------------- DECLINE QUEST -----------------------------------------------------------------*/
function DeclineQuest(){
	mainPanel.FindChildTraverse('InteractionPanel').style.visibility = "collapse"
	Game.EmitSound("SHOP.PANELUP")
}
/*----------------------------------------------------------------- DECLINE QUEST -----------------------------------------------------------------*/
