tests-accessing
testAtIfAbsentPut
	self assert: (collection at: '1' ifAbsentPut: [ 'foo' ]) equals: 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo').
	self assert: (collection allAt: '1') equals: #('foo').
	self assert: (collection at: '1' ifAbsentPut: [ 'bar' ]) equals: 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo')