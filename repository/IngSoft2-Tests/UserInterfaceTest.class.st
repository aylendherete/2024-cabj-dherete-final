Class {
	#name : 'UserInterfaceTest',
	#superclass : 'TestCase',
	#instVars : [
		'aLoadedDie',
		'aWormholeCreator',
		'collectionOfCells',
		'aBoardCreator',
		'gameDeck',
		'aConversor',
		'values'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
UserInterfaceTest >> setUp [

	super setUp.
	aLoadedDie := LoadedDie of: #( 6 ).

	aConversor := Conversor totalCells: 4 convertionValue: 8.
	values := OrderedCollection
		          with: (Parsecs ofValue: 10)
		          with: (LightYear ofValue: 24)
		          with: (Parsecs ofValue: 6)
		          with: (Parsecs ofValue: 4).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 5 put: AtomicBombCell new.
	collectionOfCells at: 6 put: BlackHoleCell new.
	collectionOfCells at: 4 put: CardDispenserCell new.
	collectionOfCells
		at: 8
		put:
		(HyperGravityCell withValueToMove: aLoadedDie amountOfFaces // 2).
	collectionOfCells
		at: 9
		put: (HyperJumpCell withConversor: aConversor andValues: values).
	collectionOfCells at: 7 put: (MoonWalkCell withValueToMove: 4).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
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

{ #category : 'tests' }
UserInterfaceTest >> test01UserInterfaceMovesSpaceshipThenGetsFinalPositions [

	| result aUserInterface |
	aLoadedDie := LoadedDie of: #( 9 8 4 ).

	aUserInterface := UserInterface
		                  numberOfSpaceships: 3
		                  with: aBoardCreator
		                  playWith: aLoadedDie
		                  andGameDeck: gameDeck.

	aUserInterface moveSpaceship.
	aUserInterface moveSpaceship.
	aUserInterface moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.
	result at: 3 put: 1.

	self assert: aUserInterface finalPositionOfSpaceships equals: result
]

{ #category : 'tests' }
UserInterfaceTest >> test02UserInterfaceUsesBothPermanentAndInstantCardsThenGamePlaysNormally [

	| aUserInterFace result |
	aLoadedDie := LoadedDie of: #( 9 9 9 ).

	gameDeck := LoadedEffectManager manage: (OrderedCollection
			             with: AccelerationCard
			             with: AllyCard
			             with: OverloadCard
			             with: RedoCard
			             with: RepeatCard
			             with: CancellationCard).

	collectionOfCells := OrderedCollection new.

	10 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aUserInterFace := UserInterface
		                  numberOfSpaceships: 3
		                  with: aBoardCreator
		                  playWith: aLoadedDie
		                  andGameDeck: gameDeck.

	aUserInterFace usePermanentCard: OverloadCard toDoEffectFor: 2.
	aUserInterFace
		spaceshipId: 1
		useInstantCard: RedoCard
		toDoEffectFor: 3.
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 10.
	result at: 2 put: 8.
	result at: 3 put: 8.

	self assert: aUserInterFace finalPositionOfSpaceships equals: result
]

{ #category : 'tests' }
UserInterfaceTest >> test03UserInterfaceReloadFuelThenGameFunctionsNormally [

	| aUserInterFace result |
	aLoadedDie := LoadedDie of: #( 3 ).

	aUserInterFace := UserInterface
		                  numberOfSpaceships: 1
		                  with: aBoardCreator
		                  playWith: aLoadedDie
		                  andGameDeck: gameDeck.

	aUserInterFace moveSpaceship.
	aUserInterFace reloadSpaceship.
	aUserInterFace moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 7.
	self assert: aUserInterFace finalPositionOfSpaceships equals: result
]

{ #category : 'tests' }
UserInterfaceTest >> test04UserInterfacesPlaysThenRankingOfSpaceshipsShowTheRanking [

	| aUserInterFace rankingOfSpaceships idRanking |
	aLoadedDie := LoadedDie of: #( 12 15 5 1 ).

	collectionOfCells := OrderedCollection new.

	10 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aUserInterFace := UserInterface
		                  numberOfSpaceships: 4
		                  with: aBoardCreator
		                  playWith: aLoadedDie
		                  andGameDeck: gameDeck.

	rankingOfSpaceships := OrderedCollection with: 2 with: 1 with: 3.
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.

	idRanking := aUserInterFace rankingOfSpaceships collect: [ :spaceship |
		             spaceship id ].

	self assert: idRanking equals: rankingOfSpaceships
]

{ #category : 'tests' }
UserInterfaceTest >> test05UserInterfacePlaysThenGetsWinnerId [

	| aUserInterFace |
	aUserInterFace := UserInterface
		                  numberOfSpaceships: 1
		                  with: aBoardCreator
		                  playWith: aLoadedDie
		                  andGameDeck: gameDeck.
	aUserInterFace moveSpaceship.

	self assert: aUserInterFace winner equals: 1
]

{ #category : 'tests' }
UserInterfaceTest >> test06UserInterfacePlaysThenGetsFinalLapsOfSpaceships [

	| aUserInterFace resultOfLaps |
	aLoadedDie := LoadedDie of: #( 6 3 12 6 1 6 ).

	collectionOfCells := OrderedCollection new.

	10 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aUserInterFace := UserInterface
		                  numberOfSpaceships: 2
		                  with: aBoardCreator
		                  playWith: aLoadedDie
		                  andGameDeck: gameDeck.

	resultOfLaps := Dictionary new.
	resultOfLaps at: 1 put: 2.
	resultOfLaps at: 2 put: 1.
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.

	self
		assert: aUserInterFace finalLapsOfSpaceships
		equals: resultOfLaps
]

{ #category : 'tests' }
UserInterfaceTest >> test07userInterfacePlaysThenGetsFinalResultsOfSpaceships [

	| aUserInterFace resultOfGame |
	aLoadedDie := LoadedDie of: #( 15 5 4 ).

	collectionOfCells := OrderedCollection new.

	10 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aUserInterFace := UserInterface
		                  numberOfSpaceships: 2
		                  with: aBoardCreator
		                  playWith: aLoadedDie
		                  andGameDeck: gameDeck.

	resultOfGame := Dictionary new.
	resultOfGame at: 1 put: (Position startGameWithCell: 10 andLap: 2).
	resultOfGame at: 2 put: (Position startGameWithCell: 6 andLap: 1).
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.
	aUserInterFace moveSpaceship.

	self
		assert: aUserInterFace finalResultsOfSpaceships
		equals: resultOfGame
]
