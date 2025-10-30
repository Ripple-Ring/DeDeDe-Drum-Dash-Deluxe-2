
-- handles th renders the ing
-- for stuff
-- yeah

---@param v videolib
---@param p player_t
addHook("HUD", function(v, p)
    if not DrumDash.onMode() then return end

    --- TEMP ---
    local drumdash_plyr = DrumDash.sync.players[#p]
    if not drumdash_plyr then return end

    v.drawFill(drumdash_plyr.x, drumdash_plyr.y, drumdash_plyr.info.width/FU, drumdash_plyr.info.height/FU, 0)
end)