asserting
assertAssociations: anOrderedCollection
	| associations iterated |
	associations := collection associations.
	iterated := Array streamContents: [ :stream |
		collection associationsDo: [ :each | stream nextPut: each ] ].
	self assert: associations size equals: anOrderedCollection size.
	self assert: iterated size equals: anOrderedCollection size.
	1 to: anOrderedCollection size do: [ :index |
		self assert: (associations at: index) equals: (anOrderedCollection at: index).
		self assert: (iterated at: index) equals: (anOrderedCollection at: index) ]