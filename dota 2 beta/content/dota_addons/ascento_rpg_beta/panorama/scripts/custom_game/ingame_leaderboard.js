var InGameLeaderboardUI = /** @class */ (function () {
    function InGameLeaderboardUI(panel) {
        var _this = this;
        this.panel = panel;
        this.container = this.panel.FindChild("InGameLeaderboard");
        this.container.RemoveAndDeleteChildren();
        this.headerPanel = $.CreatePanel("Panel", this.container, "");
        this.headerPanel.BLoadLayoutSnippet("InGameLeaderboardButtonSnippet");
        this.headerPanelActivator = this.headerPanel.FindChild("Activator");
        this.playersContainer = $.CreatePanel("Panel", this.container, "");
        this.playersContainer.BLoadLayoutSnippet("InGameLeaderboardPlayersContainerSnippet");
        this.receivedCount = 0;
        this.leaderboardData = [];
        this.headerPanelActivator.text = "ON";
        this.headerPanelActivator.RemoveClass("off");
        this.headerPanelActivator.AddClass("on");
        GameEvents.SendCustomGameEventToServer("loot_drop", { option: "on", playerID: Game.GetLocalPlayerID() });

        this.headerPanelActivator.SetPanelEvent("onmouseactivate", function () {
            if (_this.headerPanelActivator.text == "OFF") {
                _this.headerPanelActivator.text = "ON";
                _this.headerPanelActivator.RemoveClass("off");
                _this.headerPanelActivator.AddClass("on");
                GameEvents.SendCustomGameEventToServer("loot_drop", { option: "on", playerID: Game.GetLocalPlayerID() });
            }
            else {
                _this.headerPanelActivator.RemoveClass("on");
                _this.headerPanelActivator.AddClass("off");
                _this.headerPanelActivator.text = "OFF";
                GameEvents.SendCustomGameEventToServer("loot_drop", { option: "off", playerID: Game.GetLocalPlayerID() });
            }
            //send event to game
            if (_this.playersContainer.BHasClass("InGameLeaderboardContainerVisible")) {
                _this.playersContainer.RemoveClass("InGameLeaderboardContainerVisible");
            }
            else {
                _this.playersContainer.AddClass("InGameLeaderboardContainerVisible");
            }
        });
        $.Msg(panel); // Print the panel
    }
    return InGameLeaderboardUI;
}());
var ui = new InGameLeaderboardUI($.GetContextPanel());


GameEvents.Subscribe('hide_hero_stats_panel', function(data) {

  var updateVisible = $("#Activator");
      updateVisible.visible = false
    
  })
