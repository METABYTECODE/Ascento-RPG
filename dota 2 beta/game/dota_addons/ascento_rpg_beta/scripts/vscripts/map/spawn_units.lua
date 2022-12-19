function Ui_SpawnALLUnits(keys)
	
		local unit_name = keys.SpawnUnitName
		local spawn_point = keys.SpawnUnitOrigin
		print(unit_name)
		print(spawn_point)
		local unit = CreateUnitByName(unit_name, (spawn_point + RandomVector( RandomFloat( 0, 50))), true, nil, nil, DOTA_TEAM_BADGUYS)
	
end