GameEvents.Subscribe("create_error_message", function(data) {
        GameEvents.SendEventClientSide("dota_hud_error_message", {
            "splitscreenplayer": 0,
            "reason": data.reason || 80,
            "message": data.message
        })
    })