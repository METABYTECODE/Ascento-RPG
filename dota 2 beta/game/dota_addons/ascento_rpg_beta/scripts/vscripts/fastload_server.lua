local url = "http://ascento.tk/api/"

local webkey = GetDedicatedServerKeyV2("web")
if webkey == "Invalid_NotOnDedicatedServer" then
  webkey = "TestServerKey"
end

local version = "ascento_5"

function LoadDataWeb(IDList, callback)    
  local req = CreateHTTPRequestScriptVM("GET", url)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("action", "load")
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("list", json.encode(IDList))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(nil, res.StatusCode)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end

function FirstLoadDataWeb(IDList, callback)    
  local req = CreateHTTPRequestScriptVM("GET", url)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "firstload")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("list", json.encode(IDList))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(nil, res.StatusCode)
          --print(res.StatusCode)
      else
          callback(res.Body)
          --PrintTable(res.Body)
      end
  end)
end

function TopLoadDataWeb(IDList, callback)    
  local req = CreateHTTPRequestScriptVM("GET", url)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "topload")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("list", json.encode(IDList))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(nil, res.StatusCode)
          --print(res.StatusCode)
      else
          callback(res.Body)
          --PrintTable(res.Body)
      end
  end)
end

function DonatesLoadDataWeb(IDList, callback)    
  local req = CreateHTTPRequestScriptVM("GET", url)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "donates")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("list", json.encode(IDList))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(nil, res.StatusCode)
          --print(res.StatusCode)
      else
          callback(res.Body)
          --PrintTable(res.Body)
      end
  end)
end

function SaveDataWeb(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", url)
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
          callback(nil, res.StatusCode)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end


function WinGameDataWeb(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", url)
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
          callback(nil, res.StatusCode)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end


function OnlineDataWeb(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", url)
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
          callback(nil, res.StatusCode)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end


function ConsoleTestWeb(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", url)
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("action", "console")
  req:SetHTTPRequestGetOrPostParameter("version", version)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("data", json.encode(data))
  --print("Encode data: "..json.encode(data))
  req:Send(function(res)
      if res.StatusCode ~= 200 then
          callback(nil, res.StatusCode)
          --print(res.StatusCode)
      else
          callback(res.Body)
      end
  end)
end