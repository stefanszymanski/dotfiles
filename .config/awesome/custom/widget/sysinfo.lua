local helpers  = require("lain.helpers")
local markup   = require("lain.util.markup")
local awful    = require("awful")
local naughty  = require("naughty")
local floor    = math.floor
local os       = os
local pairs    = pairs
local string   = string
local table    = table
local tconcat  = table.concat
local type     = type
local tonumber = tonumber
local tostring = tostring
local gmatch, lines, floor = string.gmatch, io.lines, math.floor

-- Sysinfo notification
-- custom.widget.sysinfo

local function factory(args)
    args = args or {}
    local sysinfo = {
        attach_to           = args.attach_to or {},
        followtag           = args.followtag or false,
        notification_preset = args.notification_preset or {
            font = "Monospace 10", fg = "#FFFFFF", bg = "#000000"
        }
    }
    local cpu_latest = {}
    local cpu_current = {}

	function sysinfo.mem_now()
		mem_now = {}
        for line in lines("/proc/meminfo") do
            for k, v in gmatch(line, "([%a]+):[%s]+([%d]+).+") do
                if     k == "MemTotal"     then mem_now.total    = floor(v / 1024 + 0.5)
                elseif k == "MemFree"      then mem_now.free     = floor(v / 1024 + 0.5)
                elseif k == "Buffers"      then mem_now.buff     = floor(v / 1024 + 0.5)
                elseif k == "Cached"       then mem_now.cache    = floor(v / 1024 + 0.5)
                elseif k == "SwapTotal"    then mem_now.swap     = floor(v / 1024 + 0.5)
                elseif k == "SwapFree"     then mem_now.swapfree = floor(v / 1024 + 0.5)
                elseif k == "SReclaimable" then mem_now.srec     = floor(v / 1024 + 0.5)
                elseif k == "MemAvailable" then mem_now.avail    = floor(v / 1024 + 0.5)
                end
            end
        end

        mem_now.used = mem_now.total - mem_now.free - mem_now.buff - mem_now.cache - mem_now.srec
        mem_now.swapused = mem_now.swap - mem_now.swapfree
        mem_now.perc = math.floor(mem_now.used / mem_now.total * 100)
        mem_now.buff_cache = mem_now.buff + mem_now.cache

		return mem_now
	end

    function sysinfo.loadavg()
        loadavg = {}
        line = helpers.first_line("/proc/loadavg")
        for a, b, c in string.gmatch(line, "([%d.]+) ([%d.]+) ([%d.]+)") do
            loadavg.one = a
            loadavg.five = b
            loadavg.fifteen = c
        end
        return loadavg
    end

    -- Calculate the overall cpu usage
    function sysinfo.cpu_calc()
        local cpu = { core = {} }
        local cores = 0

        for index,time in pairs(helpers.lines_match("cpu","/proc/stat")) do
            local coreid = index - 1
            local core   = {}
            local at     = 2
            cores = cores + 1

            for field in string.gmatch(time, "[%s]+([^%s]+)") do
                if     at == 2 then core.user   = field
                elseif at == 3 then core.nice   = field
                elseif at == 4 then core.system = field
                elseif at == 5 then core.idle   = field
                elseif at == 6 then core.iowait = field
                elseif at == 7 then core.irq    = field
                elseif at == 8 then core.sirq   = field
                end
                at = at + 1
            end

            core.total = core.user + core.system + core.idle

            cpu.core[coreid] = core
		end

        cpu.cores = cores - 1

        return cpu
    end

    -- Calculate the current cpu usage
    function sysinfo.cpu_now()
        local cpu = {}

        local c = cpu_current.core[0]
        local l = cpu_latest.core[0]

        local duser = c.user - l.user
        local dsystem = c.system - l.system
        local didle = c.idle - l.idle
        local diowait = c.iowait - l.iowait
        local dtotal = c.total - l.total

        cpu.user = duser * 100 / dtotal
        cpu.system = dsystem * 100 / dtotal
        cpu.idle = didle * 100 / dtotal
        cpu.iowait = diowait * 100 / dtotal

        cpu.cores = cpu_current.cores

        return cpu
    end

    -- Remember the latest two overall cpu usage statistics
    function sysinfo.cpu_update()
        cpu_latest = cpu_current
        cpu_current = sysinfo.cpu_calc()
    end

    helpers.newtimer("sysinfo", 2, sysinfo.cpu_update)

    function sysinfo.build_text()
		local mem_now = sysinfo.mem_now()
        local loadavg = sysinfo.loadavg()
        local cpu_now = sysinfo.cpu_now()

        text = ""
        text = text .. string.format("Load avg : %.2f, %.2f, %.2f",
            loadavg.one, loadavg.five, loadavg.fifteen)
        text = text .. "\n"
        text = text .. string.format("%% CPU    : %.1f user, %.1f sys, %.1f idle, %.1f wait",
            cpu_now.user, cpu_now.system, cpu_now.idle, cpu_now.iowait)
        text = text .. "\n\n"
        text = text .. string.format("MiB Mem  : %5s total, %5s free, %5s used, %5s buff/cache",
            mem_now.total, mem_now.free, mem_now.used, mem_now.buff_cache)
        text = text .. "\n" 
        text = text .. string.format("MiB Swap : %5s total, %5s free, %5s used, %5s available",
            mem_now.swap, mem_now.swapfree, mem_now.swapused, mem_now.avail)
        text = text .. "\n\n"
        text = text .. string.format("CPUs     : %.0f", cpu_now.cores)

		return text
    end

    function sysinfo.hide()
        if not sysinfo.notification then return end
        naughty.destroy(sysinfo.notification)
        sysinfo.notification = nil
    end

    function sysinfo.show(seconds, scr)
        sysinfo.hide()
        sysinfo.notification = naughty.notify {
            text    = sysinfo.build_text(),
            preset  = sysinfo.notification_preset,
            screen  = sysinfo.followtag and awful.screen.focused() or scr or 1,
            icon    = sysinfo.icon,
            timeout = type(seconds) == "number" and seconds or sysinfo.notification_preset.timeout or 5
        }
    end

    function sysinfo.hover_on() sysinfo.show(0) end
    function sysinfo.move(offset)
        sysinfo.show(0)
    end

    function sysinfo.attach(widget)
        widget:connect_signal("mouse::enter", sysinfo.hover_on)
        widget:connect_signal("mouse::leave", sysinfo.hide)
    end

    for _, widget in pairs(sysinfo.attach_to) do sysinfo.attach(widget) end

    return sysinfo
end

return factory
