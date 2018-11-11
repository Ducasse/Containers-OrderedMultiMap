tests-accessing
testAtIfAbsent
	self assert: (collection at: '1' ifAbsent: [ 'foo' ]) equals: 'foo'.
	collection add: '1' -> 'bar'.
	collection add: '1' -> 'baz'.
	self 
		assert: (collection at: '1' ifAbsent: [ 'foo' ]) 
		equals: (self allowsDuplicateKeys ifTrue: [ 'bar' ] ifFalse: [ 'baz' ])