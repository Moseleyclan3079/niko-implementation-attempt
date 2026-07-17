---@class Jukebox : Object
---@Jukebox fun(...) : Object
local Jukebox, super = Class(Event)

---@param data table
function Jukebox:init(data)
    super.init(self, data.x, data.y, data.width, data.height)
    local properties = data and data.properties or {}

    self:setOrigin(0.5, 1)
    self:setScale(2)

    self.sprite = Sprite("world/events/jukebox")
    self:addChild(self.sprite)

    self:setSize(self.sprite:getSize())
    self:setHitbox(0, 33, 34, 11)

	self.solid = true

    self.simple = properties["simple"] or nil

    self.menu = JukeboxMenu() ---@type JukeboxMenu
    self.timer = self:addChild(Timer())

    self.animate_to_beat = Kristal.getLibConfig("JukeboxMenu", "animateToBeat")
    self.enable_metronome = Kristal.getLibConfig("JukeboxMenu", "enableMetronome")
    self.metronome_sound = nil
end

function Jukebox:openMenu()
    self.menu = JukeboxMenu() ---@type JukeboxMenu
    Game.world:openMenu(self.menu)
end

function Jukebox:onInteract(chara, dir)
    Game.world:startCutscene("jukebox.MAIN", self)
    return true
end

---@private
function Jukebox:_getMusic()
    local music = Game.world.music
    if not (music and music.current and music.current ~= "none" and music:isPlaying()) then
        return nil
    end
    return music
end

function Jukebox:onAdd(parent)
    super.onAdd(self, parent)

    local music = self:_getMusic()
    self.last_tell = music and {music.current, music:tell() or 0} or {"none", 0}
end

function Jukebox:update()
    if self.animate_to_beat and self.menu then
        local music = self:_getMusic()
        if not music then goto anim_done end

        local song = self.menu:getPlayingEntry(music, true)
        local bpm = song and song.bpm or Kristal.getLibConfig("JukeboxMenu", "defaultBpm")
        if bpm >= 200 then
            bpm = bpm / 2
        end

        local modulo = 1 / (bpm / 60)
        local tell = music:tell()
        local beat = false
        if self.last_tell[1] == music.current and (tell % modulo) < (self.last_tell[2] % modulo) then
            beat = true
        end
        self.last_tell = {music.current, tell}

        if beat then
            if self.enable_metronome then
                if not self.metronome_sound then
                    self.metronome_sound = Assets.newSound("jukebox_metronome")
                    self.metronome_sound:setVolume(0.8)
                end
                self.metronome_sound:stop()
                self.metronome_sound:play()
            end

            self:setScale(2.2)
            self.timer:tween(12/30, self, {scale_x=2, scale_y=2}, "out-sine")

            local note = self:addChild(Sprite("world/events/musical_notes_small", 30 + MathUtils.random(10), 10))
            note:setLayer(10)
            note.alpha = 0

            self.timer:script(function(wait)
                note:fadeToSpeed(1, 10/30)
                wait(10/30)
                note:fadeToSpeed(0, 11/30)
                wait(51/30)
                note:remove()
            end)
            self.timer:tween(1, note, {
                x = note.init_x + (20 + MathUtils.random(10)),
                y = note.init_y - (30 + MathUtils.random(10))
            }, "linear")
        end

        ::anim_done::
    end

    super.update(self)
end

return Jukebox
