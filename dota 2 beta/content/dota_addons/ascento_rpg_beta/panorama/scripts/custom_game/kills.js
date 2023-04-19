var KillsUI = /** @class */ (function () {
    function KillsUI(panel) {
        this.panel = panel;
        this.container = this.panel.FindChild("Kills");
        this.container.RemoveAndDeleteChildren();
        this.header = this.panel.FindChild("Header");
        this.instructions = this.panel.FindChild("Instructions");
        this.discord = this.instructions.FindChild("Discord");
        this.hasVotedText = this.instructions.FindChild("HasVoted");
        this.hasVotedText.visible = false;
        this.discord.SetPanelEvent("onmouseactivate", function () {
            $.DispatchEvent('ExternalBrowserGoToURL', 'https://discord.gg/DXSh4Snhgm');
        });
        this.header.text = $.Localize("#difficulty_select");
        this.timerPanel = new KillsSelection(this.container, $.Localize("#difficulty_easy"), "Easy");
        this.timerPanel2 = new KillsSelection(this.container, $.Localize("#difficulty_normal"), "Normal");
        this.timerPanel3 = new KillsSelection(this.container, $.Localize("#difficulty_hard"), "Hard");
        this.timerPanel4 = new KillsSelection(this.container, $.Localize("#difficulty_unfair"), "Unfair");
        this.timerPanel6 = new KillsSelection(this.container, $.Localize("#difficulty_impossible"), "Impossible");
        this.timerPanel5 = new KillsSelection(this.container, $.Localize("#difficulty_infinity"), "HELL");
        this.timerPanel5 = new KillsSelection(this.container, $.Localize("#difficulty_hardcore"), "HARDCORE");
        /// wave
        $.Msg(panel); // Print the panel
    }
    return KillsUI;
}());
var ui = new KillsUI($.GetContextPanel());
