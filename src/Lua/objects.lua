

---@class drumdash_obj
local objectTemplate = {
    name = "undefined", ---@type string? The object's name, shows up on the Level Editor
    
    think = nil ---@type function? Triggers all frames that an object thinks.
}

DrumDash.objectdefs = {}

---@param definition drumdash_obj
---@param parent integer?
function DrumDash.defineObject(definition, parent)
    if not definition then return end

    local identifier = #DrumDash.objectdefs + 1
    local parent_def = DrumDash.objectdefs[parent] or objectTemplate
    local metatable = { ---@type metatable
        __index = parent_def,
        __newindex = function() end,
        __len = function()
            return identifier
        end
    }

    --registerMetatable(metatable)
    DrumDash.objectdefs[identifier] = setmetatable({}, metatable)
end