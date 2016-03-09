Music = {}
Music.__index = Music

setmetatable(Music, {
  __index = Music,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Music:_init()
	self.music = {}

	self.music["prelude"] = love.audio.newSource("media/music/prelude.ogg")
	self.music["prelude"]:setLooping(true)

	self.music["main"] = love.audio.newSource("media/music/larik.ogg")
	self.music["main"]:setLooping(true)

	self.music["cutscene"] = love.audio.newSource("media/music/mysteryManor.ogg")
	self.music["cutscene"]:setLooping(true)

	self.music["gameOver"] = love.audio.newSource("media/music/noHope.ogg")
	self.music["gameOver"]:setLooping(true)

	self.currentSong = ""
end

function Music.playMusic(self, songName)
	local song = self.music[songName]
	if self.currentSong == song then
		return
	end

	if self.currentSong ~= "" then
		self.currentSong:stop()
	end

	song:setVolume(options.soundOptions.masterVolume * options.soundOptions.bgmVolume)
	song:play()
	self.currentSong = song
end

function Music.stopAllSounds(self)
	if self.currentSong ~= "" then
		self.currentSong:stop()
	end
end

function Music.applyVolume(self)
	self.currentSong:setVolume(options.soundOptions.masterVolume * options.soundOptions.bgmVolume)
end

