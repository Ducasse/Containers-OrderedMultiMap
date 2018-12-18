Class {
	#name : #CTOrderedMultiMapTest,
	#superclass : #CTSmallDictionaryTest,
	#category : 'Containers-OrderedMultiMap-Tests'
}

{ #category : #testing }
CTOrderedMultiMapTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #configuration }
CTOrderedMultiMapTest >> allowsDuplicateKeys [
	^ true
]

{ #category : #configuration }
CTOrderedMultiMapTest >> collectionClass [
	^ CTOrderedMultiMap
]

{ #category : #'tests-accessing' }
CTOrderedMultiMapTest >> testAllAt [
	self assert: (collection allAt: '1') equals: #().
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1') equals: #( 'foo' 'bar' ).
	self assert: (collection at: '1') equals: 'foo' 
]

{ #category : #'tests-accessing' }
CTOrderedMultiMapTest >> testAllAtIfAbsent [
	self assert: (collection allAt: '1' ifAbsent: [ 'absent' ]) equals: 'absent'.
	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assert: (collection allAt: '1' ifAbsent: [ 'absent' ]) equals: #( 'foo' 'bar' )
]

{ #category : #'tests-accessing' }
CTOrderedMultiMapTest >> testAtAdd [

	collection at: '1' add: 'foo'.
	collection at: '1' add: 'bar'.
	self assertAssociations: (Array with: '1' -> 'foo' with: '1' -> 'bar')
]

{ #category : #'tests-accessing' }
CTOrderedMultiMapTest >> testAtIfAbsentPut [
	self assert: (collection at: '1' ifAbsentPut: [ 'foo' ]) equals: 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo').
	self assert: (collection allAt: '1') equals: #('foo').
	self assert: (collection at: '1' ifAbsentPut: [ 'bar' ]) equals: 'foo'.
	self assertAssociations: (Array with: '1' -> 'foo')
]

{ #category : #'tests-accessing' }
CTOrderedMultiMapTest >> testAtPutReplaceExistingValues [

	collection at: '1' put: 'foo'.
	self assert: (collection allAt: '1') equals: #('foo').
	collection at: '1' put: 'bar'.
	self assert: (collection allAt: '1') equals: #('bar').
	self assertAssociations: (Array  with: '1' -> 'bar')
]
