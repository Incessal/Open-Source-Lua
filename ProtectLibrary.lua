local OldIndex = nil
local OldNameCall = nil

local ProtectLibrary = {}

local protected = {}

ProtectLibrary.RandomString = function(length) -- length: integer
    local result = ""
	length = length or 10
	for _ = 1, length, 1 do
		local use = math.random()
		if use >= 0.66 then
			result = result .. string.char(math.random(65, 90))
        elseif use >= 0.33 then
            result = result .. tostring(math.random(0,9))
		else
			result = result .. string.char(math.random(97, 122))
		end
	end
	return result
end

ProtectLibrary.IsProtected = function(inst) -- inst: instance
    for protectid, protected_instance in pairs(protected) do
        if protected_instance == inst then
            return protected_instance, protectid
        end
    end
end

ProtectLibrary.IsIdProtected = function(ProtectID) -- ProtectID: string
    if protected[ProtectID] then
        return protected[ProtectID], ProtectID
    end
    return false
end

ProtectLibrary.Protect = function(inst) -- inst: instance
    if not ProtectLibrary.IsProtected(inst) then
        local ProtectID = ProtectLibrary.RandomString(64)
        while true do
            if protected[ProtectID] then
                ProtectID = ProtectLibrary.RandomString(64)
            else
                break
            end
        end
        inst.Name = inst.Name .. ProtectID
        protected[ProtectID] = inst
        return inst, ProtectID
    end
end

ProtectLibrary.UnProtect = function(ProtectID) -- ProtectID: string
    if ProtectLibrary.IsIdProtected(ProtectID) then
        local inst = protected[ProtectID]
        protected[ProtectID] = nil
        inst.Name = inst.Name:split(ProtectID)[1]
        return inst
    end
end

OldIndex = hookmetamethod(game, "__index", function(Self, Key)
    local return_nil = false
    pcall(function()
        if ProtectLibrary.IsProtected(Self[Key]) and not checkcaller() then
            return_nil = true
        end
    end)
    return return_nil == true and nil or Self[Key]
end)

OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local return_nil = false
    pcall(function()
        if ProtectLibrary.IsProtected(OldNameCall(Self, ...)) and not checkcaller() then
            return_nil = true
        end
    end)

    return return_nil == true and nil or OldNameCall(Self, ...)
end)


return ProtectLibrary
