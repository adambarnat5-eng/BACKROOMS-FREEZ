-- GameStarter script (place in ServerScriptService)
game.Players.PlayerAdded:Connect(function()
    if game.Players.NumPlayers >= 2 then
        local players = game.Players:GetPlayers()
        _G.StartGame(players)
    end
end)
