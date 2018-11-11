tests
testCopy
	| other |
	collection at: 1 put: 'foo'; at: 2 put: 'bar'.
	other := collection copy.
	collection at: 1 put: 'zork'; at: 3 put: 'zonk'.
	other at: 2 put: 'other'.
	
	self assert: collection size equals: 3.
	self assert: (collection at: 1) equals: 'zork'.
	self assert: (collection at: 2) equals: 'bar'.
	self assert: (collection at: 3) equals: 'zonk'.
	
	self assert: other size equals: 2.
	self assert: (other at: 1) equals: 'foo'.
	self assert: (other at: 2) equals: 'other'