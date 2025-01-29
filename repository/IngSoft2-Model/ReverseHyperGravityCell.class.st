Class {
	#name : 'ReverseHyperGravityCell',
	#superclass : 'Cell',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ReverseHyperGravityCell class >> withValueToMove: aValue [

	^ self new initializeWithValueToMove: aValue
]

{ #category : 'action' }
ReverseHyperGravityCell >> applyEffectTo: aSpaceship on: aGame [

		aGame applyReverseHyperGravityOn: aSpaceship withValue: value .
]

{ #category : 'initialization' }
ReverseHyperGravityCell >> initializeWithValueToMove: aValue [

	value := aValue
]

{ #category : 'cells creation' }
ReverseHyperGravityCell >> reverseCell [

	^ HyperGravityCell withValueToMove: value
]
