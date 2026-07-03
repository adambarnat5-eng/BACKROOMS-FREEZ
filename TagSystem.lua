-- TagSystem script (place in ServerScriptService)
local GameManager = _G.GameManager
local FreezeManager = _G.FreezeManager

local function setupTouchDetection(player)
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Create a touch detector
    humanoidRootPart.Touched:Connect(function(hit)
        if GameManager.gameState ~= "Playing" then return end
        
        local otherPlayer = game.Players:GetPlayerFromCharacter(hit.Parent)
        if not otherPlayer then return end
        
        -- Seeker touches Hider
        if GameManager.seekers[player] and GameManager.hiders[otherPlayer] then
            print(player.Name .. " (Seeker) caught " .. otherPlayer.Name .. " (Hider)")
            FreezeManager.freezePlayer(otherPlayer)
            
        -- Hider touches Frozen player to unfreeze
        elseif GameManager.hiders[player] and GameManager.frozenPlayers[otherPlayer] then
            print(player.Name .. " unfroze " .. otherPlayer.Name)
            FreezeManager.unfreezePlayer(otherPlayer)
        end
    end)
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(0.5) -- Wait for character to load
        setupTouchDetection(player)
    end)
end)
