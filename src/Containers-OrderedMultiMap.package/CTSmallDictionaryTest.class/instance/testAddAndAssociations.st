tests-accessing
testAddAndAssociations
	| association |
	association := collection add: '1' -> 'foo'.
	self assert: association key equals: '1'.
	self assert: association value equals: 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo').
	
	association := collection add: '2' -> 'bar'.
	self assert: association key equals: '2'.
	self assert: association value equals: 'bar'.
	self assertAssociations: (Array with: '1' -> 'foo' with: '2' -> 'bar').
	
	association := collection add: '1' -> 'baz'.
	self assert: association key equals: '1'.
	self assert: association value equals: 'baz'.
	self assertAssociations:
		(self allowsDuplicateKeys
			ifFalse: [ Array with: '1' -> 'baz' with: '2' -> 'bar' ]
			ifTrue: [ Array with: '1' -> 'foo' with: '2' -> 'bar' with: '1' -> 'baz' ])
