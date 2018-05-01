tests-accessing
testAtPut
	collection at: '1' put: 'foo'.
	collection at: '1' put: 'bar'.
	self assertAssociations: (Array  with: '1' -> 'bar')