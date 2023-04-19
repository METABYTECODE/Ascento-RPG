local newApi = "https://ascento.tk/api2/discord"
local onlineApi = "https://ascento.tk/api2/"

local webkey = GetDedicatedServerKeyV2("web")
if webkey == "Invalid_NotOnDedicatedServer" then
  webkey = "TestServerKey"
end

local version = "ascento_5"

function LoadDataWeb(data, callback)    
  local req = CreateHTTPRequestScriptVM("GET", onlineApi)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("action", "load")
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("data", json.encode(data))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(res.Body)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end

function FirstLoadDataWeb(data, callback)    
  local req = CreateHTTPRequestScriptVM("GET", onlineApi)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "firstload")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("data", json.encode(data))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          --PrintTable(res.Body)
          callback(res.Body)
      else
          --PrintTable(res.Body)
          callback(res.Body)
      end
  end)
end

function TopLoadDataWeb(data, callback)    
  local req = CreateHTTPRequestScriptVM("GET", onlineApi)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "topload")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("data", json.encode(data))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          --PrintTable(res.Body)
          callback(res.Body)
      else
          --PrintTable(res.Body)
          callback(res.Body)
      end
  end)
end

function DonatesLoadDataWeb(data, callback)    
  local req = CreateHTTPRequestScriptVM("GET", onlineApi)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "donates")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("data", json.encode(data))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(res.Body)
          --print(res.StatusCode)
      else
          callback(res.Body)
          --PrintTable(res.Body)
      end
  end)
end

function SaveDataWeb(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", onlineApi)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "save")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("data", json.encode(data))
  --print("Encode data: "..json.encode(data))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(res.Body)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end


function WinGameDataWeb(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", onlineApi)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "win")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("data", json.encode(data))
  --print("Encode data: "..json.encode(data))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(res.Body)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end


function OnlineDataWeb(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", onlineApi)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("action", "online")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("data", json.encode(data))
  --print("Encode data: "..json.encode(data))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(res.Body)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end


function FromDiscordMessage(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", newApi)
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("action", "discord")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  --print("Encode data: "..json.encode(data))
  req:Send(function(res)
      if res.StatusCode == 200 then
          callback(res.Body)
          --print(res.Body)
      else
        callback(res.Body)
        --print(res.Body)
        --print(res.Body)
      end
  end)
end


function ToDiscordMessage(steamid, text)
  local req = CreateHTTPRequestScriptVM("GET", newApi)
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("action", "todiscord")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("steamid", steamid)
  req:SetHTTPRequestGetOrPostParameter("text", text)
  req:Send(nil)
end
