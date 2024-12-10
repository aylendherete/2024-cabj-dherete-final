Class {
	#name : 'LoadedDie',
	#superclass : 'Object',
	#instVars : [
		'faces',
		'index'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
LoadedDie class >> of: anAmountOfFaces [

	(anAmountOfFaces max < 3) ifTrue: [
		Error signal: 'A die less than three faces doesnt exist' ].
	^ self new initializeOf: anAmountOfFaces
]

{ #category : 'set and get' }
LoadedDie >> amountOfFaces [
	^faces max.
]

{ #category : 'initialization' }
LoadedDie >> initializeOf: anAmountOfFaces [

	faces := anAmountOfFaces.
	index := 1
]

{ #category : 'action' }
LoadedDie >> throw [

	| result |
	result := faces at: index.
	index := index + 1.
	index > faces size ifTrue: [ index := 1 ].
	^ result
]
