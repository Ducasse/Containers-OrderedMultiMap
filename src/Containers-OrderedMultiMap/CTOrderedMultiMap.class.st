"
I am an implementation of an ordered multi-map. I allow multiple values to be associated with the same key and maintain the order of addition. #at: and its derivatives all operate on the first matching key, while #allAt: returns the complete list of values for a key in the order they were added.

Here is a typical case.

[[[
(CTOrderedMultiMap new at: '1' add: 'foo'; at: '1' add: 'bar'; yourself) allAt: '1'
>>> #('foo' 'bar')
]]]
"
Class {
	#name : #CTOrderedMultiMap,
	#superclass : #CTSmallDictionary,
	#category : 'Containers-OrderedMultiMap'
}

{ #category : #accessing }
CTOrderedMultiMap >> add: anAssociation [
	self privateAt: anAssociation key put: anAssociation value.
	^ anAssociation
]

{ #category : #accessing }
CTOrderedMultiMap >> allAt: aKey [
	"Return all the values associated with aKey"
	"(CTOrderedMultiMap new at: '1' add: 'foo'; at: '1' add: 'bar'; yourself) allAt: '1' 
	>>> #('foo' 'bar')"
	^ Array streamContents: [ :stream |
		1 to: size do: [ :index |
			(keys at: index) = aKey
				ifTrue: [ stream nextPut: (values at: index) ] ] ]
]

{ #category : #accessing }
CTOrderedMultiMap >> allAt: aKey ifAbsent: absentBlock [
	| results |
	results := self allAt: aKey.
	^ results isEmpty
		ifTrue: [ absentBlock value ]
		ifFalse: [ results ]
]

{ #category : #accessing }
CTOrderedMultiMap >> at: aKey add: aValue [
	"Add aValue to the collection of values associated to aKey. Do not replace existing values with the same key."
	"(CTOrderedMultiMap new at: '1' add: 'foo'; at: '1' add: 'bar'; yourself) allAt: '1' >>> #('foo' 'bar')"
	
	^ self privateAt: aKey put: aValue
]

{ #category : #accessing }
CTOrderedMultiMap >> removeKey: aKey ifAbsent: aBlock [
	"Remove aKey from the receiver, evaluate aBlock if the element is missing."

	"This is inefficient and could be optimized."
	| removed |
	removed := Array streamContents: [ :stream |
		| index |
		[ (index := self findIndexFor: aKey) = 0 ] whileFalse: [
			stream nextPut: (self removeIndex: index) ] ].
	^ removed isEmpty
		ifTrue: [ aBlock value ]
		ifFalse: [ removed ]
]
