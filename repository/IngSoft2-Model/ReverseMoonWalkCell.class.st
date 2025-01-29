Class {
	#name : 'ReverseMoonWalkCell',
	#superclass : 'Cell',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ReverseMoonWalkCell class >> withValueToMove: aValue [

	^ self new initializeWithValueToMove: aValue
]

{ #category : 'action' }
ReverseMoonWalkCell >> applyEffectTo: aSpaceship on: aGame [

	aGame moveAllTheSpaceshipsExcept: aSpaceship withValueToMove: value .
]

{ #category : 'initialization' }
ReverseMoonWalkCell >> initializeWithValueToMove: aValue [

	value := aValue.
]

{ #category : 'as yet unclassified' }
ReverseMoonWalkCell >> reverseCell [

	^ MoonWalkCell withValueToMove: value
]
