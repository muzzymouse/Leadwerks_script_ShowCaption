--[[
Leadwerks Game Engine.
Скрипт отображения подписи для объекта.
]]--

Script.ObjectDescription = "" --String "Caption"
Script.TextColor = Vec3(255,255,0) --Vec3 "Text color" 0 255
Script.FontFile="Fonts/arial.ttf"--path "Font" "Font file (*.ttf):ttf|Font"
Script.FontSize = 25 -- Int "Font size"
Script.DisplayTimeMax = 5000 --Int "Display time"

Script.Used = "0"
Script.DisplayTime = 0
Script.DisplayEnabled = false
local font = Font:Load(Script.FontFile, Script.FontSize)

function Script:Use(context)
   self.Used = "1"
   self.CurrentTime = Time:GetCurrent()
   self.DisplayTime = Time:GetCurrent() + self.DisplayTimeMax
end --end Script:Use

function Script:PostRender(context)
   if self.Used == "1" then
      context:SetBlendMode(Blend.Alpha)
      context:SetFont(font)
      self.DisplayEnabled = true
        if self.DisplayEnabled then
          if self.DisplayTime > Time:GetCurrent() then
            local x = context:GetWidth()/2
            local y = context:GetHeight()/2
            x = x - font:GetTextWidth(self.ObjectDescription)/2
            y = y - self.FontSize/2
            context:SetColor(self.TextColor.x,self.TextColor.y,self.TextColor.z)
            context:DrawText(self.ObjectDescription, x, y)
          else
            self.DisplayEnabled = false
            self.Used = "0"
          end
        end
      context:SetBlendMode(Blend.Solid)
    end
end --end Script:PostRender
