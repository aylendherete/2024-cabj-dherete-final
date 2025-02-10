Class {
	#name : 'UserInterface',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'aGame'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
UserInterface class >> numberOfSpaceships: anAmount with: aBoardCreator playWith: aCollectionOfDice andGameDeck: anEffectManager [

	^ self new
		  initializeNumberOfSpaceships: anAmount
		  with: aBoardCreator
		  playWith: aCollectionOfDice
		  andGameDeck: anEffectManager
]

{ #category : 'results' }
UserInterface >> finalLapsOfSpaceships [

	^ spaceships lapsOfSpaceships
]

{ #category : 'results' }
UserInterface >> finalPositionOfSpaceships [

	^ spaceships cellsOfSpaceships
]

{ #category : 'results' }
UserInterface >> finalResultsOfSpaceships [

	^ spaceships positionsOfSpaceships
]

{ #category : 'initialization' }
UserInterface >> initializeNumberOfSpaceships: anAmount with: aBoardCreator playWith: aCollectionOfDice andGameDeck: anEffectManager [

	aGame := Game
		         numberOfSpaceships: anAmount
		         with: aBoardCreator
		         playWith: aCollectionOfDice
		         andGameDeck: anEffectManager.

	spaceships := aGame spaceships
]

{ #category : 'action' }
UserInterface >> moveSpaceship [

	^aGame moveSpaceship
]

{ #category : 'results' }
UserInterface >> rankingOfSpaceships [

	| sortedSpaceships numberOfSpaceshipsToTake |
	sortedSpaceships := spaceships ranking.
	numberOfSpaceshipsToTake := sortedSpaceships size min: 3.

	^ sortedSpaceships first: numberOfSpaceshipsToTake
]

{ #category : 'action' }
UserInterface >> reloadSpaceship [

	aGame reloadSpaceship
]

{ #category : 'activation' }
UserInterface >> spaceshipId: anId useInstantCard: aCard toDoEffectFor: anObject [

	aGame spaceshipId: anId useInstantCard: aCard toDoEffectFor: anObject
]

{ #category : 'activation' }
UserInterface >> usePermanentCard: aCard toDoEffectFor: anId [

	aGame usePermanentCard: aCard toDoEffectFor: anId
]

{ #category : 'results' }
UserInterface >> winner [

	^ aGame winner
]
