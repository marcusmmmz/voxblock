local http = minetest.request_http_api()

function fetch_mempool_data_string(url, okcb, errcb)
    http.fetch({
        url = url,
        timeout = 5,
    }, function(res)
        if res then
            okcb(res.data)
        else
            errcb()
        end
    end)
end

function fetch_mempool_data_json(url, okcb, errcb)
    fetch_mempool_data_string(
        url,
        function (data)
            local data_table = minetest.parse_json(data)

            if data_table then
                okcb(data_table)
            else
                errcb()
            end
        end,
        function ()
            errcb()
        end
    )
end

function fetch_last_block(okcb, errcb)
    fetch_mempool_data_string("https://mempool.space/api/blocks/tip/hash", okcb, err_cb)
end

function fetch_block_data(blockhash, okcb, errcb)
    fetch_mempool_data_json("https://mempool.space/api/block/" .. blockhash, okcb, err_cb)
end

function seila()
    if http then
        minetest.chat_send_all("Sending HTTP Request.")

        fetch_last_block(
            function (blockhash)
                minetest.chat_send_all("blockhash: " .. blockhash )
            end,
            function ()
                minetest.chat_send_all("Failed to get block")
            end
        )

    else
        minetest.log("error", "[modname] Failed to get HTTP API.")
    end
end

minetest.register_on_joinplayer(function(player)
    minetest.chat_send_all("new player joined")

    -- seila()
end)

one = {
    { x= 1, y = 0, z= 0 },
    { x= -1, y= 0, z= 0 },
    { x= 0, y = 0, z= 0 },
    { x= 0, y = 1, z= 0 },
    { x= 0, y = 2, z= 0 },
    { x= 0, y = 3, z= 0 },
    { x= 1, y = 3, z= 0 },
    { x= 0, y = 4, z= 0 }
}


minetest.register_chatcommand("place_block_above", {
    description = "Place a block above the player's head",
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

        local node_to_place = "default:wood"

        -- minetest.set_node(pos_above, {name = node_to_place})

        for i, pos in ipairs(one) do
            local block_pos = {
                x = pos_above.x+pos.x,
                y = pos_above.y+pos.y,
                z = pos_above.z+pos.z
            }
            minetest.set_node(block_pos, {name = node_to_place})
        end

        return true, "Block placed above your head!"
    end
})
