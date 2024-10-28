local storage = minetest.get_mod_storage()
local http = minetest.request_http_api()

local block_height_coords = { x = 0, y = 0, z = 0 }

local block_height_coords_string = storage:get_string("block_height_coords")
if block_height_coords_string ~= "" then
    block_height_coords = minetest.deserialize(block_height_coords_string)
end

local last_block_height = storage:get_string("last_block_height")

function fetch_mempool_data_string(url, ok_cb, err_cb)
    http.fetch({
        url = url,
        timeout = 5,
    }, function(res)
        if res then
            ok_cb(res.data)
        else
            err_cb()
        end
    end)
end

function fetch_mempool_data_json(url, ok_cb, err_cb)
    fetch_mempool_data_string(
        url,
        function(data)
            local data_table = minetest.parse_json(data)

            if data_table then
                ok_cb(data_table)
            else
                err_cb()
            end
        end,
        function()
            err_cb()
        end
    )
end

function fetch_last_block_hash(ok_cb, err_cb)
    fetch_mempool_data_string("https://mempool.space/api/blocks/tip/hash", ok_cb, err_cb)
end

function fetch_last_block_height(ok_cb, err_cb)
    fetch_mempool_data_string("https://mempool.space/api/blocks/tip/height", ok_cb, err_cb)
end

function fetch_block_data(blockhash, ok_cb, err_cb)
    fetch_mempool_data_json("https://mempool.space/api/block/" .. blockhash, ok_cb, err_cb)
end

minetest.register_on_joinplayer(function(player)
    minetest.chat_send_all("new player joined")
    minetest.chat_send_all("block_height_coords" .. vec3_to_string(block_height_coords))
    minetest.chat_send_all("last_block_height" .. last_block_height)

    -- seila()
end)

digit_to_blocks = {
    [1] = {
        { x = 2, y = 0, z = 0 },
        { x = 0, y = 0, z = 0 },
        { x = 1, y = 0, z = 0 },
        { x = 1, y = 1, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 1, y = 3, z = 0 },
        { x = 0, y = 3, z = 0 },
        { x = 1, y = 4, z = 0 }
    },
    [2] = {
        { x = 0, y = 4, z = 0 },
        { x = 1, y = 4, z = 0 },
        { x = 2, y = 4, z = 0 },
        { x = 2, y = 3, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 0, y = 1, z = 0 },
        { x = 0, y = 0, z = 0 },
        { x = 1, y = 0, z = 0 },
        { x = 2, y = 0, z = 0 }
    },
    [3] = {
        { x = 0, y = 4, z = 0 },
        { x = 1, y = 4, z = 0 },
        { x = 2, y = 4, z = 0 },
        { x = 2, y = 3, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 2, y = 1, z = 0 },
        { x = 2, y = 0, z = 0 },
        { x = 1, y = 0, z = 0 },
        { x = 0, y = 0, z = 0 }
    },
    [4] = {
        { x = 2, y = 4, z = 0 },
        { x = 2, y = 3, z = 0 },
        { x = 2, y = 2, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 0, y = 2, z = 0 },
        { x = 0, y = 3, z = 0 },
        { x = 0, y = 4, z = 0 },
        { x = 2, y = 1, z = 0 },
        { x = 2, y = 0, z = 0 }
    },
    [5] = {
        { x = 2, y = 4, z = 0 },
        { x = 1, y = 4, z = 0 },
        { x = 0, y = 4, z = 0 },
        { x = 0, y = 3, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 2, y = 1, z = 0 },
        { x = 2, y = 0, z = 0 },
        { x = 1, y = 0, z = 0 },
        { x = 0, y = 0, z = 0 }
    },
    [6] = {
        { x = 2, y = 4, z = 0 },
        { x = 1, y = 4, z = 0 },
        { x = 0, y = 4, z = 0 },
        { x = 0, y = 3, z = 0 },
        { x = 0, y = 2, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 2, y = 2, z = 0 },
        { x = 2, y = 1, z = 0 },
        { x = 0, y = 1, z = 0 },
        { x = 2, y = 0, z = 0 },
        { x = 1, y = 0, z = 0 },
        { x = 0, y = 0, z = 0 }
    },
    [7] = {
        { x = 0, y = 4, z = 0 },
        { x = 1, y = 4, z = 0 },
        { x = 2, y = 4, z = 0 },
        { x = 2, y = 3, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 1, y = 1, z = 0 },
        { x = 1, y = 0, z = 0 }
    },
    [8] = {
        { x = 1, y = 4, z = 0 },
        { x = 0, y = 4, z = 0 },
        { x = 2, y = 4, z = 0 },
        { x = 0, y = 3, z = 0 },
        { x = 2, y = 3, z = 0 },
        { x = 0, y = 2, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 2, y = 2, z = 0 },
        { x = 0, y = 1, z = 0 },
        { x = 2, y = 1, z = 0 },
        { x = 0, y = 0, z = 0 },
        { x = 1, y = 0, z = 0 },
        { x = 2, y = 0, z = 0 }
    },
    [9] = {
        { x = 1, y = 4, z = 0 },
        { x = 0, y = 3, z = 0 },
        { x = 2, y = 3, z = 0 },
        { x = 0, y = 2, z = 0 },
        { x = 2, y = 2, z = 0 },
        { x = 1, y = 2, z = 0 },
        { x = 2, y = 1, z = 0 },
        { x = 1, y = 0, z = 0 }
    },
    [0] = {
        { x = 1, y = 0, z = 0 },
        { x = 0, y = 0, z = 0 },
        { x = 2, y = 0, z = 0 },
        { x = 0, y = 1, z = 0 },
        { x = 2, y = 1, z = 0 },
        { x = 0, y = 2, z = 0 },
        { x = 2, y = 2, z = 0 },
        { x = 0, y = 3, z = 0 },
        { x = 2, y = 3, z = 0 },
        { x = 1, y = 4, z = 0 },
        { x = 0, y = 4, z = 0 },
        { x = 2, y = 4, z = 0 },
    },
}

