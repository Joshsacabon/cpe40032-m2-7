--[[
    ScoreState Class

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local bronze = love.graphics.newImage('bronze.png')
local silver = love.graphics.newImage('silver.png')
local gold = love.graphics.newImage('gold.png')
local circle = love.graphics.newImage('circle.png')
local HighScore = 0

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return')  then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(BigFont)
    love.graphics.printf('Game Over!', 0, 60 , VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(largeFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 135, VIRTUAL_WIDTH-90, 'center')

    if HighScore < self.score then
        HighScore = self.score
    end 

    love.graphics.setFont(mediumFont)
    love.graphics.printf('High Score: ' .. tostring(HighScore), 0, 170, VIRTUAL_WIDTH-90, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Medal',  0, VIRTUAL_HEIGHT-92, VIRTUAL_WIDTH + 149, 'center')

    -- Awarding medals for every scores obtained  
    if self.score < 10 then
        love.graphics.draw(circle, VIRTUAL_WIDTH/2 + 29, 102)   
    elseif self.score >= 10 and self.score < 20 then
        love.graphics.draw(bronze, VIRTUAL_WIDTH/2 + 27, 99)
    elseif self.score >= 20 and self.score < 35  then
        love.graphics.draw(silver, VIRTUAL_WIDTH/2 + 26, 100)
    else
        love.graphics.draw(gold, VIRTUAL_WIDTH/2 + 25, 100)
    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Play Again!', 0, 220, VIRTUAL_WIDTH, 'center')
end