tests-accessing
testAllAt
	self assert: (collection allAt: '1') equals: #().
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1') equals: #( 'foo' 'bar' ).
	self assert: (collection at: '1') equals: 'foo' 