function write_digit_in_blocks(pos, node_to_place, number)
    for _, offset in ipairs(digit_to_blocks[number]) do
        local block_pos = {
            x = pos.x + offset.x,
            y = pos.y + offset.y,
            z = pos.z + offset.z
        }
        minetest.set_node(block_pos, { name = node_to_place })
    end
end

function write_digits_in_blocks(initial_pos, node_to_place, digits)
    local i = 0
    for c in digits:gmatch "." do
        local pos = {
            x = initial_pos.x + (i * 4),
            y = initial_pos.y,
            z = initial_pos.z
        }

        write_digit_in_blocks(pos, node_to_place, tonumber(c))

        i = i + 1
    end
end

minetest.register_chatcommand("number", {
    params = "<number>",
    description = "Place a number above the player's head",
    func = function(name, params)
        local digits = params

        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found."
        end

        local pos = player:get_pos()

        local pos_above = {
            x = pos.x,
            y = pos.y + 2,
            z = pos.z
        }

        write_digits_in_blocks(pos_above, "default:wood", digits)

        return true, "Number placed above your head!"
    end
})

function vec3_to_string(vec3)
    return "(" .. tostring(vec3.x) .. "," .. tostring(vec3.y) .. "," .. tostring(vec3.z) .. ")"
end

minetest.register_chatcommand("set_block_height_coords", {
    description = "Puts the current block height above the player's head",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found."
        end

        local pos = player:get_pos()

        block_height_coords = {
            x = pos.x,
            y = pos.y + 2,
            z = pos.z
        }
        storage:set_string("block_height_coords", minetest.serialize(block_height_coords))

        minetest.chat_send_all("block_height_coords: " .. vec3_to_string(block_height_coords))

        return true, "Block height coords set to above your head!"
    end
})


minetest.register_chatcommand("block_height_above_head", {
    description = "Puts the current block height above the player's head",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if not player then
            return false, "Player not found."
        end

        local pos = player:get_pos()

        local pos_above = {
            x = pos.x,
            y = pos.y + 2,
            z = pos.z
        }

        fetch_last_block_height(
            function(blockheight)
                minetest.chat_send_all("blockheight: " .. blockheight)
                write_digits_in_blocks(pos_above, "default:stone", blockheight)
            end,
            function()
                minetest.chat_send_all("Failed to get block")
            end
        )

        return true, "Block placed above your head!"
    end
})

function update_block_height()
    fetch_last_block_height(
        function(block_height)
            minetest.chat_send_all("block_height: " .. block_height)

            -- removing old blocks
            write_digits_in_blocks(block_height_coords, "air", last_block_height)

            -- inserting new blocks
            write_digits_in_blocks(block_height_coords, "default:stone", block_height)

            last_block_height = block_height
            storage:set_string("last_block_height", block_height)
        end,
        function()
            minetest.chat_send_all("Failed to get block")
        end
    )
end

minetest.register_chatcommand("update_block_height", {
    description = "Puts the current block height above the player's head",
    func = function()
        update_block_height()

        return true, "Block height updated!"
    end
})

local timer = 0

minetest.register_globalstep(function(dtime)
    timer = timer + dtime

    if timer >= 60 then
        timer = 0

        every_60_seconds()
    end
end)

function every_60_seconds()
    if block_height_coords.x == 0 then
        minetest.chat_send_all(
            "No block height coords were set. To set the coords to (above) where your player currently is, use /set_block_height_coords")
    else
        update_block_height()
        minetest.chat_send_all("block height automatically updated!")
    end
end
