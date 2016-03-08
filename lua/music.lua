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

	self.currentSong = ""
end

function Music.playMusic(self, songName)
	if not options.sound then
		return
	end

	local song = self.music[songName]

	if self.currentSong == song then
		return
	end

	if self.currentSong ~= "" then
		self.currentSong:stop()
	end

	song:play()
	self.currentSong = song
end

function Music.stopAllSounds(self)
	if self.currentSong ~= "" then
		self.currentSong:stop()
	end
end

