Class {
	#name : #CTSmallDictionaryTest,
	#superclass : #TestCase,
	#instVars : [
		'collection'
	],
	#category : 'Containers-OrderedMultiMap-Tests'
}

{ #category : #configuration }
CTSmallDictionaryTest >> allowsDuplicateKeys [
	^ false
]

{ #category : #asserting }
CTSmallDictionaryTest >> assertAssociations: anOrderedCollection [
	| associations iterated |
	associations := collection associations.
	iterated := Array streamContents: [ :stream |
		collection associationsDo: [ :each | stream nextPut: each ] ].
	self assert: associations size equals: anOrderedCollection size.
	self assert: iterated size equals: anOrderedCollection size.
	1 to: anOrderedCollection size do: [ :index |
		self assert: (associations at: index) equals: (anOrderedCollection at: index).
		self assert: (iterated at: index) equals: (anOrderedCollection at: index) ]
]

{ #category : #configuration }
CTSmallDictionaryTest >> collectionClass [
	^ CTSmallDictionary
]

{ #category : #configuration }
CTSmallDictionaryTest >> isKey: anObject equivalentTo: anotherObject [
	^ anObject = anotherObject
]

{ #category : #configuration }
CTSmallDictionaryTest >> newCollection [
	^ self collectionClass new
]

{ #category : #running }
CTSmallDictionaryTest >> setUp [
	super setUp.
	collection := self newCollection
]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testAddAll [
	| dict result |
	dict := (Dictionary new at: '1' put: 'foo'; yourself).
	result := collection addAll: dict.
	self assert: result == dict.
	self assertAssociations: (Array with: '1' -> 'foo').
	
	dict := (CTOrderedMultiMap new at: '1' put: 'foo'; at: '1' add: 'bar'; yourself).
	collection := self newCollection.
	result := collection addAll: dict.
	self assert: result == dict.
	self assertAssociations:
		(self allowsDuplicateKeys
			ifFalse: [ Array with: '1' -> 'bar' ]
			ifTrue: [ Array with: '1' -> 'foo' with: '1' -> 'bar' ])

]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testAddAndAssociations [
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

]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testAt [
	self should: [ collection at: '1' ] raise: Error.
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	self 
		assert: (collection at: '1') 
		equals: (self allowsDuplicateKeys ifTrue: [ 'foo' ] ifFalse: [ 'bar' ])
]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testAtIfAbsent [
	self assert: (collection at: '1' ifAbsent: [ 'foo' ]) equals: 'foo'.
	collection add: '1' -> 'bar'.
	collection add: '1' -> 'baz'.
	self 
		assert: (collection at: '1' ifAbsent: [ 'foo' ]) 
		equals: (self allowsDuplicateKeys ifTrue: [ 'bar' ] ifFalse: [ 'baz' ])
]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testAtIfAbsentPut [
	self assert: (collection at: '1' ifAbsentPut: [ 'foo' ]) equals: 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo').
	self assert: (collection at: '1' ifAbsentPut: [ 'bar' ]) equals: 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo')
]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testAtIfPresent [
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	self 
		assert: (collection at: '1' ifPresent: [ :v | v , 'baz' ]) 
		equals: (self allowsDuplicateKeys ifTrue: [ 'foobaz' ] ifFalse: [ 'barbaz' ]).
	self assert: (collection at: '2' ifPresent: [ :v | v , 'baz' ]) isNil
]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testAtPut [
	collection at: '1' put: 'foo'.
	collection at: '2' put: 'bar'.
	self assertAssociations: (Array with: '1' -> 'foo' with: '2' -> 'bar').
	collection at: '1' put: 'baz'.
	self assertAssociations: (Array with: '1' -> 'baz' with: '2' -> 'bar')
]

{ #category : #tests }
CTSmallDictionaryTest >> testCopy [
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
]

{ #category : #'tests-enumerating' }
CTSmallDictionaryTest >> testDo [
	| result |
	result := OrderedCollection new.
	collection at: '1' put: 'foo'; at: '2' put: 'bar'.
	collection do: [ :each | result add: each ].
	self assert: result asArray equals: #( 'foo' 'bar' )
]

{ #category : #tests }
CTSmallDictionaryTest >> testGrow [
	1 to: 100 do: [ :i |
		collection at: i put: i negated.
		self assert: collection size equals: i.
		[ :array :factor |
			self assert: array size equals: i.
			1 to: i do: [ :j | self assert: (array at: j) equals: (factor * j) ] ]
				value: collection keys value: 1;
				value: collection values value: -1 ]
]

{ #category : #'tests-testing' }
CTSmallDictionaryTest >> testIncludesKey [
	self deny: (collection includesKey: '1').
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	self assert: (collection includesKey: '1')
]

{ #category : #'tests-testing' }
CTSmallDictionaryTest >> testIsCollection [
	self assert: collection isCollection
]

{ #category : #'tests-testing' }
CTSmallDictionaryTest >> testIsEmpty [
	self assert: collection isEmpty.
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	self deny: collection isEmpty
]

{ #category : #'tests-enumerating' }
CTSmallDictionaryTest >> testKeys [
	collection add: '1' -> 'foo'; add: '2' -> 'bar'; add: '1' -> 'baz'.
	self 
		assert: collection keys 
		equals: (self allowsDuplicateKeys ifTrue: [ #('1' '2' '1') ] ifFalse: [ #('1' '2') ])
]

{ #category : #'tests-enumerating' }
CTSmallDictionaryTest >> testKeysAndValuesDo [
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
]

{ #category : #'tests-enumerating' }
CTSmallDictionaryTest >> testKeysDo [
	| result |
	result := OrderedCollection new.
	collection add: '1' -> 'foo'; add: '2' -> 'bar'; add: '1' -> 'baz'.
	collection keysDo: [ :each | result add: each ].
	self 
		assert: result asArray 
		equals: (self allowsDuplicateKeys ifTrue: [ #('1' '2' '1') ] ifFalse: [ #('1' '2') ])
]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testRemoveKey [
	self should: [ collection removeKey: '1' ] raise: Error.
	collection add: '1' -> 'foo'.
	collection add: '1' -> 'bar'.
	collection add: '2' -> 'baz'.
	self 
		assert: (collection removeKey: '1') 
		equals: (self allowsDuplicateKeys ifTrue: [ #('foo' 'bar') ] ifFalse: [ 'bar' ]).
	self assertAssociations: (Array with: '2' -> 'baz').
	self 
		assert: (collection removeKey: '2') 
		equals: (self allowsDuplicateKeys ifTrue: [ #('baz') ] ifFalse: [ 'baz' ]).
	self assertAssociations: #()
]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testRemoveKeyIfAbsent [
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
]

{ #category : #'tests-accessing' }
CTSmallDictionaryTest >> testSize [
	self assert: collection size equals: 0.
	collection add: '1' -> 'foo'.
	self assert: collection size equals: 1.
	collection add: '2' -> 'bar'.
	self assert: collection size equals: 2.
	collection add: '1' -> 'baz'.
	self 
		assert: collection size 
		equals: (self allowsDuplicateKeys ifTrue: [ 3 ] ifFalse: [ 2 ])
]

{ #category : #'tests-enumerating' }
CTSmallDictionaryTest >> testValues [
	collection add: '1' -> 'foo'; add: '2' -> 'bar'; add: '1' -> 'baz'.
	self 
		assert: collection values 
		equals: (self allowsDuplicateKeys ifTrue: [ #('foo' 'bar' 'baz') ] ifFalse: [ #('baz' 'bar') ])
]

{ #category : #tests }
CTSmallDictionaryTest >> testWithAll [
	| dict |
	dict := (Dictionary new at: '1' put: 'foo'; yourself).
	collection := self collectionClass withAll: dict.
	self assertAssociations: (Array with: '1' -> 'foo').
	
	dict := (CTOrderedMultiMap new at: '1' put: 'foo'; at: '1' add: 'bar'; yourself).
	collection := self collectionClass withAll: dict.
	self assertAssociations:
		(self allowsDuplicateKeys
			ifFalse: [ Array with: '1' -> 'bar' ]
			ifTrue: [ Array with: '1' -> 'foo' with: '1' -> 'bar' ])

]
