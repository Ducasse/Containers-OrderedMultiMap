"
I am an implementation of a dictionary. Compared to other dictionaries I am very efficient for small sizes, speed- and space-wise. I also mantain the order in which elements are added when iterating. 

My implementation features some ideas from the RefactoringBrowser.
"
Class {
	#name : #CTSmallDictionary,
	#superclass : #Object,
	#instVars : [
		'size',
		'keys',
		'values'
	],
	#category : #'Containers-OrderedMultiMap'
}

{ #category : #'instance creation' }
CTSmallDictionary class >> new [
	^ self new: 3
]

{ #category : #'instance creation' }
CTSmallDictionary class >> new: anInteger [
	^ self basicNew initialize: anInteger; yourself
]

{ #category : #'instance creation' }
CTSmallDictionary class >> withAll: aDictionary [
	^ (self new: aDictionary size)
		addAll: aDictionary;
		yourself
]

{ #category : #accessing }
CTSmallDictionary >> add: anAssociation [
	self at: anAssociation key put: anAssociation value.
	^ anAssociation
]

{ #category : #accessing }
CTSmallDictionary >> addAll: aDictionary [
	aDictionary keysAndValuesDo: [ :key :value | self add: key -> value ].
	^ aDictionary
]

{ #category : #accessing }
CTSmallDictionary >> associations [
	"Answer a Collection containing the receiver's associations."

	| result |
	result := WriteStream on: (Array new: self size).
	self associationsDo: [ :assoc | result nextPut: assoc ].
	^ result contents
]

{ #category : #enumerating }
CTSmallDictionary >> associationsDo: aBlock [
	self keysAndValuesDo: [ :key :value | aBlock value: key -> value ]
]

{ #category : #accessing }
CTSmallDictionary >> at: aKey [
	"Answer the value associated with aKey. Raise an exception, if no such key is defined."

	^ self at: aKey ifAbsent: [ self errorKeyNotFound ]
]

{ #category : #accessing }
CTSmallDictionary >> at: aKey ifAbsent: aBlock [
	"Answer the value associated with aKey. Evaluate aBlock, if no such key is defined."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0
		ifFalse: [ values at: index ]
		ifTrue: [ aBlock value ]
]

{ #category : #accessing }
CTSmallDictionary >> at: aKey ifAbsentPut: aBlock [
	"Answer the value associated with aKey. Evaluate aBlock, if no such key is defined and store the return value."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0
		ifFalse: [ values at: index ]
		ifTrue: [ self privateAt: aKey put: aBlock value ]
]

{ #category : #accessing }
CTSmallDictionary >> at: aKey ifPresent: aBlock [
	"Lookup aKey in the receiver. If it is present, answer the value of evaluating the given block with the value associated with the key. Otherwise, answer nil."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0 ifFalse: [ aBlock value: (values at: index) ]
]

{ #category : #accessing }
CTSmallDictionary >> at: aKey put: aValue [
	"Set the value of aKey to be aValue."

	| index |
	index := self findIndexFor: aKey.
	^ index = 0
		ifFalse: [ values at: index put: aValue ]
		ifTrue: [ self privateAt: aKey put: aValue ]
]

{ #category : #enumerating }
CTSmallDictionary >> do: aBlock [
	1 to: size do: [ :index | aBlock value: (values at: index) ]
]

{ #category : #private }
CTSmallDictionary >> errorKeyNotFound [
	self error: 'Key not found'
]

{ #category : #private }
CTSmallDictionary >> findIndexFor: aKey [
	1 to: size do: [ :index |
		(keys at: index) = aKey
			ifTrue: [ ^ index ] ].
	^ 0
]

{ #category : #private }
CTSmallDictionary >> grow [
	| newKeys newValues |
	newKeys := Array new: 2 * size.
	newValues := Array new: 2 * size.
	1 to: size do: [ :index |
		newKeys at: index put: (keys at: index).
		newValues at: index put: (values at: index) ].
	keys := newKeys.
	values := newValues
]

{ #category : #testing }
CTSmallDictionary >> includesKey: aKey [
	"Answer whether the receiver has a key equal to aKey."

	^ (self findIndexFor: aKey) ~= 0
]

{ #category : #initialization }
CTSmallDictionary >> initialize: anInteger [
	self initialize.
	size := 0.
	keys := Array new: anInteger.
	values := Array new: anInteger
]

{ #category : #testing }
CTSmallDictionary >> isCollection [
	^ true
]

{ #category : #testing }
CTSmallDictionary >> isEmpty [
	^ size = 0
]

{ #category : #enumerating }
CTSmallDictionary >> keys [
	^ keys copyFrom: 1 to: size
]

{ #category : #enumerating }
CTSmallDictionary >> keysAndValuesDo: aBlock [
	1 to: size do: [ :index | aBlock value: (keys at: index) value: (values at: index) ]
]

{ #category : #enumerating }
CTSmallDictionary >> keysDo: aBlock [
	1 to: size do: [ :each | aBlock value: (keys at: each) ]
]

{ #category : #copying }
CTSmallDictionary >> postCopy [
	super postCopy.
	keys := keys copy.
	values := values copy
]

{ #category : #printing }
CTSmallDictionary >> printOn: aStream [
	super printOn: aStream.
	
	aStream nextPut: $(.
	self size <= 100
		ifTrue: [
			| first |
			first := true.
			self keysAndValuesDo: [ :key :value |
				"keysAndValuesDo:separatedBy: would be nice"
				first
					ifTrue: [ first := false ]
					ifFalse: [ aStream space ].
				aStream
					print: key;
					nextPutAll: '->';				
					print: value ] ]
		ifFalse: [
			aStream
				nextPutAll: 'size ';
				print: self size ].
	aStream nextPut: $)	
]

{ #category : #private }
CTSmallDictionary >> privateAt: aKey put: aValue [
	size = keys size ifTrue: [ self grow ].
	keys at: (size := size + 1) put: aKey.
	^ values at: size put: aValue
]

{ #category : #private }
CTSmallDictionary >> removeIndex: index [
	| value |
	value := values at: index.
	index to: size - 1 do:
			[ :i | 
			keys at: i put: (keys at: i + 1).
			values at: i put: (values at: i + 1) ].
	keys at: size put: nil.
	values at: size put: nil.
	size := size - 1.
	^ value
]

{ #category : #accessing }
CTSmallDictionary >> removeKey: aKey [
	"Remove aKey from the receiver, raise an exception if the element is missing."

	^ self removeKey: aKey ifAbsent: [ self errorKeyNotFound ]
]

{ #category : #accessing }
CTSmallDictionary >> removeKey: aKey ifAbsent: aBlock [
	"Remove aKey from the receiver, evaluate aBlock if the element is missing."

	| index |
	index := self findIndexFor: aKey.
	index = 0 ifTrue: [ ^ aBlock value ].
	^ self removeIndex: index
]

{ #category : #accessing }
CTSmallDictionary >> size [
	^ size
]

{ #category : #enumerating }
CTSmallDictionary >> values [
	^ values copyFrom: 1 to: size
]
