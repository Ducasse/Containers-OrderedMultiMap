tests-accessing
testSize
	self assert: collection size equals: 0.
	collection add: '1' -> 'foo'.
	self assert: collection size equals: 1.
	collection add: '2' -> 'bar'.
	self assert: collection size equals: 2.
	collection add: '1' -> 'baz'.
	self 
		assert: collection size 
		equals: (self allowsDuplicateKeys ifTrue: [ 3 ] ifFalse: [ 2 ])