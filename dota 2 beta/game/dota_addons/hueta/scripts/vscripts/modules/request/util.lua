local __request_util = class({
	PlayerEach	= function(callback)
		if not callback then print('Not Callback Function!')  return end
		for i = 0, DOTA_MAX_PLAYERS - 1 do
			if PlayerResource:IsValidPlayer(i) then
				callback(i)
			end
		end
	end,
	
	IsBot 		= function(pID)
		return PlayerResource:GetSteamAccountID(pID) < 1000
	end,

	RequestData	= function(url,data,callback)
	DeepPrintTable (data);
	    local req = CreateHTTPRequestScriptVM('POST', request.__http .. url)
		req:SetHTTPRequestGetOrPostParameter("data", json.encode(data) )
		req:SetHTTPRequestGetOrPostParameter("__authKey", request.__authKey )
		req:SetHTTPRequestGetOrPostParameter("version", json.encode(version) )
	--	req:SetHTTPRequestGetOrPostParameter("SteamID",  json.encode(PlayerResource:GetSteamID(i)) )
		req:Send(function(response)
	        if response.StatusCode ~= 200 then  
	        	print("Error, Status code = ",response.StatusCode) 
				print('Route:' .. request.__http .. url)
	        	return 
	        end 
			print('request response')
			
			if (callback) then
				local obj, pos, err = json.decode(response.Body)
				if not obj or type(obj) ~= "table" or obj == '' then 
					print("Error, object not found, obj = '" .. tostring(obj) .. "' type = ",type(obj))
					DeepPrintTable(response) 
					return 
				end
				if obj and type(obj) == "table" then
					callback(obj)
					DeepPrintTable (obj);
				end

			end
	    end)
	end,
})


return __request_util
