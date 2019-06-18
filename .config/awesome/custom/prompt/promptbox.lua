-- Prompt in popup
-- inspired by https://github.com/worron/redflat/blob/e0518e3f972241bcb4ee098fe91f7d37bce09574/float/prompt.lua

local awful     = require("awful")
local wibox     = require("wibox")
local naughty   = require("naughty")
local gears     = require("gears")
local unpack    = unpack or table.unpack

local function factory(args)
    local promptbox = {}
    local p_widget = nil
    local p_wibox = nil

    function trim(s)
        return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
    end

    function default_args()
        return {
            width        = 620,
            height       = 40,
            margins      = { 10, 10, 10, 10 },
            border_width = 2,
            border_color = nil,
            fg           = nil,
            bg           = nil,
            shape        = nil,
            prompt       = "Run: ",
            history_max = 1000,
            history_path = awful.util.get_cache_dir() .. "/history",
            completion_callback = awful.completion.shell,
            exe_callback = function(input)
                local result = awful.spawn.easy_async_with_shell(input, function(stdout, stderr, reason, exit_code)
                    stdout = trim(stdout)
                    stderr = trim(stderr)
                    if (exit_code == 0) and string.len(stdout) > 0 then
                        naughty.notify { title = "Prompt", text = stdout }
                    elseif (exit_code > 0) then
                        naughty.notify { title = "Prompt error", text = stderr, preset = naughty.config.presets.critical }
                    end
                end)
            end,
        }
    end
        
    args = gears.table.join(default_args(), args or {})

    function init(args)
        p_widget = wibox.widget {
            bg = "#ff0000",
            widget = wibox.widget.textbox
        }

        p_wibox = wibox {
            ontop = true,
            border_width = args.border_width,
            border_color = args.border_color,
            bg = args.bg,
            fg = args.fg,
            shape = args.shape,
            width = args.width,
            height = args.height,
            widget = wibox.container.margin(p_widget, unpack(args.margins))
        }
    end

    function promptbox.run()
        p_wibox.screen = awful.screen.focused()
        awful.placement.centered(p_wibox)
        p_wibox.visible = true

        awful.prompt.run({
            prompt = args.prompt,
            textbox = p_widget,
            exe_callback = args.exe_callback,
            completion_callback = args.completion_callback,
            history_path = args.history_path,
            history_max = args.history_max,
            done_callback = function () p_wibox.visible = false end,
        })
    end

    init(args)

    return promptbox
end

return factory