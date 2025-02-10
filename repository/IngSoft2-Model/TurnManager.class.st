Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'currentSpaceship',
		'turnsToSkip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TurnManager class >> manage: collectionOfSpaceships [ 
	^(self new) initializeManage: collectionOfSpaceships .
]

{ #category : 'action' }
TurnManager >> decrementTurnsOfSpaceship [

	turnsToSkip
		at: currentSpaceship id
		put: (turnsToSkip at: currentSpaceship id) - 1
]

{ #category : 'initialization' }
TurnManager >> initializeManage: collectionOfSpaceships [

	spaceships := collectionOfSpaceships collect: [ :spaceship |
		              spaceship ].

	currentSpaceship := spaceships at: 1.
	turnsToSkip := Dictionary new.
	collectionOfSpaceships each: [ :spaceship |
		turnsToSkip at: spaceship id put: 0 ]
]

{ #category : 'action' }
TurnManager >> lostTurns: anAmountOfTurns by: aSpaceshipId [

	(turnsToSkip at: aSpaceshipId) = 0 ifTrue: [
		turnsToSkip at: aSpaceshipId put: anAmountOfTurns ]
]

{ #category : 'auxiliar' }
TurnManager >> nextSpaceship [

	| currentIndex nextIndex |
	currentIndex := spaceships indexOf: currentSpaceship.
	nextIndex := currentIndex + 1.
	nextIndex > spaceships size ifTrue: [ nextIndex := 1 ].
	currentSpaceship := spaceships at: nextIndex
]

{ #category : 'action' }
TurnManager >> nextTurn [

	self nextSpaceship.
	[ (turnsToSkip at: currentSpaceship id) > 0 ] whileTrue: [
		self decrementTurnsOfSpaceship.
		self nextSpaceship ]
]

{ #category : 'accessing' }
TurnManager >> spaceshipPlaying [

	^ currentSpaceship
]
