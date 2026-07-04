local item, super = Class(Item, "strange_journal")

function item:init()
    super.init(self)

    self.name = "strange journal"
    self.use_name = nil

    self.type = "key"
    self.icon = nil

    self.effect = ""

    self.shop = ""

    self.description = "* It's written in an unknown language."
    self.price = 0
    self.can_sell = false
    self.target = "none"
    self.usable_in = "world"
    self.result_item = nil
    self.instant = false
    self.bonuses = {}
    self.bonus_name = nil
    self.bonus_icon = nil
    self.can_equip = {}
    self.reactions = {}
end

function item:onWorldUse()
    Game.world:showText({
        "* You tried to read the journal.",
        "* ...[wait:5]the language is completely unknown to you.",
        "* The infomation must still exist... Maybe you can access it somewhere else?"
     })

end

return item
