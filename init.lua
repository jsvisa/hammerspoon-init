-- by jsvisa<delweng@gmail.com>
--
----------------------------------------------------------------------------------
-- rtoshiro - https://github.com/rtoshiro
-- You should see: http://www.hammerspoon.org/docs/index.html
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local alt = {"alt"}
local cmd_alt = {"cmd", "alt"}
local cmd_alt_ctrl = {"cmd", "alt", "ctrl"}
local main_monitor = "Color LCD"
local second_monitor = "DELL E2310H"

--------------------------------------------------------------------------------
-- CONFIGURATIONS
--------------------------------------------------------------------------------
hs.window.animationDuration = 0

--------------------------------------------------------------------------------
-- LAYOUTS
-- SINTAX:
--    {
--    name = "App name" or { "App name", "App name" }
--    func = function(index, win)
--        COMMANDS
--    end
--    },
--
-- It searches for application "name" and call "func" for each window object
--------------------------------------------------------------------------------
local layouts = {
    {
    name = {"Airmail", "Calendar", "iTunes", "Last.fm Scrobbler", "Messages", "Skype", "Dash", "Yummy FTP"},
    func = function(index, win)
        win:moveToScreen(hs.screen.get(main_monitor))
        win:maximize()
    end
    },
    {
    name = {"Cocoa Rest Client", "MacDown", "Chrome", "Evernote"},
    func = function(index, win)
        if (#hs.screen.allScreens() > 1) then
            win:moveToScreen(hs.screen.get(second_monitor))
            hs.window.fullscreenCenter(win)
        else
            win:maximize()
        end
    end
    },
    {
    name = {"Android Studio", "Xcode", "SourceTree"},
    func = function(index, win)
        if (#hs.screen.allScreens() > 1) then
            win:moveToScreen(hs.screen.get(second_monitor))
            hs.window.fullscreenWidth(win)
        else
            win:maximize()
        end
    end
    },
    {
    name = {"Finder", "iTerm"},
    func = function(index, win)

        if (index == 1) then
            if (#hs.screen.allScreens() > 1) then
                win:moveToScreen(hs.screen.get(second_monitor))
            end

            win:upLeft()
        elseif (index == 2) then
            if (#hs.screen.allScreens() > 1) then
                win:moveToScreen(hs.screen.get(second_monitor))
            end

            win:downLeft()
        elseif (index == 3) then
            if (#hs.screen.allScreens() > 1) then
                win:moveToScreen(hs.screen.get(second_monitor))
            end

            win:downRight()
        elseif (index == 4) then
            if (#hs.screen.allScreens() > 1) then
                win:moveToScreen(hs.screen.get(second_monitor))
            end

            win:upRight()
        elseif (index == 5) then
            win:moveToScreen(hs.screen.get(main_monitor))
            win:upLeft()
        elseif (index == 6) then
            win:moveToScreen(hs.screen.get(main_monitor))
            win:downLeft()
        elseif (index == 7) then
            win:moveToScreen(hs.screen.get(main_monitor))
            win:downRight()
        elseif (index == 8) then
            win:moveToScreen(hs.screen.get(main_monitor))
            win:upRight()
        else
            win:close()
        end
    end
    },
    {
    name = "iTerm",
    func = function(index, win)
        if (#hs.screen.allScreens() > 1) then
            win:moveToScreen(hs.screen.get(second_monitor))
        end

        if (index == 1) then
            win:left()
        elseif (index == 2) then
            win:right()
        end
    end
    },
    {
    name = "iOS Simulator",
    func = function(index, win)
        if (#hs.screen.allScreens() > 1) then
            win:moveToScreen(hs.screen.get(second_monitor))
        end

        local screen = win:screen()
        local screen_frame = screen:frame()
        local frame = win:frame()
        frame.x = screen_frame.w / 2
        frame.y = screen_frame.y + 50
        frame.w = screen_frame.w / 3
        frame.h = screen_frame.h / 2
        win:setFrame(frame)
    end
    },
    {
    name = {"Chrome", "iTerm"},
    func = function(index, win)
        if (#hs.screen.allScreens() > 1) then
            local allScreens = hs.screen.allScreens()
            for i, screen in ipairs(allScreens) do
                if screen:name() == second_monitor then
                    win:moveToScreen(screen)
                end
            end

            local screen = win:screen()
            win:setFrame({
                x = screen:frame().x,
                y = hs.screen.minY(screen),
                w = hs.screen.minWidth(false) + hs.screen.minX(screen),
                h = hs.screen.minHeight(screen)
            })
        else
            win:maximize()
        end
    end
    },
}

local closeAll = {
    "iTunes",
    "Messages",
    "Word",
    "Excel",
    "Cocoa Rest Client",
    "Preview",
    "Color Picker"
}

local openAll = {
    "Google Chrome",
    "Kitematic",
    "Slack",
    "iTerm",
}

function bindApplications()
    hs.hotkey.bind(alt, "S", function()
        hs.application.open("Slack")
    end)

    hs.hotkey.bind(alt, "C", function()
        hs.application.open("Google Chrome")
    end)

    hs.hotkey.bind(alt, "G", function()
        hs.application.open("Telegram")
    end)

    hs.hotkey.bind(alt, "W", function()
        hs.application.open("WeChat")
    end)

    hs.hotkey.bind(alt, "M", function ()
        hs.application.open("Typora")
    end)

    hs.hotkey.bind(alt, "D", function()
        hs.application.open("DingTalk")
    end)

    hs.hotkey.bind(alt, "T", function ()
        hs.application.open("iTerm")
    end)

    hs.hotkey.bind(alt, "F", function ()
        hs.application.open("Firefox")
    end)

    hs.hotkey.bind(alt, "P", function ()
        hs.application.open("TablePlus")
    end)
end

function bindOrientations()
    hs.hotkey.bind(cmd_alt_ctrl, "left", function()
        local win = hs.window.focusedWindow()
        win:left()
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "right", function()
        local win = hs.window.focusedWindow()
        win:right()
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "up", function()
        local win = hs.window.focusedWindow()
        win:up()
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "down", function()
        local win = hs.window.focusedWindow()
        win:down()
    end)

    hs.hotkey.bind(cmd_alt, "up", function()
        local win = hs.window.focusedWindow()
        win:upRight()
    end)

    hs.hotkey.bind(cmd_alt, "down", function()
        local win = hs.window.focusedWindow()
        win:downLeft()
    end)

    hs.hotkey.bind(cmd_alt, "left", function()
        local win = hs.window.focusedWindow()
        win:upLeft()
    end)

    hs.hotkey.bind(cmd_alt, "right", function()
        local win = hs.window.focusedWindow()
        win:downRight()
    end)

    hs.hotkey.bind(cmd_alt, "c", function()
        local win = hs.window.focusedWindow()
        hs.window.fullscreenCenter(win)
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "c", function()
        local win = hs.window.focusedWindow()
        hs.window.fullscreenAlmostCenter(win)
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "m", function()
        local win = hs.window.focusedWindow()
        hs.window.fullscreenAlmostCenter(win)
    end)

    hs.hotkey.bind(cmd_alt, "f", function()
        local win = hs.window.focusedWindow()
        win:maximize()
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "f", function()
        local win = hs.window.focusedWindow()
        if (win) then
            hs.window.fullscreenWidth(win)
        end
    end)
end

function setupBindings()
    bindApplications()
    bindOrientations()

    hs.hotkey.bind(cmd_alt_ctrl, "R", function ()
        hs.reload()
        hs.alert.show("Hammerspoon config reloaded!")
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "h", function()
        hs.hints.windowHints()
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "1", function()
        local win = hs.window.focusedWindow()
        if (win) then
            win:moveToScreen(hs.screen.get(second_monitor))
        end
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "2", function()
        local win = hs.window.focusedWindow()
        if (win) then
            win:moveToScreen(hs.screen.get(main_monitor))
        end
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "Q", function()
        hs.alert.show("Closing")
        for i,v in ipairs(closeAll) do
            local app = hs.application(v)
            if (app) then
                if (app.name) then
                    hs.alert.show(app:name())
                end
                if (app.kill) then
                    app:kill()
                end
            end
        end
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "O", function()
        hs.alert.show("Openning")
        for i,v in ipairs(openAll) do
            hs.alert.show(v)
            hs.application.open(v)
        end
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "3", function()
        applyLayouts(layouts)
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "4", function()
        local focusedWindow = hs.window.focusedWindow()
        local app = focusedWindow:application()
        if (app) then
            applyLayout(layouts, app)
        end
    end)

    hs.hotkey.bind(cmd_alt_ctrl, "S", function()
        local chrome = hs.application.get("Google Chrome")
        local focusedWindow = hs.window.focusedWindow()
        local app = focusedWindow:application()

        if (app ~= chrome) then
            for i, lwin in ipairs(chrome:allWindows()) do
                if (lwin:isVisible()) then
                    lwin:left()
                end
            end
            focusedWindow:right()
        end
    end)
end
--------------------------------------------------------------------------------
-- END CONFIGURATIONS
--------------------------------------------------------------------------------










--------------------------------------------------------------------------------
-- METHODS - BECAREFUL :)
--------------------------------------------------------------------------------
function applyLayout(layouts, app)
    if (app) then
        for i, layout in ipairs(layouts) do
            if (type(layout.name) == "table") then
                for i, appName in ipairs(layout.name) do
                    layoutAppIfSameTo(app, {name = appName, func = layout.func})
                end
            elseif (type(layout.name) == "string") then
                layoutAppIfSameTo(app, layout)
            end
        end
    end
end


function applyLayouts(layouts)
    for i, layout in ipairs(layouts) do
        if (type(layout.name) == "table") then
            for i, appName in ipairs(layout.name) do
                layoutAppIfFound(appName, layout)
            end
        elseif (type(layout.name) == "string") then
            layoutAppIfFound(layout.name, layout)
        end
    end
end

function layoutAppIfSameTo(app, layout)
    local appName = app:title()
    if (layout.name == appName) then
        layoutApp(app, layout.func)
    end
end

function layoutAppIfFound(name, layout)
    local app = hs.appfinder.appFromName(name)
    if (app) then
        layoutApp(app, layout.func)
    end
end

function layoutApp(app, layouter)
    local wins = app:allWindows()
    local counter = 1
    for j, win in ipairs(wins) do
       if (win:isVisible() and layouter) then
            layouter(counter, win)
            counter = counter + 1
        end
    end
end

function hs.screen.get(screen_name)
    local allScreens = hs.screen.allScreens()
    for i, screen in ipairs(allScreens) do
        if screen:name() == screen_name then
            return screen
        end
    end
end

-- Returns the width of the smaller screen size
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minWidth(isFullscreen)
    local min_width = math.maxinteger
    local allScreens = hs.screen.allScreens()
    for i, screen in ipairs(allScreens) do
        local screen_frame = screen:frame()
        if (isFullscreen) then
            screen_frame = screen:fullFrame()
        end
        min_width = math.min(min_width, screen_frame.w)
    end
    return min_width
end

-- isFullscreen = false removes the toolbar
-- and dock sizes
-- Returns the height of the smaller screen size
function hs.screen.minHeight(isFullscreen)
    local min_height = math.maxinteger
    local allScreens = hs.screen.allScreens()
    for i, screen in ipairs(allScreens) do
        local screen_frame = screen:frame()
        if (isFullscreen) then
            screen_frame = screen:fullFrame()
        end
        min_height = math.min(min_height, screen_frame.h)
    end
    return min_height
end

-- If you are using more than one monitor, returns X
-- considering the reference screen minus smaller screen
-- = (MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.minX(refScreen)
    local min_x = refScreen:frame().x
    local allScreens = hs.screen.allScreens()
    if (#allScreens > 1) then
        min_x = refScreen:frame().x + ((refScreen:frame().w - hs.screen.minWidth()) / 2)
    end
    return min_x
end

-- If you are using more than one monitor, returns Y
-- considering the focused screen minus smaller screen
-- = (MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2
-- If using only one monitor, returns the Y of focused screen
function hs.screen.minY(refScreen)
    local min_y = refScreen:frame().y
    local allScreens = hs.screen.allScreens()
    if (#allScreens > 1) then
        min_y = refScreen:frame().y + ((refScreen:frame().h - hs.screen.minHeight()) / 2)
    end
    return min_y
end

-- If you are using more than one monitor, returns the
-- half of minX and 0
-- = ((MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.almostMinX(refScreen)
    local min_x = refScreen:frame().x
    local allScreens = hs.screen.allScreens()
    if (#allScreens > 1) then
        min_x = refScreen:frame().x + (((refScreen:frame().w - hs.screen.minWidth()) / 2) -
                                       ((refScreen:frame().w - hs.screen.minWidth()) / 4))
    end
    return min_x
end

-- If you are using more than one monitor, returns the
-- half of minY and 0
-- = ((MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2) / 2
-- If using only one monitor, returns the Y of ref screen
function hs.screen.almostMinY(refScreen)
    local min_y = refScreen:frame().y
    local allScreens = hs.screen.allScreens()
    if (#allScreens > 1) then
        min_y = refScreen:frame().y + (((refScreen:frame().h - hs.screen.minHeight()) / 2) -
                                       ((refScreen:frame().h - hs.screen.minHeight()) / 4))
    end
    return min_y
end

-- Returns the frame of the smaller available screen
-- considering the context of refScreen
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minFrame(refScreen, isFullscreen)
    return {
        x = hs.screen.minX(refScreen),
        y = hs.screen.minY(refScreen),
        w = hs.screen.minWidth(isFullscreen),
        h = hs.screen.minHeight(isFullscreen)
    }
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function hs.window.right(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    minFrame.x = minFrame.x + (minFrame.w/2)
    minFrame.w = minFrame.w/2
    win:setFrame(minFrame)
end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function hs.window.left(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    minFrame.w = minFrame.w/2
    win:setFrame(minFrame)
end

-- +-----------------+
-- |        HERE     |
-- +-----------------+
-- |                 |
-- +-----------------+
function hs.window.up(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    minFrame.h = minFrame.h/2
    win:setFrame(minFrame)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |        HERE     |
-- +-----------------+
function hs.window.down(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    minFrame.y = minFrame.y + minFrame.h/2
    minFrame.h = minFrame.h/2
    win:setFrame(minFrame)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function hs.window.upLeft(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    minFrame.w = minFrame.w/2
    minFrame.h = minFrame.h/2
    win:setFrame(minFrame)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function hs.window.downLeft(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    win:setFrame({
    x = minFrame.x,
    y = minFrame.y + minFrame.h/2,
    w = minFrame.w/2,
    h = minFrame.h/2
    })
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function hs.window.downRight(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    win:setFrame({
    x = minFrame.x + minFrame.w/2,
    y = minFrame.y + minFrame.h/2,
    w = minFrame.w/2,
    h = minFrame.h/2
    })
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function hs.window.upRight(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    win:setFrame({
    x = minFrame.x + minFrame.w/2,
    y = minFrame.y,
    w = minFrame.w/2,
    h = minFrame.h/2
    })
end

-- +------------------+
-- |                  |
-- |    +--------+    +--> minY
-- |    |  HERE  |    |
-- |    +--------+    |
-- |                  |
-- +------------------+
-- Where the window's size is equal to
-- the smaller available screen size
function hs.window.fullscreenCenter(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    win:setFrame(minFrame)
end

-- +------------------+
-- |                  |
-- |   +------------+ +--> minY
-- |   |    HERE    | |
-- |   +------------+ |
-- |                  |
-- +------------------+
function hs.window.fullscreenAlmostCenter(win)
    local offsetW = hs.screen.minX(win:screen()) - hs.screen.almostMinX(win:screen())
    win:setFrame({
    x = hs.screen.almostMinX(win:screen()),
    y = hs.screen.minY(win:screen()),
    w = hs.screen.minWidth(isFullscreen) + (2 * offsetW),
    h = hs.screen.minHeight(isFullscreen)
    })
end

-- It like fullscreen but with minY and minHeight values
-- +------------------+
-- |                    |
-- +------------------+--> minY
-- |         HERE         |
-- +------------------+--> minHeight
-- |                    |
-- +------------------+
function hs.window.fullscreenWidth(win)
    local minFrame = hs.screen.minFrame(win:screen(), false)
    win:setFrame({
        x = win:screen():frame().x,
        y = minFrame.y,
        w = win:screen():frame().w,
        h = minFrame.h
    })
end

function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        if (appName == "iTerm") then
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        elseif (appName == "Finder") then
            appObject:selectMenuItem({"Window", "Bring All to Front"})
        end
    end

    if (eventType == hs.application.watcher.launched) then
        -- os.execute("sleep " .. tonumber(3))
        applyLayout(layouts, appObject)
    end
end

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

setupBindings()
hs.application.watcher.new(applicationWatcher):start()
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
