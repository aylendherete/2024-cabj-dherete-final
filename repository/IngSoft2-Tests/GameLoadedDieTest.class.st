Class {
	#name : 'GameLoadedDieTest',
	#superclass : 'TestCase',
	#instVars : [
		'aLoadedDie',
		'aWormholeCreator',
		'collectionOfCells',
		'aBoardCreator',
		'gameDeck'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameLoadedDieTest >> setUp [

	super setUp.
	aLoadedDie := LoadedDie of: #( 6 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	15 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection
				             with: AccelerationCard new
				             with: AllyCard new
				             with: OverloadCard new
				             with: RedoCard new
				             with: RepeatCard new
				             with: CancellationCard new)
		            withProbabilitiesDistribution: #( 16 16 17 17 17 17 )
]

{ #category : 'asserting' }
GameLoadedDieTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'spaceship' }
GameLoadedDieTest >> test01GameMovesSpaceshipTwiceWithLoadedDieSequenceSixAndFiveThenReturnsTwelve [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 6 5 10 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 12.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'wormhole' }
GameLoadedDieTest >> test02GameMovesSpaceshipFallsOnWormholeThenPositionIsTheOtherSide [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 5 ).
	aWormholeCreator := WormholeCreator withBeginning: 6 andEnd: 8.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 8.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'game over' }
GameLoadedDieTest >> test03WhenSpaceshipReachesTheFinishLineThenIsGameLoadedDieOver [

	| aGame resultOfGame |
	aLoadedDie := LoadedDie of: #( 14 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.


	resultOfGame := Dictionary new.
	resultOfGame at: 1 put: (Position startGameWithCell: 15 andLap: 1).
	aGame moveSpaceship.

	self
		assert: aGame spaceships positionsOfSpaceships
		equals: resultOfGame
]

{ #category : 'spaceship' }
GameLoadedDieTest >> test04TwoSpaceshipsMovesThreeTimesThenTheFirstOnesPositionIsTwelve [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 6 6 5 10 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 12.
	result at: 2 put: 7.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'game over' }
GameLoadedDieTest >> test05FirstSpaceshipWinsThenSecondSpaceshipCannotPlay [

	| aGame |
	aLoadedDie := LoadedDie of: #( 13 2 1 3 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	self
		should: [ aGame moveSpaceship ]
		raise: Error
		withMessage: 'The Game is Over'
]

{ #category : 'game over' }
GameLoadedDieTest >> test06SpaceshipOneWinsThenResultOfGameShowsPositions [

	| aGame resultOfGame |
	aLoadedDie := LoadedDie of: #( 13 6 1 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	resultOfGame := Dictionary new.
	resultOfGame at: 1 put: (Position startGameWithCell: 15 andLap: 1).
	resultOfGame at: 2 put: (Position startGameWithCell: 7 andLap: 1).
	aGame moveSpaceship.
	aGame moveSpaceship.

	self assert: aGame moveSpaceship equals: resultOfGame
]

{ #category : 'position' }
GameLoadedDieTest >> test07WhenOneSapeshipWinsThenGetWinnerReturnsItsID [

	| aGame |
	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.

	self assert: aGame winner equals: 1
]

{ #category : 'position' }
GameLoadedDieTest >> test08WhenTwoSpaceshipsPlayAndTheSecondOneWinsThenGetWinnerReturnsTwo [

	| aGame |
	aLoadedDie := LoadedDie of: #( 3 6 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	aGame moveSpaceship.

	self assert: aGame winner equals: 2
]

{ #category : 'turn manager' }
GameLoadedDieTest >> test09WhenASpaceshipLosesATurnThenGoesToStartingPosition [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 1.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'fuelTests' }
GameLoadedDieTest >> test10WhenOneSpaceshipLosesFuelThenItMovesAfterTwoLostTurns [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 4.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'fuelTests' }
GameLoadedDieTest >> test11WhenASpaceshipDecidestToLooseATurnThenRechargesTheFuel [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame reloadSpaceship.

	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 7.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'fuelTests' }
GameLoadedDieTest >> test12WhenTheSpaceshipOneRunOutOfFuelThenTheSecondSpaceshipCanReloadTheFuelAndMove [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame reloadSpaceship.

	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 7.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'spaceship' }
GameLoadedDieTest >> test13SpaceshipMovesOneLapAroundTheBoardThenPositionIsInLapTwo [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 5 4 7 ).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame reloadSpaceship.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 2.

	self assert: aGame spaceships lapsOfSpaceships equals: result
]

{ #category : 'turn manager' }
GameLoadedDieTest >> test14WhenASpaceshipFallsInTheFirstCellThenDoesntLooseTwoTurns [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 5 4 6 ).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame reloadSpaceship.
	aGame moveSpaceship.
	aGame reloadSpaceship.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 6 andLap: 2).
	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'position' }
GameLoadedDieTest >> test16WhenTheGameFinishThenWeGetTeLapsOfTheSpaceships [

	| aGame resultOfLaps |
	aLoadedDie := LoadedDie of: #( 15 3 14 ).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	resultOfLaps := Dictionary new.
	resultOfLaps at: 1 put: 2.
	resultOfLaps at: 2 put: 1.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	self assert: aGame spaceships lapsOfSpaceships equals: resultOfLaps
]

{ #category : 'position' }
GameLoadedDieTest >> test17WhenTheGameEndsThenReturnsThePositionWithTheLapOfEachSpaceship [

	| aGame resultOfGame |
	aLoadedDie := LoadedDie of: #( 24 5 5 ).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	resultOfGame := Dictionary new.
	resultOfGame at: 1 put: (Position startGameWithCell: 15 andLap: 2).
	resultOfGame at: 2 put: (Position startGameWithCell: 6 andLap: 1).
	aGame moveSpaceship.
	aGame moveSpaceship.

	self assert: aGame moveSpaceship equals: resultOfGame
]

{ #category : 'position' }
GameLoadedDieTest >> test18WhenTheSpaceshipTwoIsInTheFirstPlaceTheSpaceshipOneIsInTheSecondPlaceAndTheSpaceshipIsInTheThirdPlaceThenTheRankingIsTwoOneThree [

	| aGame rankingOfSpaceships idRanking |
	aLoadedDie := LoadedDie of: #( 12 13 5 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	rankingOfSpaceships := OrderedCollection with: 2 with: 1 with: 3.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	idRanking := aGame spaceships ranking collect: [ :spaceship |
		             spaceship id ].

	self assert: idRanking equals: rankingOfSpaceships
]

{ #category : 'fuelTests' }
GameLoadedDieTest >> test20SpaceshipGainsCapacityOfFuelBeacuseOfThrowingMaxResultOfDice [

	| aGame spaceship |
	aLoadedDie := LoadedDie of: #( 4 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame reloadSpaceship.

	spaceship := aGame spaceships ranking at: 1.

	self assert: (spaceship amountOfFuel between: 8 and: 9)
]

{ #category : 'fuelTests' }
GameLoadedDieTest >> test21SpacshipOneLoadsFuelSpaceshipTwoLoosesTurnsThenOneMovesOnTwosTurn [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame reloadSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 7.
	result at: 2 put: 1.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'fuelTests' }
GameLoadedDieTest >> test22SpaceshipLoosesOneFuelBecauseOfMaxDiceThrow [

	| aGame spaceship |
	aLoadedDie := LoadedDie of: #( 4 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.

	spaceship := aGame spaceships ranking at: 1.

	self assert: (spaceship amountOfFuel between: 3 and: 4)
]
