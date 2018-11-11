tests-accessing
testRemoveKeyIfAbsent
	self assert: (collection removeKey: '1' ifAbsent: [ 'absent' ]) equals: 'absent'.
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	collection add: '2' -> 'baz'.
	self 
		assert: (collection removeKey: '1' ifAbsent: [ 'absent' ]) 
		equals: (self allowsDuplicateKeys ifTrue: [ #('foo' 'bar') ] ifFalse: [ 'bar' ]).
	self assertAssociations: (Array with: '2' -> 'baz').
	self 
		assert: (collection removeKey: '2' ifAbsent: [ 'absent' ]) 
		equals: (self allowsDuplicateKeys ifTrue: [ #('baz') ] ifFalse: [ 'baz' ]).
	self assertAssociations: #()