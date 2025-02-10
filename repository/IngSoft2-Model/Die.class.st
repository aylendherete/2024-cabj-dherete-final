Class {
	#name : 'Die',
	#superclass : 'Object',
	#instVars : [
		'faces'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Die class >> of: anAmountFaces [ 
	anAmountFaces <3 ifTrue: [ Error signal: 'A die less than three faces doesnt exist'].
	^ (self new) initializeOf: anAmountFaces .
]

{ #category : 'set and get' }
Die >> amountOfFaces [

	^ faces
]

{ #category : 'initialization' }
Die >> initializeOf: anAmountOfFaces [

	faces := anAmountOfFaces
]

{ #category : 'action' }
Die >> throw [

	^ faces atRandom
]
