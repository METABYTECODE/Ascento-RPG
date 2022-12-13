-- TODO: Full optimize lib
local bit = require("libraries/autoload/bit")

local function Push(self, number, bitCount)
    bitCount = bitCount or 8
    for i = 1, bitCount do
        table.insert(self.bits, bit.band(number, 1))
        number = bit.rshift(number, 1)
    end
    
    local buffer, l, r = nil, #self.bits - bitCount + 1, #self.bits
    while l < r do
        buffer = self.bits[l]
        self.bits[l] = self.bits[r]
        self.bits[r] = buffer
        l = l + 1
        r = r - 1
    end
end

local function Get(self, from, length)
    length = length or 1
    local result = 0
    for i = from, from + length - 1 do
        result = bit.lshift(result, 1) + (self.bits[i] or 0)
    end
    return result
end

local function bitsetToString(self)
    local result = {}
    for i = 1, #self.bits, 8 do
        table.insert(result, string.char(self:Get(i, 8)))
    end
    return table.concat(result)
end

local function GetSize(self)
    return #self.bits
end

local mt =
{
    __index =
    {
        Push = Push,
        Get = Get,
        GetSize = GetSize,
    },
    __tostring = bitsetToString,
    __len = GetSize,
}

local function bitset(str)
    str = str or ""
    local base = {string.byte(str, 1, #str)}
    local self = setmetatable({bits = {}}, mt)
    for _, v in pairs(base) do
        self:Push(v, 8)
    end
    return self
end

return bitset