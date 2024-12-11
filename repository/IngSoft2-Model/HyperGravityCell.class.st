Class {
	#name : 'HyperGravityCell',
	#superclass : 'Cell',
	#instVars : [
		'value'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperGravityCell class >> withValueToMove: aValue [

	^ self new initializeWithValueToMove: aValue
]

{ #category : 'action' }
HyperGravityCell >> applyEffectTo: aSpaceship on: aGame [

	aGame applyHyperGravityOn: aSpaceship withValue: value
]

{ #category : 'initialization' }
HyperGravityCell >> initializeWithValueToMove: aValue [

	value := aValue
]
