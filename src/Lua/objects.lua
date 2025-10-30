

---@class drumdash_objdef
local objectTemplate = {
    name = "undefined", ---@type string? The object's name, shows up on the Level Editor
    
    width = 0, ---@type fixed_t The object hitbox's width
    height = 0, ---@type fixed_t The object hitbox's height

    think = nil ---@type function? Triggers all frames that an object thinks.
}

---@class drumdash_obj: drumdash_objdef
---@field x fixed_t The object's horizontal position
---@field y fixed_t The object's vertical position
---@field info drumdash_objdef The object's definition

DrumDash.objectdefs = {} ---@type table<drumdash_objdef>
DrumDash.sync.objects = {} ---@type table<drumdash_obj>
DrumDash.sync.players = {} ---@type table<drumdash_player>
local parentMetas = {}

--- defines an object with the `definition` definition, having all parameters from `parent`
---@param definition drumdash_objdef
---@param parent integer?
function DrumDash.defineObject(definition, parent)
    if not definition then return end

    if parent == nil then
        parent = -1
    end

    local identifier = #DrumDash.objectdefs + 1
    local parent_def = DrumDash.objectdefs[parent] or objectTemplate
    local parent_metatable = parentMetas[parent]
    if not parent_metatable then
        parent_metatable = { ---@type metatable
            __index = parent_def,
            __newindex = function() end,
            __usedindex = function() end,
            __len = function()
                return identifier
            end
        }
        parentMetas[parent] = parent_metatable
    end

    /*local metatable = { ---@type metatable
        __index = setmetatable(definition, parent_metatable),
        __newindex = function() end,
        __len = function()
            return identifier
        end
    }*/
    --registerMetatable(metatable)
    DrumDash.objectdefs[identifier] = setmetatable(definition, parent_metatable)
end

--- creates an object of id `obj_id`, at coords `x` & `y`
---@param obj_id integer
---@param x fixed_t?
---@param y fixed_t?
function DrumDash.createObject(obj_id, x, y)
    if not DrumDash.objectdefs[obj_id] then
        error("Oops, it seems that object " + obj_id + " does not exist!", 2)
        return
    end

    x, y = ($1 or 0), ($2 or 0)

    local obj_placement = #DrumDash.sync.objects+1
    local obj = {
        x = x,
        y = y,
        info = DrumDash.objectdefs[obj_id]
    } ---@type drumdash_obj

    DrumDash.sync.objects[obj_placement] = obj
    if obj_id == 1 then -- NOTE: replace with constant later
        DrumDash.sync.players[0] = obj
        obj.plyrnum = 0
    end

    DrumDash.debugPrint("Spawned '" + DrumDash.objectdefs[obj_id].name + "' at coords " + x + ", " + y)
end