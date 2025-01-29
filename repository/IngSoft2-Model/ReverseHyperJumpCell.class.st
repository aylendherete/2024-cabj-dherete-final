Class {
	#name : 'ReverseHyperJumpCell',
	#superclass : 'Cell',
	#instVars : [
		'collectionOfValues',
		'currentValue',
		'conversor',
		'previousValue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ReverseHyperJumpCell class >> withConversor: aConversor andValues: aCollection [

	^ self new initializeWithConversor: aConversor andValues: aCollection
]

{ #category : 'action' }
ReverseHyperJumpCell >> applyEffectTo: aSpaceship on: aGame [

	| convertionOfNextValue |
	convertionOfNextValue := conversor convert: currentValue.
	previousValue := currentValue.
	self nextValue.
	aGame move: aSpaceship a: convertionOfNextValue negated.

]

{ #category : 'initialization' }
ReverseHyperJumpCell >> initializeWithConversor: aConversor andValues: aCollection [

	conversor := aConversor.
	collectionOfValues := aCollection.
	currentValue := collectionOfValues at: 1
]

{ #category : 'accessing' }
ReverseHyperJumpCell >> nextValue [

	| currentIndex nextIndex |
	currentIndex := collectionOfValues indexOf: currentValue.
	nextIndex := currentIndex + 1.
	nextIndex > collectionOfValues size ifTrue: [ nextIndex := 1 ].
	currentValue := collectionOfValues at: nextIndex
]

{ #category : 'as yet unclassified' }
ReverseHyperJumpCell >> reverseCell [

	^ HyperJumpCell
		  withConversor: conversor
		  andValues: collectionOfValues
]
