local cell = {
	state = false
}

function cell.getState(self)
	return self.state
end

function cell.setState(self, s)
	self.state = s
end