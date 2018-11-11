accessing
allAt: aKey
	"Return all the values associated with aKey"
	"(CTOrderedMultiMap new at: '1' add: 'foo'; at: '1' add: 'bar'; yourself) allAt: '1' 
	>>> #('foo' 'bar')"
	^ Array streamContents: [ :stream |
		1 to: size do: [ :index |
			(keys at: index) = aKey
				ifTrue: [ stream nextPut: (values at: index) ] ] ]