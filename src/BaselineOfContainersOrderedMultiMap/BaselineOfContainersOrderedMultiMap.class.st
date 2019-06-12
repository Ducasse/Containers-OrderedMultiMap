Class {
	#name : #BaselineOfContainersOrderedMultiMap,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersOrderedMultiMap
}

{ #category : #baselines }
BaselineOfContainersOrderedMultiMap >> baseline: spec [
	<baseline>

	spec for: #pharo do: [		
		spec 
			package: 'Containers-OrderedMultiMap';
			package: 'Containers-OrderedMultiMap-Tests' with: [ spec requires: #('Containers-OrderedMultiMap') ].
		]
]
