require("lua/controls")
require("lua/screen")
require("lua/mainMenu")
require("lua/loadingScreen")
require("lua/game")
require("lua/options")
require("lua/game/nameGenerator")
require("lua/game/faceGenerator")

function love.load()
	--myFont = love.graphics.newImageFont("media/core/font.png", " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,!?\'\"0123456789-+")
	myFont = love.graphics.newFont("media/core/alagard.ttf", 30)
	love.graphics.setFont(myFont)

	activeState = LoadingScreen()
	toState = nil

	screen = Screen()

	mainMenu = MainMenu()

	options = Options()
	controls = Controls()

	game = Game()
end

function love.draw()
	activeState:draw()
	
	if options.displayFPS then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.print(love.timer.getFPS(), 10, 10)
	end
end

function love.keypressed(key)
	if controls:isQuit(key) then
		love.event.push("quit")
		return
	end
	activeState:processControls(key)
end

function love.gamepadpressed( joystick, button )
	--if options.debug then
		print(button)
	--end
	activeState:processControls(button)
end

function love.keyreleased(key)
	activeState:keyreleased(key)
end

function love.mousepressed(x, y, button)
	activeState:mousepressed(x,y,button)
end

function love.update(dt)
	if toState then
		activeState = toState
		toState = nil
	end
	activeState:update(dt)
end

