local ldb = LibStub:GetLibrary("LibDataBroker-1.1")

local holder = CreateFrame("Frame")
local dataobj = ldb:NewDataObject("ReflectionsOfTheSoul", {type = "data source", text = "Reflections"})
local enabled = true

local function ParseLogMessage(timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, recipientGUID, recipientName, recipientFlags, recipientRaidFlags, ...)
    local miss_type = arg[1]
    if event == 'SPELL_MISS' and miss_type == "REFLECT" and recipientGUID == UnitGUID("player") then
        print("Detected reflect.")
    end
end

holder:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
holder:SetScript("OnEvent", function(self, event, arg1, arg2, ...)
    ParseLogMessage(arg1, arg2, ...)
end)

function dataobj:OnTooltipShow()
    if enabled then
        self:AddLine("Reflections: Enabled")
    else
        self:AddLine("Reflections: Disabled")
    end
end

function dataobj:OnClick()
    enabled = not enabled
end