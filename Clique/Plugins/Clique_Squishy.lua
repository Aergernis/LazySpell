--[[---------------------------------------------------------------------------------
  This is a template for the plugin/module system for Clique.

  Plugins are typically used to tie Clique to a specific set of unit frames, but 
  can also be used to add functionality to the system through a manner of hooks.
  
  Plugins are registered with Clique with a shortname that is used for all slash
  commands.  In addition they are required to have a fullname parameter that is
  used in all display messages
----------------------------------------------------------------------------------]]

-- Create a new plugin for Clique, with the shortname "test"
local Plugin = Clique:NewModule("squishy")
Plugin.fullname = "Squishy Emergency Monitor"
Plugin.url = "http://svn.wowace.com/root/trunk/Squishy/"

-- Plugin:Test() is called anytime the mod tries to enable.  It is optional
-- but it will be checked if it exists.  Will typically be based off some global
-- or the state of the addon itself.
function Plugin:Test()
    return Squishy
end

-- Plugin:OnEnable() is called if Plugin:Test() is true, and the mod hasn't been explicitly
-- disabled.  This is where you should handle all your hooks, etc.
function Plugin:OnEnable()
    SquishyCustomClick = self.OnClick
end

-- Plugin:OnDisable() is called if the mod is enabled and its being explicitly disabled.
-- This function is optional.  If it doesn't exist, Plugin:UnregisterAllEvents() and
-- Plugin:UnregisterAllHooks().
function Plugin:OnDisable()
    SquishyCustomClick = nil
end

function Plugin.OnClick(button, unit)
    if not Clique:OnClick(button, this.unit) then
        if button == "LeftButton" then 
            TargetUnit(unit)
        elseif button == "RightButton" then 
            Clique:UnitMenu(unit)
        end
    end
end