-- Prompt in popup
-- inspired by https://github.com/worron/redflat/blob/e0518e3f972241bcb4ee098fe91f7d37bce09574/float/prompt.lua

local awful     = require("awful")
local wibox     = require("wibox")
local naughty   = require("naughty")
local gears     = require("gears")
local unpack    = unpack or table.unpack

local prompt = {}

local function default_args()
	local args = {
        width        = 620,
        height       = 40,
		margins      = { 10, 10, 10, 10 },
		border_width = 2,
        border_color = nil,
        fg           = nil,
        bg           = nil,
		shape        = nil,
        prompt       = "Run: ",
        exe_callback = function(input, args)
            local result = awful.spawn(input)
            if type(result) == "string" then
                naughty.notify({"Prompt", text = result})
            end
        end,
        -- TODO get cache dir
        history_path = awful.util.getdir("cache") .. "/history",
        history_max = 1000,
        completion_callback = awful.completion.shell,
	}
	return args
end

function prompt:init(args)
    args = gears.table.join(default_args(), args or {})
    self.args = args

    self.widget = wibox.widget{
        bg = "#ff0000",
        widget = wibox.widget.textbox
    }

    self.widget:set_ellipsize("start")

    self.wibox = wibox{
        ontop = true,
        border_width = args.border_width,
		border_color = args.border_color,
        bg = args.bg,
		fg = args.fg,
        shape = args.shape,
        width = args.width,
        height = args.height,
        widget = wibox.container.margin(self.widget, unpack(args.margins))
    }
end

function prompt:run()
    if not self.wibox then self:init() end

    self.wibox.screen = awful.screen.focused()
    awful.placement.centered(self.wibox)
    self.wibox.visible = true

    awful.prompt.run({
        prompt = self.args.prompt,
        textbox = self.widget,
        exe_callback = self.args.exe_callback,
        completion_callback = self.args.completion_callback,
        history_path = self.args.history_path,
        history_max = self.args.history_max,
        done_callback = function () self.wibox.visible = false end,
    })
end

return prompt
