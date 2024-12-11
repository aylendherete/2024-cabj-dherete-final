Class {
	#name : 'GameCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'aLoadedDie',
		'aWormholeCreator',
		'aBoardCreator',
		'collectionOfCells',
		'gameDeck'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameCardTest >> setUp [

	super setUp.
	aLoadedDie := LoadedDie of: #( 6 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	30 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := LoadedEffectManager manage: (OrderedCollection
			             with: AccelerationCard
			             with: AllyCard
			             with: OverloadCard
			             with: RedoCard
			             with: RepeatCard
			             with: CancellationCard)
]

{ #category : 'running' }
GameCardTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'acceleration' }
GameCardTest >> test03WhenOneAccelerationCardIsActiveThenSpaceshipMovesOneMoreThanThrowResult [

	| result aGame |
	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.

	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 8.


	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'overload' }
GameCardTest >> test05SpaceshipOnePlaysOverloadToSpaceshipTwoThenTwoMovesLessTwo [

	| result aGame |
	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame moveSpaceship.

	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 7.
	result at: 2 put: 5.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'ally' }
GameCardTest >> test06GameActivatesAllyCardThenSpaceshipOneCanUseFuelFromSpaceshipTwo [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 1 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 22.
	result at: 2 put: 4.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'ally' }
GameCardTest >> test07BothAllysRunOutOfFuelThenBothLooseTwoTurns [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'cancellation' }
GameCardTest >> test10SpaceshipThreeRemovesOverloadCardThenItMovesWithoutEffect [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 7 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame moveSpaceship.
	aGame usePermanentCard: OverloadCard toDoEffectFor: 3.
	aGame moveSpaceship.

	aGame
		spaceshipId: 2
		useInstantCard:
		CancellationCard
		toDoEffectFor: (OverloadCard toDoEffectFor: 3).
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 6.
	result at: 3 put: 8.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'cancellation' }
GameCardTest >> test11CancelAllyCardThenBothSpaceshipsUseOnlyTheirFuelTank [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 1 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame moveSpaceship.
	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: (AllyCard toDoEffectFor: 2).
	aGame moveSpaceship.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 3.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'instant card' }
GameCardTest >> test12InstancCardPlayedOnAnoterSpaceshipsTurnThenInstantCardCanDoTheEffect [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: (OverloadCard toDoEffectFor: 2).
	aGame moveSpaceship.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 8.


	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'cancellation' }
