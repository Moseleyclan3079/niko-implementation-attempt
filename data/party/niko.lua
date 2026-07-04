local character, super = Class(PartyMember, "niko")

function character:init()
    super.init(self)

    self.name = "Niko"

    self:setActor("kris") --all references to Niko as an actor or a sprite are null references at this time. For now, they use Kris's actor data.
    self:setLightActor("kris_lw")
    self:setDarkTransitionActor("kris_dark_transition") --PLACEHOLDER

    self.level = 1
    self.title = "Messiah\nAn old friend.\nNot a cat."

    self.soul_priority = 1
    self.soul_color = {1, 0, 0}
    self.soul_facing = "up"

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "N-Action"

    self.lw_portrait = "face/niko/neutral_1"

    self:addSpell("heal_prayer")
    self:addSpell("purify")

    self.health = 60

    self.stats = {
        health = 60,
        attack = 2,
        defense = 0,
        magic = 11
    }

    self.max_stats = {
        health = 220
    }

    self.lw_health = 20

    self.lw_stats = {
        health = 20,
        attack = 6,
        defense = 6,
        magic = 6
    }

    self.weapon_icon = "ui/menu/equip/scarf"

    self:setWeapon("purple_scarf")

    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    self.color = {72/255, 73/255, 149/255}
    self.dmg_color = {255/255, 1, 51/255}
    self.attack_bar_color = {255/255, 1, 51/255}
    self.attack_box_color = {72/255, 73/255, 149/255}
    self.xact_color = {72/255, 73/255, 149/255}

    self.light_color = {255/255, 1, 51/255}
    self.light_xact_color = {237/255, 140/255, 36/255}

    self.icon_color = {253/255, 0, 85/255}
	-- highlight color A
    self.highlight_color = ColorUtils.hexToRGB("#FFFF33")
		-- highlight color B
    self.highlight_color_alt = COLORS.yellow

    self.menu_icon = "party/kris/head"
    self.head_icons = "party/kris/icon"
    self.name_sprite = "party/kris/name"

    self.attack_sprite = "effects/attack/slap_n"
    self.attack_sound = "laz_c"
    self.attack_pitch = 1.2

    self.battle_offset = {0, 0}
    self.head_icon_offset = nil
    self.menu_icon_offset = nil

    self.gameover_message = {
        "Hey...[wait:5] are you okay?!",
        "No... I can't hear \n"..Game.save_name.."'s voice...!"
    }

    self.element = {
        "HOLY",
        "CAT"
    }
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:onLevelUpLVLib(level)
    self:increaseStat("health", 4)
    self:increaseStat("magic", 2)
    if (level - 1) % 4 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("defense", 1)
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/magic")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Burden", x, y)
        love.graphics.print("Light", x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/gun")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Shots", x, y, 0, 0.8, 1)
        love.graphics.print(1, x+130, y)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        Draw.draw(icon, x+90, y+6, 0, 2, 2)
        return true
    end
end

return character