Class {
	#name : 'MoonWalkCell',
	#superclass : 'Cell',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
MoonWalkCell class >> withValueToMove: aValue [

	^ self new initializeWithValueToMove: aValue
]

{ #category : 'action' }
MoonWalkCell >> applyEffectTo: aSpaceship on:aGame [

	aGame
		moveAllTheSpaceshipsExcept: aSpaceship
		withValueToMove: value negated.
]

{ #category : 'initialization' }
MoonWalkCell >> initializeWithValueToMove: aValue [

	value := aValue.
]
