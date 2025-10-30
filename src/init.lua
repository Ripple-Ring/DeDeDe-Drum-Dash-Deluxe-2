
rawset(_G, "DrumDash", {
    sync = {}
})

addHook("NetVars", function(net)
    DrumDash.sync = net($)
end)

--- Returns if you're playing Drum Dash or not.
---@return boolean
function DrumDash.onMode()
    return true
end

--- Prints a debug message, only shows when launching the game with -debug.
---@param ... any
function DrumDash.debugPrint(...)
    if devparm then
        for _, msg in ipairs({...}) do
            print("[DeDeDebug] - " + tostring(msg))
        end
    end
end

dofile("objects.lua")

dofile("Objects/Player.lua")

dofile("rendering.lua")

if devparm then
    COM_AddCommand("dededebug_createobj", function(_, objnum)
        if tonumber(objnum) == nil then return end

        objnum = tonumber($)
        if not DrumDash.objectdefs[objnum] then return end

        DrumDash.createObject(objnum, 0, 0)
    end)
end