GameCardTest >> test13AccelerationCardPlayedAndCancelledThenSpaceshipMovesWithoutEffect [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame
		spaceshipId: 2
		useInstantCard:
		CancellationCard
		toDoEffectFor: AccelerationCard new.
	aGame moveSpaceship.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 8.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test14TwoRedoCardsPlayedAfterAccelerationThenSpaceshipMovesThreeCellsMore [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame spaceshipId: 2 useInstantCard: RedoCard toDoEffectFor: nil.
	aGame spaceshipId: 1 useInstantCard: RedoCard toDoEffectFor: 2.

	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 11.
	result at: 2 put: 1.
	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test15RedoCardPlayedAfterOverloadThenSpaceshipsAffectedHaveLessMovement [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 7 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame spaceshipId: 1 useInstantCard: RedoCard toDoEffectFor: 3.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 6.
	result at: 3 put: 6.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test16RedoCardPlayedAfterAllyThenSpaceshipsThreeAndFourShareFuelBeacuseOfIt [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 7 7 7 1 ).
	aGame := Game
		         numberOfSpaceships: 4
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame spaceshipId: 3 useInstantCard: RedoCard toDoEffectFor: 4.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.
	result at: 3 put: 15.
	result at: 4 put: 4.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test17TwoAccelerationCardsPlayThenACancellationAndARedoSoNoAccelerationEffectOccurs [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 7 7 1 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame spaceshipId: 2 useInstantCard: RedoCard toDoEffectFor: nil.
	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: AccelerationCard new.
	aGame
		spaceshipId: 1
		useInstantCard: RedoCard
		toDoEffectFor: AccelerationCard new.

	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test18SpaceshipOneEntersBlackHoleAndSpaceshipTwoRepeatsEffectThenSpaceshipOneIsInPositionOne [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 5 ).
	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 6 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test19ReapeatCardRepeatsACellThenNothingChanges [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 9 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 10.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test20RepeatCardRepeatsMoonWalkThenSpaceshipOneMovesBackwards [

	| aGame result |
	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 7 put: (MoonWalkCell withValueToMove: 4).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 2.

	result := Dictionary new.
	result at: 1 put: 3.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test21RepeatCardRepeatsAtomicBombThenEverySpaceshipIsOnCellOne [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 4 ).
	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 5 put: AtomicBombCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 1.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test22RepeatCardRepeatsHyperJumpThenBothSpaceshipsMoveSameParsecs [

	| aGame result aConversor values |
	aConversor := Conversor totalCells: 4 convertionValue: 8.
	values := OrderedCollection
		          with: (Parsecs ofValue: 10)
		          with: (LightYear ofValue: 24)
		          with: (Parsecs ofValue: 6)
		          with: (Parsecs ofValue: 4).

	aLoadedDie := LoadedDie of: #( 8 ).

	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells
		at: 9
		put: (HyperJumpCell withConversor: aConversor andValues: values).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.

	result := Dictionary new.
	result at: 1 put: 4.
	result at: 2 put: 5.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test23RepeatCardRepeatsCardDispenserThenSpaceshipTwoCanPlayTwoAccelerationCards [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 3 3 3 80 ).

	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 4 put: CardDispenserCell new.

	gameDeck := LoadedEffectManager manage:
		            (OrderedCollection
			             with: AccelerationCard
			             with: RepeatCard).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 10.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test24RepeatCardRepeatsWormholeThenSpaceshipOneGoesToWormhole [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 9 1 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 3.
	result at: 2 put: 3.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test25RedoCardPlayedAfterRepeatCardThenCellEffectRepeatsTwice [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 9 5 10).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.
	30 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 6 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame spaceshipId: 2 useInstantCard: RepeatCard toDoEffectFor: 1.
	aGame spaceshipId: 2 useInstantCard: RedoCard toDoEffectFor: 1.

	result := Dictionary new.
	result at: 1 put: 2.
	result at: 2 put: 2.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test26RepeatCardRepeatsHyperGravityThenSpaceshipMovesWithoutImpediment [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 1 1 ).
	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 3.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test27WhenACardThatIsNotInHandTriesToActivateThenDoesNotDoTheEffectOfIt [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 14 12 12 1 ).
	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame
		spaceshipId: 1
		useInstantCard: CancellationCard
		toDoEffectFor: AccelerationCard new.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 16.
	result at: 2 put: 13.
	result at: 3 put: 13.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'cancellation' }
GameCardTest >> test28CancellationCardCancelsOnlyTheCardThatIsExactlyTheSameAsTheOneItWantsToCancel [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 7 7 7 7 7 7 7 7 7 20 ).

	aGame := Game
		         numberOfSpaceships: 3
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: OverloadCard toDoEffectFor: 2.
	aGame moveSpaceship.
	aGame usePermanentCard: OverloadCard toDoEffectFor: 3.
	aGame moveSpaceship.
	aGame moveSpaceship.

	aGame moveSpaceship.
	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: (OverloadCard toDoEffectFor: 2).
	aGame moveSpaceship.
	aGame moveSpaceship.
	result := Dictionary new.
	result at: 1 put: 15.
	result at: 2 put: 13.
	result at: 3 put: 11.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test29RepeatHyperGravityForSpaceshipTwoThenItCannotMoveBeacuseOfIt [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 2 ).

	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells
		at: 8
		put:
		(HyperGravityCell withValueToMove: aLoadedDie amountOfFaces // 2).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 1.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'repeat' }
GameCardTest >> test30RepeatHyperGravityForSpaceshipTwoThenItCanMoveBeacuseOfThrowGreaterThenValue [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 6 ).

	collectionOfCells := OrderedCollection new.
	10 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells
		at: 8
		put:
		(HyperGravityCell withValueToMove: aLoadedDie amountOfFaces // 2).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 8.
	result at: 2 put: 7.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'ally' }
GameCardTest >> test31SpaceshipThreeTriesToAllyWithTwoThenItThrowAnErrorBecauseTwoAlreadyHasAlly [

	self
		should: [
			| aGame |
			aLoadedDie := LoadedDie of: #( 1 1 7 1 ).
			aGame := Game
				         numberOfSpaceships: 4
				         with: aBoardCreator
				         playWith: aLoadedDie
				         andGameDeck: gameDeck.

			aGame usePermanentCard: AllyCard toDoEffectFor: 2.
			aGame moveSpaceship.
			aGame moveSpaceship.
			aGame usePermanentCard: AllyCard toDoEffectFor: 2 ]
		raise: Error
		withMessage: 'Spaceship 2 already has an ally.'
]

{ #category : 'ally' }
GameCardTest >> test32SpaceshipsTwoChangesCapacityAndOneAnTwoAreAllysThenAmountOfTotalFuelChanges [

	| resultOne aGame resultTwo |
	aLoadedDie := LoadedDie of: #( 6 7 6 14 2 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame moveSpaceship. "1 -> 7"
	aGame moveSpaceship. "2 -> 8"
	aGame moveSpaceship. "1 -> 13"
	aGame reloadSpaceship.
	aGame moveSpaceship. "1 -> 27"
	aGame moveSpaceship. "2 -> 10"

	resultOne := Dictionary new.
	resultOne at: 1 put: 1.
	resultOne at: 2 put: 1.

	resultTwo := Dictionary new.
	resultTwo at: 1 put: 27.
	resultTwo at: 2 put: 10.

	self assert: (aGame spaceships cellsOfSpaceships = resultOne or:
			 aGame spaceships cellsOfSpaceships = resultTwo)
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test33GamePlaysWithDeckWithProbabilisticDistributionThenSpaceshipCardHandAlwaysInitializedWithTwoCards [

	| result aGame |
	gameDeck := EffectManager
		            manage: (OrderedCollection with: AccelerationCard)
		            withProbabilitiesDistribution: #( 100 ).
	aLoadedDie := LoadedDie of: #( 4 ).
	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame usePermanentCard: AccelerationCard toDoEffectFor: nil.
	aGame moveSpaceship.

	result := Dictionary new.
	result at: 1 put: 7.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test34WhenASpaceshipFallsInABlackHoleCellAndPlaysTheReverseCardThenItMovesFourCellsForward [
	| result aGame  |


	aWormholeCreator := WormholeCreator withBeginning: 8 andEnd: 9.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 2 put: BlackHoleCell new.
	collectionOfCells at: 6 put: BlackHoleCell new.
	

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.


	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).
		
	aLoadedDie := LoadedDie of: #( 5 20 ).
	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
		
	aGame moveSpaceship.

	aGame usePermanentCard: ReverseCard toDoEffectFor: 1.


	result := Dictionary new.
	result at: 1 put: 6.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]
