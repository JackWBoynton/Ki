--- === StatusDisplay ===
---
--- Menubar icon text display

local StatusDisplay = {}
StatusDisplay.__index = StatusDisplay
StatusDisplay.__name = "status-display"

StatusDisplay.menuBar = hs.menubar.new()

local _, inDarkMode = hs.osascript.applescript([[
    tell application "System Events" to tell appearance preferences to return dark mode
]])

function StatusDisplay:updateMenuBarText(text)
    local style = {
        color = inDarkMode
                and { red = 0.8, blue = 0.8, green = 0.8 }
                or { red = 0, blue = 0, green = 0 },
        font = { name = "Menlo", size = 10 },
    }
    self.menuBar:setTitle(hs.styledtext.new(text, style))
end

--- StatusDisplay:show(status[, parenthetical])
--- Method
--- Updates the text in the menu bar icon to indicate the current mode
---
--- Parameters:
---  * `status` - a string value containing the current mode (i.e., `"normal"`, `"entity"`, etc.)
---  * `parenthetical` - an optional string value of some parenthetical in the text display
---
--- Returns:
---  * None
function StatusDisplay:show(status, parenthetical)
    local statusText = status:upper()
    local text = parenthetical and statusText.." ("..parenthetical..")" or statusText
    self:updateMenuBarText("-- "..text.." --")
end

return StatusDisplay
