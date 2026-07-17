local Lib = {}

Registry.registerGlobal("JukeboxLib", Lib)
JukeboxLib = Lib

function Lib:init()
    print("Loaded JukeboxMenu!")
end

function Lib:onMapMusic(map, music)
    local curJukeBoxSong = Game:getFlag("curJukeBoxSong")

    if music == "jukebox" then
        if curJukeBoxSong then
            return curJukeBoxSong
        else
            return "deltarune/castle_funk_long"
        end
    end
end

function Lib:onJukeboxPlay(song)
    Game:setFlag("curJukeBoxSong", song.file)
end

---@param ... any # Extra parameters to cond()
function JukeboxLib.evaluateCond(data, ...)
    local result = true

    if data.cond then
        result = data.cond(...)
    elseif data.flagcheck then
        local inverted, flag = StringUtils.startsWith(data.flagcheck, "!")

        local flag_value = Game.flags[flag]
        local expected_value = data.flagvalue
        local is_true
        if expected_value ~= nil then
            is_true = flag_value == expected_value
        elseif type(result) == "number" then
            is_true = flag_value > 0
        else
            is_true = flag_value
        end

        if is_true then
            result = not inverted
        else
            result = inverted
        end
    end

    return result
end

-- Gets the index of an item in a 2D table
---@return integer|nil i
---@return integer|nil j
function JukeboxLib.getIndex2D(t, value)
    for i,r in pairs(t) do
        local j = TableUtils.getIndex(r, value)
        if j then
            return i, j
        end
    end
    return nil, nil
end

return Lib