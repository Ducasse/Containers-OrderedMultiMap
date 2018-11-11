tests-accessing
testAtPutReplaceExistingValues

	collection at: '1' put: 'foo'.
	self assert: (collection allAt: '1') equals: #('foo').
	collection at: '1' put: 'bar'.
	self assert: (collection allAt: '1') equals: #('bar').
	self assertAssociations: (Array  with: '1' -> 'bar')