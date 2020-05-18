local awful     = require("awful")
local gears     = require("gears")
local promptbox = require("custom.prompt.promptbox")

local tag = { _NAME = "custom.tag" }


function tag.add(args)
    local default_args = { 
        switch = true, 
        name = nil, 
        layout = nil,
        screen = nil,
    }
    local args = gears.table.join(default_args, args or {})
    local t = awful.tag.add(args.name, { 
        screen = args.screen or awful.screen.focused(), 
        layout = args.layout or awful.layout.suit.tile,
    })
    if args.switch then t:view_only() end
    return t
end

function tag.create(args)
    local default_args = { 
        switch = true, 
        layout = nil,
        screen = nil
    }
    local args = gears.table.join(default_args, args or {})
    local prompt = promptbox({ 
        prompt = "Create tag: ",
        exe_callback = function(name)
            tag.add(gears.table.join({ name = name }, args))
        end
    })
    prompt.run()
end

function tag.rename()
    local prompt = promptbox({ 
        prompt = "Rename tag: ",
        exe_callback = function(new_name)
            if not new_name or #new_name == 0 then
                return
            end
            local t = awful.screen.focused().selected_tag
            if t then
                t.name = new_name
            end
        end
    })
    prompt.run()
end

function tag.create_move_client(args)
    local default_args = { 
        switch = true, 
        layout = nil 
    }
    local args = gears.table.join(default_args, args or {})
    local prompt = promptbox({ 
        prompt = "Move to new tag: ",
        exe_callback = function(name)
            args.name = name
            local c = client.focus
            local t = tag.add(gears.table.join(args, { name = name, switch = false, screen = c.screen }))
            c:tags({t})
            if args.switch then t:view_only() end
        end
    })
    prompt.run()
end


function tag.delete()
    local t = awful.screen.focused().selected_tag
    if not t then return end
    t:delete()
end

function tag.delete_all_empty()
    local s = awful.screen.focused()
    if not s then return end
    for i, t in pairs(s.tags) do
        local clients = t:clients()
        if #clients <= 0 then
            t:delete()
        end
    end
end


return tag
