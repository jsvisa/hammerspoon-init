-- by jsvisa<delweng@gmail.com>
--
-- auto reload
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
        hs.alert.show("Hammerspoon config loaded")
    end
end

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()


-- bind
hs.hotkey.bind({"alt"}, "S", function()
    hs.application.open("Slack")
end)

hs.hotkey.bind({"alt"}, "C", function()
    hs.application.open("Google Chrome")
end)

hs.hotkey.bind({"alt"}, "W", function()
    hs.application.open("WeChat")
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function ()
    hs.reload()
    hs.alert.show("Hammerspoon config reloaded!")
end)

hs.hotkey.bind({"alt"}, "M", function ()
    hs.application.open("MacDown")
end)

hs.hotkey.bind({"alt"}, "T", function ()
    hs.application.open("iTerm")
end)

hs.hotkey.bind({"alt"}, "F", function ()
    hs.application.open("Firefox")
end)

