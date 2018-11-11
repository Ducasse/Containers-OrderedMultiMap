accessing
at: aKey add: aValue
	"Add aValue to the collection of values associated to aKey. Do not replace existing values with the same key."
	"(CTOrderedMultiMap new at: '1' add: 'foo'; at: '1' add: 'bar'; yourself) allAt: '1' >>> #('foo' 'bar')"
	
	^ self privateAt: aKey put: aValue