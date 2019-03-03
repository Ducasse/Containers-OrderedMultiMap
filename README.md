# Containers-OrderedMultiMap

This package is part of the Containers project: This project is to collect, clean, 
test and document alternate collection datastructures. Each package is modular so that users 
can only load the collection they need without 100 of related collections.


```
CTOrderedMultiMapTest >> testAllAt [
	self assert: (collection allAt: '1') equals: #().
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1') equals: #( 'foo' 'bar' ).
	self assert: (collection at: '1') equals: 'foo' 
]
```
----
The best way to predict the future is to do it!
Less talking more doing. 
