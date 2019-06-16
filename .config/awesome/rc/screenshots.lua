-- helper scripts
local screenshot = require("custom.helper.screenshot")
-- settings
local apps       = require("apps")


-- configure the screenshot helper
screenshot.defaults.run_factory = function(path, args)
    return function()
        apps.imageviewer.open(path)
    end
end
screenshot.defaults.actions_factory = function(path, args)
    return {
        ranger = function()
            path = path:gsub("~", "$HOME")
            apps.filemanager.open(path)
        end,
        edit = function()
            apps.imageeditor.open(path)
        end,
    }
end
