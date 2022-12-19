var isDangerous = false
var nowDangerousImage = 1
var dangerousSchedule
let parent = $.GetContextPanel()

function monster_round(data) {

    var Lable_number = $("#MonsterRound")
    Lable_number.text = data.str
}

function monster_number_changing(data) {
    if (parent.FindChildTraverse("MonsterRoot").BHasClass("Hide")) {
        parent.FindChildTraverse("MonsterRoot").RemoveClass("Hide")
    }
    var maxNum = data["maxNum"]
    var liveNum = data["liveNum"]
    var numShow = liveNum + "/" + maxNum
    var endImageRate = 0.87
    parent.FindChildTraverse("MaxNum").text = numShow
    var livePercent = parseInt(liveNum) / parseInt(maxNum) * 100
    if (livePercent < 10) {
        isDangerous = false
        endImageRate = 0.8
    } else if (livePercent < 80) {
        isDangerous = false
        endImageRate = 0.95
    } else {
        endImageRate = 0.95
        isDangerous = false
    }
    var width = livePercent + "%"
    parent.FindChildTraverse("MonsterProgressBar").style.width = width
    var endPangeWidth = (livePercent * endImageRate) + "%"
    parent.FindChildTraverse("ProgressEnd").style.position = endPangeWidth + " 5px 0"
}

function SwitchBackgroudImage() {
    parent.FindChildTraverse("ProgressEndImg_nofire").style.opacity = 1
    if (isDangerous) {
        if (nowDangerousImage == 1) {
            parent.FindChildTraverse("ProgressEndImg_s_fire").style.opacity = 1
            parent.FindChildTraverse("ProgressEndImg_b_fire").style.opacity = 0
            parent.FindChildTraverse("MonsterProgressBarDangerous").style.opacity = 0
            nowDangerousImage = 2
        } else if (nowDangerousImage == 2) {
            nowDangerousImage = 1
            parent.FindChildTraverse("ProgressEndImg_s_fire").style.opacity = 0
            parent.FindChildTraverse("ProgressEndImg_b_fire").style.opacity = 1
            parent.FindChildTraverse("MonsterProgressBarDangerous").style.opacity = 1
        }
    } else {
        parent.FindChildTraverse("ProgressEndImg_s_fire").style.opacity = 0
        parent.FindChildTraverse("ProgressEndImg_b_fire").style.opacity = 0
        parent.FindChildTraverse("MonsterProgressBarDangerous").style.opacity = 0
    }
    $.Schedule(0.3, SwitchBackgroudImage)
}


function MonsterBossChange(params) {
    // var tPlayerID = Players.GetLocalPlayer()
    // var bossNameDesc = params["bossName"]
    // if (tPlayerID == parseInt(params["playerID"])) {
    //     $("#BossName").text = $.Localize("#" + bossNameDesc)
    // }
}

GameEvents.Subscribe("monster_round", monster_round);
GameEvents.Subscribe("monster_number_changing", monster_number_changing);

GameEvents.Subscribe("GameBegin", () => {
    parent.FindChildTraverse("MonsterRoot").AddClass("Show")
    SwitchBackgroudImage()
});