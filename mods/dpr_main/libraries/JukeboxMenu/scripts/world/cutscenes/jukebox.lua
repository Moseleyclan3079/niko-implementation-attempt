---@type table<string, fun(cutscene:WorldCutscene)>
local jukebox = {}

function jukebox.MAIN(cutscene, event)
    cutscene:text("* A working jukebox.\n* What would you like to do?")

    local choicer = cutscene:choicer({"Change\nsong", "Discuss\ncurrent song", "Leave it"})
    if choicer == 1 then
        Assets.stopAndPlaySound("ui_select")
        cutscene:after(function()
            Game.world:openMenu(JukeboxMenu())
        end)

    elseif choicer == 2 then
        local cur_song = Game:getFlag("curJukeBoxSong")
        if cur_song == "deltarune/church_wip" then -- Dark Sanctuary
            if Game:hasPartyMember("ralsei") and Game:hasPartyMember("susie") then
                cutscene:text("* Hey, isn't this the song you were humming back at the church,[wait:5] Ralsei?", "surprise", "susie")
                cutscene:text("* ...?", "shock_smile", "ralsei")
                cutscene:text("* O-oh![wait:5] Yes.[wait:5]\n* I suppose it is,[wait:5] haha.", "pleased", "ralsei")
            elseif Game:hasPartyMember("susie") then
                cutscene:text("* Heh,[wait:5] this is the song Ralsei was humming back at the church.", "annoyed_down_smile", "susie")
            else
                cutscene:text("* (... but there was nothing to say about it.)")
            end

        elseif jukebox[cur_song] then
            jukebox[cur_song](cutscene)
        else -- failsafe if a specific song doesn't have special dialogue for it.
            cutscene:text("* (... but there was nothing to say about it.)")
        end
    else
        cutscene:text("* You decided to leave the jukebox in its undamaged state.")
    end
end

return jukebox
