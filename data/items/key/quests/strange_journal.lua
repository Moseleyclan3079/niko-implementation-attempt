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
    love.filesystem.write( to_an_old_friend.oneshot "I cannot Say that I ever expected to write anOther message for you, and yet, here we are. \nThe messiah... Somehow, the breakdown of reaLity in thiS world has... \nWell, I'm sure you'll figure iT out, given that my journal has appeared here. \nFortunately, a reunIon, despite the Collapse of rEality, is something I am still able to faciliate. \nI'm sure you know where to enter the password. It's in here, if you don't remember it.")
end

return item
