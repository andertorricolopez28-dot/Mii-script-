local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local Speed = 28
local MinSpeed = 16
local MaxSpeed = 55
local Step = 4
local Enabled = true

local function ApplySpeed()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health > 0 then
        humanoid.WalkSpeed = Speed
    end
end

RunService.Heartbeat:Connect(function()
    if Enabled then
        ApplySpeed()
    end
end)

player.CharacterAdded:Connect(function()
    task.wait(0.4)
    ApplySpeed()
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.Equals or input.KeyCode == Enum.KeyCode.KeypadPlus then
        Speed = math.clamp(Speed + Step, MinSpeed, MaxSpeed)
        print("[Speed] ↑ " .. Speed)

    elseif input.KeyCode == Enum.KeyCode.Minus or input.KeyCode == Enum.KeyCode.KeypadMinus then
        Speed = math.clamp(Speed - Step, MinSpeed, MaxSpeed)
        print("[Speed] ↓ " .. Speed)

    elseif input.KeyCode == Enum.KeyCode.Zero or input.KeyCode == Enum.KeyCode.KeypadZero then
        Speed = 16
        print("[Speed] Normal")

    elseif input.KeyCode == Enum.KeyCode.P then
        Enabled = not Enabled
        print("[Speed] " .. (Enabled and "ACTIVADO" or "DESACTIVADO"))
    end
end)

print("Script de velocidad cargado correctamente")
print("Controles: + subir | - bajar | 0 normal | P on/off")