--------------------------------------------------------------------------------
-- Particles
--------------------------------------------------------------------------------

-- backup original functions
for original,func in pairs(CScriptParticleManager) do
	if not type(func)=="function" then return end
	CScriptParticleManager[ original .. "_Original" ] = CScriptParticleManager[original]
end

if not ParticleManagerExtension then
	ParticleManagerExtension = {}
end

--[[
data:
- name
- attachments
- parent
- status (destroyed/existing)
- control_points
]]
ParticleManagerExtension.references = {}

function ParticleManagerExtension:AddReference( id, data )
	self.references[id] = data
end

function ParticleManagerExtension:GetReference( id )
	return self.references[ id ]
end

function ParticleManagerExtension:RemoveReference( id )
	self.references[ id ] = nil
end

function ParticleManagerExtension:AddControlPoints( id, cp )
	local data = self.references[ id ]
	table.insert( data.control_points, cp )
end

--------------------------------------------------------------------------------
function CScriptParticleManager:CreateParticle( string_1, int_2, handle_3, handle_4 )
	if not handle_4 then handle_4 = handle_3 end

	-- store data
	local data = {}
	data.name = string_1
	data.attach = int_2
	data.parent = handle_3
	data.owner = handle_4
	data.active = true
	data.control_points = {}

	-- check global replacement
	local replace = Cosmetics:GetParticleReplacement( handle_4, string_1 )
	if replace then
		data.name = replace
		data.original_name = string_1
		string_1 = replace
	end

	local index = self:CreateParticle_Original( string_1, int_2, handle_3 )

	ParticleManagerExtension:AddReference( index, data )
	return index
end

function CScriptParticleManager:CreateParticleForTeam( string_1, int_2, handle_3, int_4, handle_5 )
	if not handle_5 then handle_5 = handle_3 end

	-- store data
	local data = {}
	data.name = string_1
	data.attach = int_2
	data.parent = handle_3
	data.team = int_4
	data.owner = handle_5
	data.active = true
	data.control_points = {}

	-- check global replacement
	local replace = Cosmetics:GetParticleReplacement( handle_5, string_1 )
	if replace then
		data.name = replace
		data.original_name = string_1
		string_1 = replace
	end

	local index = self:CreateParticleForTeam_Original( string_1, int_2, handle_3, int_4 )

	ParticleManagerExtension:AddReference( index, data )
	return index
end

function CScriptParticleManager:DestroyParticle( int_1, bool_2 )
	-- load data
	local data = ParticleManagerExtension:GetReference( int_1 )
	if data then
		data.active = false
	end

	-- destroy
	self:DestroyParticle_Original( int_1, bool_2 )
end

function CScriptParticleManager:ReleaseParticleIndex( int_1 )
	-- load data
	local data = ParticleManagerExtension:GetReference( int_1 )
	if data then
		ParticleManagerExtension:RemoveReference( int_1 )
	end

	-- Release
	self:ReleaseParticleIndex_Original( int_1 )
end

function CScriptParticleManager:SetParticleControl( int_1, int_2, Vector_3 )
	-- load data
	local data = ParticleManagerExtension:GetReference( int_1 )
	if data then
		-- store particle control
		local cp = {}
		cp.type = "pos"
		cp.arg1 = int_1
		cp.arg2 = int_2
		cp.arg3 = Vector_3
		ParticleManagerExtension:AddControlPoints( int_1, cp )
	end

	-- Set CP
	self:SetParticleControl_Original( int_1, int_2, Vector_3 )
end

function CScriptParticleManager:SetParticleControlEnt( int_1, int_2, handle_3, int_4, string_5, Vector_6, bool_7 )
	-- load data
	local data = ParticleManagerExtension:GetReference( int_1 )
	if data then
		-- store particle control
		local cp = {}
		cp.type = "ent"
		cp.arg1 = int_1
		cp.arg2 = int_2
		cp.arg3 = handle_3
		cp.arg4 = int_4
		cp.arg5 = string_5
		cp.arg6 = Vector_6
		cp.arg7 = bool_7
		ParticleManagerExtension:AddControlPoints( int_1, cp )
	end

	-- Set CP
	self:SetParticleControlEnt_Original( int_1, int_2, handle_3, int_4, string_5, Vector_6, bool_7 )
end

function CScriptParticleManager:SetParticleControlForward( int_1, int_2, Vector_3 )
	-- load data
	local data = ParticleManagerExtension:GetReference( int_1 )
	if data then
		-- store particle control
		local cp = {}
		cp.type = "forward"
		cp.arg1 = int_1
		cp.arg2 = int_2
		cp.arg3 = Vector_3
		ParticleManagerExtension:AddControlPoints( int_1, cp )
	end

	self:SetParticleControlForward_Original( int_1, int_2, Vector_3 )
end

--------------------------------------------------------------------------------
-- Sounds
--------------------------------------------------------------------------------

-- Backup original function
EmitSoundOn_Original = EmitSoundOn
EmitSoundOnClient_Original = EmitSoundOnClient
EmitSoundOnLocationForAllies_Original = EmitSoundOnLocationForAllies
EmitSoundOnLocationWithCaster_Original = EmitSoundOnLocationWithCaster

-- Overridden functions
function EmitSoundOn( string_1, handle_2 )
	local sound = Cosmetics:GetSoundReplacement( handle_2, string_1 )
	EmitSoundOn_Original( sound, handle_2 )
end
function EmitSoundOnClient( string_1, handle_2 )
	local sound = Cosmetics:GetSoundReplacement( handle_2, string_1 )
	EmitSoundOnClient_Original( string_1, handle_2 )
end
function EmitSoundOnLocationForAllies( Vector_1, string_2, handle_3 )
	local sound = Cosmetics:GetSoundReplacement( handle_3, string_2 )
	EmitSoundOnLocationForAllies_Original( Vector_1, string_2, handle_3 )
end
function EmitSoundOnLocationWithCaster( Vector_1, string_2, handle_3 )
	local sound = Cosmetics:GetSoundReplacement( handle_3, string_2 )
	EmitSoundOnLocationWithCaster_Original( Vector_1, string_2, handle_3 )
end