
-- player & camera stuff
-- yay!!

---@class drumdash_player: drumdash_obj
---@field plyrnum integer
---@field camera_x fixed_t
---@field camera_y fixed_t

DrumDash.defineObject({
    name = "Player Spawn",

    height = 32*FU,
    width = 32*FU,

    ---@param self drumdash_player
    think = function(self)
        if self.plyrnum == nil then return end

        self.camera_x = self.x
        self.camera_y = self.y
    end,
})