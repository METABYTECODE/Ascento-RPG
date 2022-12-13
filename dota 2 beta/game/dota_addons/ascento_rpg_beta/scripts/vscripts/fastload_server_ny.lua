local url = "http://ascento.tk/api/"

local webkey = GetDedicatedServerKeyV2("web")
if webkey == "Invalid_NotOnDedicatedServer" then
  webkey = "TestServerKey"
end

local version = "ascento_5"



function WinEventDataWeb(data, callback)
  local req = CreateHTTPRequestScriptVM("GET", url)
  local mode = KILL_VOTE_RESULT:upper()
  req:SetHTTPRequestGetOrPostParameter("key", webkey)
  req:SetHTTPRequestGetOrPostParameter("difficulty", mode)
  req:SetHTTPRequestGetOrPostParameter("gametime", tostring(GameRules:GetGameTime()))
  req:SetHTTPRequestGetOrPostParameter("match_id", tostring(GameRules:Script_GetMatchID()))
  req:SetHTTPRequestGetOrPostParameter("action", "nyevent")
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
