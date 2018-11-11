tests-enumerating
testKeysAndValuesDo
	| iterated |
	collection keysAndValuesDo: [ :key :value |
		self assert: false ].
	collection add: '1' -> 'foo'; add: '2' -> 'bar'; add: '1' -> 'baz'.
	iterated := Array streamContents: [ :stream |
		collection keysAndValuesDo: [ :key :value |
			stream nextPut: key -> value ] ].
	self assert: iterated size equals: (self allowsDuplicateKeys ifTrue: [ 3 ] ifFalse: [ 2 ]).
	self 
		assert: iterated first 
		equals: (self allowsDuplicateKeys ifTrue: [ '1' -> 'foo' ] ifFalse: [ '1' -> 'baz' ]).
	self assert: iterated second equals: ('2' -> 'bar').
	self allowsDuplicateKeys ifTrue: [
		self assert: iterated third equals: ('1' -> 'baz') ]