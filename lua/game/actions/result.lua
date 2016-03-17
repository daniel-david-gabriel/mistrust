Result = {}
Result.__index = Result

setmetatable(Result, {
  __index = Result,
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Result:_init(trust, riot, text)
	self.trust = trust
	self.riot = riot
	self.text = text
end
