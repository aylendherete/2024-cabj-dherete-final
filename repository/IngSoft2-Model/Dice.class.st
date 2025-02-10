Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'aCollectionOfDie'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Dice class >> of: aCollectionOfDice [
	^ (self new) initializeOf: aCollectionOfDice .
]

{ #category : 'set and get' }
Dice >> amountOfFaces [

	^ aCollectionOfDie sum: [ :die | die amountOfFaces ]
]

{ #category : 'initialization' }
Dice >> initializeOf: aCollectionOfDice [

	aCollectionOfDie := aCollectionOfDice
]

{ #category : 'action' }
Dice >> throw [

	^ aCollectionOfDie sum: [ :die | die throw ]
]
