---@class HeartEffectShard : Sprite
---@overload fun(...) : HeartEffectShard
local HeartEffectShard, super = Class(Sprite)

function HeartEffectShard:init(x, y)
    super.init(self, "player/heart_shard", x or 0, y or 0)

    self:play(1/10, true)

    self.hsp = MathUtils.randomInt(-10, 10 + 1)
    self.vsp = MathUtils.randomInt(-10, 10 + 1)
    self.grav = 0.5

    if not Game.battle then
        self:fadeOutAndRemove(1)
    end
end

function HeartEffectShard:update()
    super.update(self)

    self.x = self.x + self.hsp * DTMULT
    self.y = self.y + self.vsp * DTMULT
    if self.vsp < 20 then
        self.vsp = self.vsp + self.grav * DTMULT
    end

    if Game.battle then
        local size = self.width + self.height
        local x, y = self:getScreenPos()
        if x < -size or y < -size or x > SCREEN_WIDTH + size or y > SCREEN_HEIGHT + size then
            self:remove()
        end
    end
end

return HeartEffectShard