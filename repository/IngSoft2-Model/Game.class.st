Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'turnManager',
		'finishLine',
		'board',
		'spaceshipsCardHands',
		'aActiveDeck',
		'dice',
		'spaceships',
		'cellToEnter',
		'spaceshipsWithHyperGravity',
		'anAllyTankManager',
		'aHyperGravityManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> numberOfSpaceships: anAmount with: aBoardCreator playWith: aCollectionOfDice andGameDeck: anEffectManager [

	^ self new
		  initializeNumberOfSpaceships: anAmount
		  with: aBoardCreator
		  playWith: aCollectionOfDice
		  andGameDeck: anEffectManager
]

{ #category : 'activation' }
Game >> activateCard: aCard [

	aActiveDeck activate: aCard
]

{ #category : 'action' }
Game >> activateReverseEffectOn: aCellAffected [ 
	| reverseCell |
	reverseCell := aCellAffected reverseCell.
	board at: (board indexOf: aCellAffected) put: reverseCell.
	^ reverseCell
]

{ #category : 'action' }
Game >> ally: spaceshipIdOne with: spaceshipIdTwo ofCard: anAllyCard [ 
	| spaceshipOne spaceshipTwo|
	
	self activateCard: anAllyCard.
	
	spaceshipOne := spaceships detectSpaceshipWithId: spaceshipIdOne.
	
	spaceshipTwo := spaceships detectSpaceshipWithId: spaceshipIdTwo.
	
	anAllyTankManager ally: spaceshipOne with: spaceshipTwo
]

{ #category : 'action' }
Game >> applyHyperGravityOn: aSpaceship withValue: value [
	
	aHyperGravityManager handleHyperGravityOn: aSpaceship withValue: value
	
	
]

{ #category : 'action' }
Game >> applyReverseHyperGravityOn:aSpaceship withValue:value [ 

	aHyperGravityManager
		handleReverseHyperGravityOn: aSpaceship
		withValue: value
]

{ #category : 'action' }
Game >> checkAndHandleFuelDepletion: aSpaceship [

	| spaceshipsWithoutFuel |
	spaceshipsWithoutFuel := anAllyTankManager spaceshipsWithEmptyFuelTank:
		              aSpaceship.
	spaceshipsWithoutFuel do: [ :spaceship |
		turnManager lostTurns: 2 by: spaceship id.
		spaceship resetToOne.
		spaceship loadFuel ]
]

{ #category : 'checking' }
Game >> checkMoveIsPossible: throwResult for: aSpaceship [

	| positionOfSpaceship aNumberOfMovements |
	aNumberOfMovements := throwResult.
	positionOfSpaceship := aSpaceship position.


	aNumberOfMovements:= aHyperGravityManager handleMovementOf:aSpaceship with:throwResult and: aNumberOfMovements .
	

	aNumberOfMovements := positionOfSpaceship
		                      adjustMovementFor: aNumberOfMovements
		                      withLimits: finishLine.

	^ aNumberOfMovements
]

{ #category : 'action' }
Game >> doReverseEffectWormholeOf: aSpaceship with: aNumberOfMovements [
	aNumberOfMovements < 0
				ifTrue: [
					self move: aSpaceship a: aNumberOfMovements + board size ]
				ifFalse: [
					self move: aSpaceship a: aNumberOfMovements - board size]
]

{ #category : 'as yet unclassified' }
Game >> doTimeMachineEffectToSpacehip: anSpaceshipid [

	| spaceshipDetected |
	spaceshipDetected := spaceships detectSpaceshipWithId: anSpaceshipid.
	anAllyTankManager restoreFuelToSecondLastForAlly: spaceshipDetected.
	spaceshipDetected restoreFuelToSecondLast.
]

{ #category : 'action' }
Game >> giveOneCardTo: aSpaceship [

	(spaceshipsCardHands at: aSpaceship id) gainACard
]

{ #category : 'initialization' }
Game >> initializeNumberOfSpaceships: anAmount with: aBoardCreator playWith: aCollectionOfDice andGameDeck: anEffectManager [

	aActiveDeck := ActiveDeck startGame.

	finishLine := Position
		              startGameWithCell: aBoardCreator cells
		              andLap: aBoardCreator laps.

	dice := aCollectionOfDice.

	spaceships := CollectionOfSpaceships
		              numberOfSpaceships: anAmount
		              withAmountOfFuel: dice amountOfFaces * 2.

	anAllyTankManager := AllyTankManager manage: spaceships.

	spaceshipsCardHands := (1 to: anAmount) collect: [ :index |
		                       SpaceshipCardHand startGameWith:
			                       anEffectManager ].

	turnManager := TurnManager manage: spaceships.

	aHyperGravityManager := HyperGravityManager manage.

	board := aBoardCreator createBoard
]

{ #category : 'accessing' }
Game >> lastCardPlayed [

	^ aActiveDeck lastCardPlayed
]

{ #category : 'accessing' }
Game >> lastCellEffect [

	^ cellToEnter
]

{ #category : 'action' }
Game >> move: spaceship a: numberOfMovements [

	| positionOfSpaceship aNumberOfMovements |
	aNumberOfMovements := self
		                      checkMoveIsPossible: numberOfMovements
		                      for: spaceship.

	positionOfSpaceship := spaceship position.

	anAllyTankManager
		spaceship: spaceship
		wantsToUse: aNumberOfMovements.

	spaceship move: aNumberOfMovements.

	positionOfSpaceship adjustPositionWith: finishLine.

	self checkAndHandleFuelDepletion: spaceship
]

{ #category : 'action' }
Game >> moveAllTheSpaceshipsExcept: aSpaceship withValueToMove: aNumberOfMovements [

	spaceships
		each: [ :spaceship | self move: spaceship a: aNumberOfMovements ]
		but: aSpaceship
]

{ #category : 'action' }
Game >> moveSpaceship [

	| positionOfSpaceship throwResult currentSpaceship |
	throwResult := self throwDiceAndCheckEffects.
	currentSpaceship := turnManager spaceshipPlaying.
	positionOfSpaceship := currentSpaceship position.

	self move: currentSpaceship a: throwResult.

	cellToEnter := board at: positionOfSpaceship cell.
	cellToEnter applyEffectTo: currentSpaceship on: self.

	positionOfSpaceship = finishLine ifTrue: [
		dice := GameOver new.
		^ self spaceships positionsOfSpaceships ].

	turnManager nextTurn
]

{ #category : 'action' }
Game >> reloadSpaceship [

	| currentSpaceship |
	currentSpaceship := turnManager spaceshipPlaying.
	currentSpaceship loadFuel.
	currentSpaceship := turnManager nextTurn
]

{ #category : 'removing' }
Game >> removeTheCard: aCardToCancel andSaveTheLastInstantCardPlayed: aCancellationCard [

	aActiveDeck activate: aCancellationCard .
	aActiveDeck removeACard: aCardToCancel
]

{ #category : 'initialization' }
Game >> resetSpaceshipsToCellOne [

	spaceships each: [ :spaceship | spaceship resetToOne ]
]

{ #category : 'activation' }
Game >> spaceshipId: anId useInstantCard: aCard toDoEffectFor: anObject [

	| spaceshipCardHand cardInitialized |
	cardInitialized := aCard toDoEffectFor: anObject.
	spaceshipCardHand := spaceshipsCardHands at: anId.
	(spaceshipCardHand use: aCard )ifTrue:[
	cardInitialized activateEffectOn: self forSpaceship: anId]
]

{ #category : 'accessing' }
Game >> spaceships [

	^ spaceships 
]

{ #category : 'accessing' }
Game >> stopAlly: aSpaceshipId [

	| spaceshipOne |
	spaceshipOne := spaceships detectSpaceshipWithId: aSpaceshipId.
	anAllyTankManager stopAlly: spaceshipOne
]

{ #category : 'action' }
Game >> takeOutOneRandomCardTo:aSpaceship [

	(spaceshipsCardHands at: aSpaceship id) removeACard
]

{ #category : 'action' }
Game >> throwDiceAndCheckEffects [

	| throwResult maxThrow randomValue currentSpaceship |
	randomValue := Random new next.
	throwResult := dice throw.
	currentSpaceship := turnManager spaceshipPlaying.

	throwResult := aActiveDeck
		               applyEffectOn: throwResult
		               withCurrentSpaceship: currentSpaceship id.

	maxThrow := dice amountOfFaces.
	throwResult = maxThrow ifTrue: [
		randomValue < 0.8
			ifTrue: [ currentSpaceship changeCapacity: 1 ]
			ifFalse: [ currentSpaceship objectFuelTank consumeFuelAsReward ] ].
	^ throwResult
]

{ #category : 'activation' }
Game >> usePermanentCard: aCard toDoEffectFor: anId [

	| currentSpaceshipCardHand cardInitialized currentSpaceship |
	currentSpaceship := turnManager spaceshipPlaying.
	cardInitialized := aCard toDoEffectFor: anId.
	currentSpaceshipCardHand := spaceshipsCardHands at:
		                            currentSpaceship id.
	(currentSpaceshipCardHand use: aCard) ifFalse: [ ^ self ].
	cardInitialized
		activateEffectOn: self
		forSpaceship: currentSpaceship id
]

{ #category : 'results' }
Game >> winner [

	^ (spaceships ranking at: 1) id
]
