function DeleteItemsFromChest( keys )
	local caster = keys.caster
	for i = 0, 8 do 
		if caster:GetItemInSlot(i) ~= nil then 
			caster:RemoveItem(caster:GetItemInSlot(i))
		end
	end
end