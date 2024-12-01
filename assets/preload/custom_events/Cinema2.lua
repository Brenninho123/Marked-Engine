local posS = {-200, 720}
local posV = {-100, 620}
local cinemaOn = false
function onCreate()
	for i=1,2 do
		makeLuaSprite('bar'..i, nil, -200, posS[i])
		makeGraphic('bar'..i, screenWidth + 150, 200, '000000')
		setObjectCamera('bar'..i, 'hud')
		setProperty('bar'..i..'.x', -75)
	end
end

function onUpdate(elapsed)
	if cinemaOn then
		for i=1,2 do
			setProperty('bar'..i..'.y', lerp(getProperty('bar'..i..'.y'), posV[i], elapsed))
		end
		setProperty('camHUD.zoom', lerp(getProperty('camHUD.zoom'), 0.9, elapsed))
		setProperty('camGame.zoom', lerp(getProperty('camGame.zoom'), getProperty('defaultCamZoom') - 0.1, elapsed))
		setProperty('camZooming', false)
	else
		for i=1,2 do
			setProperty('bar'..i..'.y', lerp(getProperty('bar'..i..'.y'), posS[i], elapsed * 8))
		end
	end
end

function onChange()
	if cinemaOn then
		cinemaOn = false
		setProperty('camZooming', true)
	else
		cinemaOn = true
	end
end

function lerp(a, b, ratio)
	return a + ratio * (b - a)
end

function onEvent(n)
	if n == 'Cinema2' then onChange() end
end