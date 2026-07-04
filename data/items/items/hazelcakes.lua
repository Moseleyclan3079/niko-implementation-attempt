local item, super = Class(HealItem, "hazelcakes")

function item:init()
    super.init(self)

    self.name = "HazelCakes"
    self.use_name = nil

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\n80HP"
    self.shop = "Someone's\nfavourite\nHeals 80HP"
    self.description = "A stack of hazelnut pancakes. \nHeals 80HP"

    self.heal_amount = 80
    -- if Niko is in the party it fully heals them specifically since its their fav
    -- and if dess is in the party she steals everyone's pancakes, she heals 240 hp but everyone else heals 0 

    self.price = 2
    self.can_sell = false

    self.target = "party"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {}
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        hero = "So, this is their favourite?",
        susie = "Living like this has gotta be a sin.",
        ralsei = "W-wow! This is really sweet!",
        noelle = "It has some crunch, doesn't it?",
        dess = "man where the HELL did you get these",
        berdly = "Hm... Homemade, are they?",
    }
end

return item