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

	| array |
	super setUp.
	aLoadedDie := LoadedDie of: #( 6 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	30 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 5
		                 withWormholeCreator: aWormholeCreator.
	array := OrderedCollection new.
	array addAll: {
			AccelerationCard.
			AllyCard.
			OverloadCard.
			RedoCard.
			RepeatCard.
			ReverseCard.
			CancellationCard.
			TimeMachineCard }.

	gameDeck := LoadedEffectManager manage: array
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
GameCardTest >> test34WhenTheSpaceshipOneFallsOnABlackHoleCellAndActivatesAReverseCardThenWhenTheSpaceshipTwoFallsInThatCellThenMovesFourStepsForward [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 5 5 10 30 ).

	aWormholeCreator := WormholeCreator withBeginning: 8 andEnd: 9.
	collectionOfCells := OrderedCollection new.

	10 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 2 put: BlackHoleCell new.
	collectionOfCells at: 6 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 2).
	aGame moveSpaceship.


	result := Dictionary new.
	result at: 1 put: 6.
	result at: 2 put: 2.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test35WhenAReverseCardIsActivatedInTheAtomicBombThenWhenASpaceshipFallsInThatCellThenDoesntResetTheCells [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 5 5 10 40 ).

	aWormholeCreator := WormholeCreator withBeginning: 8 andEnd: 9.
	collectionOfCells := OrderedCollection new.

	10 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 2 put: AtomicBombCell new.
	collectionOfCells at: 6 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at:2).
	aGame moveSpaceship.


	result := Dictionary new.
	result at: 1 put: 2.
	result at: 2 put: 2.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test36WhenAReverseCardIsActivatedOnAMoonWalkCellAndAfterTheSpaceshipOneFallsInThatOneThemTheOtherSpaceshipsMoveForwardInsteadBackwards [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 5 5 10 30 ).

	aWormholeCreator := WormholeCreator withBeginning: 8 andEnd: 9.
	collectionOfCells := OrderedCollection new.

	10 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 2 put: (MoonWalkCell withValueToMove: 5).
	collectionOfCells at: 6 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship.
	aGame moveSpaceship.
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at:2).
	aGame moveSpaceship.


	result := Dictionary new.
	result at: 1 put: 2.
	result at: 2 put: 7.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test37WhenAReverseCardIsActivatedOnACardDispenserCellThenItTakesOutOneCardAndTheSpaceshipCantDoTheEffectOfTheCardTaken [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 5 18 3 11 3 13 3 3 16 40 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 6 put: CardDispenserCell new.
	collectionOfCells at: 15 put: BlackHoleCell new.
	collectionOfCells at: 19 put: BlackHoleCell new.


	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 4
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 5"
	aGame moveSpaceship. "2 ->19->15"
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at: 6). "1"
	aGame moveSpaceship. "1->8"
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at:15). "2 en 15 reverse blackhole"
	aGame moveSpaceship. "2 ->6 lap 2 takes the other card"
	aGame moveSpaceship. "1 -> 12 "
	aGame moveSpaceship. "2 ->19 -> 15"
	aGame moveSpaceship. "1 ->15 ->19"
	aGame usePermanentCard: ReverseCard toDoEffectFor:( collectionOfCells at:15). "doesnt do the reverse of reverse because is not a card in hand"
	aGame moveSpaceship. "2 -> 18"
	aGame moveSpaceship. "1-> 15 that will go to 19 because is not activated the reverse of reverse"



	result := Dictionary new.
	result at: 1 put: 19.
	result at: 2 put: 18.

	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test38WhenASpaceshipFallsInTheEndOfTheWormholeAndActivatesTheReverseCardThenWhenFallsAgainGoesToTheBeginningOfTheWormholeOnTheNextLap [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 20 40 ).

	aWormholeCreator := WormholeCreator withBeginning: 4 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 4 ->10"
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at:10).
	aGame moveSpaceship. "1->10 lap 2"



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 4 andLap: 3).



	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test39WhenASpaceshipFallsInTheBeginningOfTheWormholeAndActivatesTheReverseCardThenWhenFallsAgainGoesToTheEndOfTheWormholeOnThePreviousLap [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 9 20 40 ).

	aWormholeCreator := WormholeCreator withBeginning: 4 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 10->4 "
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 4).
	aGame moveSpaceship. "1->4 lap 2->10 lap 1"



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 10 andLap: 1).



	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test40WhenASpaceshipFallsInTheBeginningOfTheWormholeAndActivatesTheReverseCardThenWhenFallsAgainGoesToTheStartBecauseSpaceshipWasInLapNumberOne [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 9 3 4 3 40 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 10->7 "
	aGame moveSpaceship. "2 ->4"
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at:7). "1 now 7 goes to 10 of the previous lap "
	aGame moveSpaceship. "1 ->11"
	aGame moveSpaceship. "1->7 lap 1->1 lap 1"



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 11 andLap: 1).
	result at: 2 put: (Position startGameWithCell: 1 andLap: 1).



	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test41WhenASpaceshipFallsInHyperGravityCellAndActivatesTheReverseCardAndThrowsAValueLessThanTheHyperGravityThenMovesBackward [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 10 10 3 40 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 8 put: (HyperGravityCell withValueToMove: 4).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 8 "
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at:8). "now the HyperGravity cell moves backwards the spaceship if its lower than the value"
	aGame moveSpaceship. "1 ->18"
	aGame moveSpaceship. "1 ->8 lap 2"
	aGame moveSpaceship. "lower than te value goes backwards (4 lap 2)"



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 5 andLap: 2).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test42WhenASpaceshipFallsInHyperGravityCellAndActivatesTheReverseCardAndThrowsAValueGreaterThanTheHyperGravityThenMovesForward [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 7 10 10 5 40 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 8 put: (HyperGravityCell withValueToMove: 4).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 8 "
	aGame usePermanentCard: ReverseCard toDoEffectFor:( collectionOfCells at:8) . "now the HyperGravity cell moves backwards the spaceship if its lower than the value"
	aGame moveSpaceship. "1 ->18"
	aGame moveSpaceship. "1 ->8 lap 2"
	aGame moveSpaceship. "greater than the value goes forward (13 lap 2)"



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 13 andLap: 2).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test43test42WhenASpaceshipFallsInHyperJumpCellAndActivatesTheReverseCardThenWhenFallsAgainMovesBackwardWithTheConvertedValue [

	| aGame result aConversor values |
	aLoadedDie := LoadedDie of: #( 12 20 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	aConversor := Conversor totalCells: 4 convertionValue: 8.
	values := OrderedCollection
		          with: (Parsecs ofValue: 10)
		          with: (LightYear ofValue: 24)
		          with: (Parsecs ofValue: 6)
		          with: (Parsecs ofValue: 4).

	collectionOfCells
		at: 9
		put: (HyperJumpCell withConversor: aConversor andValues: values).

	collectionOfCells at: 13 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 13...9 "
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor:( collectionOfCells at: 9) . "now the HyperJump cell moves backwards the spaceship with the parsec converter"
	aGame moveSpaceship. "1 ->9 lap 2-> 4 lap 2"


	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 4 andLap: 2).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test44FirstSpaceshipActivatesReverseCardOnHyperJumpCellAndBothSpaceshipsFallsOnHyperJumpCellThenFirstMovesLessParsecsThanSecond [

	| aGame result aConversor values |
	aLoadedDie := LoadedDie of: #( 12 4 20 4 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	aConversor := Conversor totalCells: 4 convertionValue: 8.
	values := OrderedCollection
		          with: (Parsecs ofValue: 10)
		          with: (LightYear ofValue: 24)
		          with: (Parsecs ofValue: 6)
		          with: (Parsecs ofValue: 4).

	collectionOfCells
		at: 9
		put: (HyperJumpCell withConversor: aConversor andValues: values).

	collectionOfCells at: 13 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 13...9 "
	aGame moveSpaceship. "2 -> 5"
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at:9). "now the HyperJump cell moves backwards the spaceship with the parsec converter"
	aGame moveSpaceship. "1 ->9 lap 2-> 4 lap 2"
	aGame moveSpaceship. "2->9   5 lap 1"


	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 4 andLap: 2).
	result at: 2 put: (Position startGameWithCell: 5 andLap: 1).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test45WhenASpaceshipCancellsTheReverseCardThenTheCellHasTheOriginalEffect [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 8 4 20 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 5 put: BlackHoleCell new.
	collectionOfCells at: 9 put: BlackHoleCell new.


	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 9...5 "
	aGame moveSpaceship. "2 -> 5...1"
	aGame usePermanentCard: ReverseCard toDoEffectFor: (collectionOfCells at:5).

	aGame
		spaceshipId: 2
		useInstantCard: CancellationCard
		toDoEffectFor: (ReverseCard toDoEffectFor: (collectionOfCells at:5)).
	aGame moveSpaceship. "1 ->5 lap 2-> 1 lap 2"


	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 1 andLap: 2).
	result at: 2 put: (Position startGameWithCell: 1 andLap: 1).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test46WhenAReverseCardIsCancelledThenItHasToCancellTheExactlyCardOfTheExactCell [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 8 12 20 16 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 5 put: BlackHoleCell new.
	collectionOfCells at: 9 put: BlackHoleCell new.
	collectionOfCells at: 13 put: BlackHoleCell new.

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 -> 9...5 "
	aGame moveSpaceship. "2 -> 13...9"
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: ( collectionOfCells at: 5 ).
	aGame moveSpaceship. "1 ->5 lap 2-> 9 lap 2"
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: ( collectionOfCells at: 9 ).
	aGame
		spaceshipId: 1
		useInstantCard: CancellationCard
		toDoEffectFor:
		(ReverseCard toDoEffectFor: ( collectionOfCells at: 5 )).
	aGame moveSpaceship. "2 -> 9 lap 1-> 5 lap 2 ... 1 lap 2"



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 9 andLap: 2).
	result at: 2 put: (Position startGameWithCell: 1 andLap: 2).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test47WhenAReverseCardIsPlayedOnABlackHoleCellAndThenAARedoCardIsPlayedOnTheSameCellThenTheCellHasTheOriginalEffect [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 8 4 20 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 5 put: BlackHoleCell new.
	collectionOfCells at: 9 put: BlackHoleCell new.


	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 5).
	aGame moveSpaceship. "1 -> 9...5 "
	aGame
		spaceshipId: 2
		useInstantCard: RedoCard
		toDoEffectFor: (collectionOfCells at: 5).
	aGame moveSpaceship. "2 -> 5...1"



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 5 andLap: 1).
	result at: 2 put: (Position startGameWithCell: 1 andLap: 1).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test48WhenAReverseCardIsPlayedOnABlackHoleCellAndTheSpaceshipTwoFallsInThatCellThenWhenTheRepeatCardIsPlayedTheSpaceshipMovesForward [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 8 4 20 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 5 put: BlackHoleCell new.
	collectionOfCells at: 9 put: BlackHoleCell new.


	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 5).
	aGame moveSpaceship. "1 -> 9...5 "
	aGame moveSpaceship. "2 -> 5...9"
	aGame spaceshipId: 1 useInstantCard: RepeatCard toDoEffectFor: 2.



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 5 andLap: 1).
	result at: 2 put: (Position startGameWithCell: 13 andLap: 1).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test49WhenAReverseCardIsPlayedOnARegularCellThenWhenASpaceshipFallsInThatCellDoesntDoAnEffect [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 4 4 20 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 5).
	aGame moveSpaceship. "1 -> 5...5 "




	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 5 andLap: 1).
	result at: 2 put: (Position startGameWithCell: 1 andLap: 1).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test50WhenAReverseIsActivatedTwiceOnTheSameAtomicBombCellThenDoesntAffects [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 4 4 20 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 7 andEnd: 10.
	collectionOfCells := OrderedCollection new.


	20 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 5 put: AtomicBombCell new.
	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 5).
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 5).
	aGame moveSpaceship. "1 -> 5...5 "




	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 5 andLap: 1).
	result at: 2 put: (Position startGameWithCell: 1 andLap: 1).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test51WhenAReverseIsActivatedTwiceOnTheSameCardDispenserCellThenDoesntAffects [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 4 5 20 50 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.


	20 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 5 put: CardDispenserCell new.
	collectionOfCells at: 10 put: BlackHoleCell new.
	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.
	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 5).
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 5).
	aGame moveSpaceship. "1 -> 5... and doesnt gain a card "
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 10).
	aGame moveSpaceship.




	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 14 andLap: 1).

	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test52WhenAReverseIsActivatedTwiceOnTheSameHyperGravityCellThenDoesntAffects [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 3 3 4 4 7 3 40).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.


	20 timesRepeat: [ collectionOfCells add: Cell new ].
	collectionOfCells at: 8 put: (HyperGravityCell withValueToMove: 6).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.
	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 8).
	aGame moveSpaceship. "1->4"
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 8).
	aGame moveSpaceship. "2->4"
	aGame moveSpaceship. "1 -> 8 "
	aGame moveSpaceship. "2-> 8"
	aGame moveSpaceship. "1 -> 15"
	aGame moveSpaceship. "2 -> 8"

	result := Dictionary new.
	result at: 1 put: 15.
	result at: 2 put: 8.

	self assert: aGame spaceships cellsOfSpaceships equals: result.
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test53WhenAReverseIsActivatedTwiceOnTheSameHyperJumpCellThenDoesntAffects [

	| aGame result aConversor values |
	aLoadedDie := LoadedDie of: #( 4 4 20 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	aConversor := Conversor totalCells: 4 convertionValue: 8.
	values := OrderedCollection
		          with: (Parsecs ofValue: 10)
		          with: (LightYear ofValue: 24)
		          with: (Parsecs ofValue: 6)
		          with: (Parsecs ofValue: 4).

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells
		at: 9
		put: (HyperJumpCell withConversor: aConversor andValues: values).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.
	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 9).
	aGame moveSpaceship.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 9).
	aGame moveSpaceship.


	result := Dictionary new.
	result at: 1 put: 14.


	self assert: aGame spaceships cellsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test54WhenAReverseIsActivatedTwiceOnTheSameMoonwalkCellThenDoesntAffects [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 4 4 10 ).

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	collectionOfCells at: 15 put: (MoonWalkCell withValueToMove: 4).

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.
	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 15).
	aGame moveSpaceship.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 15).
	aGame moveSpaceship.
	aGame moveSpaceship.


	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 15 andLap: 1).
	result at: 2 put: (Position startGameWithCell: 1 andLap: 1).


	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'spaceshipCardHand' }
GameCardTest >> test55WhenAReverseIsActivatedTwiceOnTheSameWormholeCellThenDoesntAffects [

	| aGame result |
	aLoadedDie := LoadedDie of: #( 4 3 10 ).

	aWormholeCreator := WormholeCreator withBeginning: 8 andEnd: 10.
	collectionOfCells := OrderedCollection new.

	20 timesRepeat: [ collectionOfCells add: Cell new ].

	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 3
		                 withWormholeCreator: aWormholeCreator.
	gameDeck := EffectManager
		            manage: (OrderedCollection with: ReverseCard)
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 8).
	aGame moveSpaceship.
	aGame
		usePermanentCard: ReverseCard
		toDoEffectFor: (collectionOfCells at: 8).
	aGame moveSpaceship.



	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 10 andLap: 1).



	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test56WhenASpaceshipActivatesTheTimeMachineCardReloadsTheFuelAndCanMove [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 10 8 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.



	aGame moveSpaceship. "1->11"
	aGame moveSpaceship. "1->19"
	aGame spaceshipId: 1 useInstantCard: TimeMachineCard toDoEffectFor: 1.
	aGame moveSpaceship. "1->29 lap 2 has more fuel so it can move"

	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 29 andLap: 1).


	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test57WhenASpaceshipTryToPlayTheTimeMachineAndHasNotCompletedTwoTurnsThenThrowsAnError [

	| aGame |
	aLoadedDie := LoadedDie of: #( 10 8 ).
	gameDeck := EffectManager
		            manage: (OrderedCollection with: TimeMachineCard )
		            withProbabilitiesDistribution: #( 100 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.


	self
		should: [
			aGame
				spaceshipId: 1
				useInstantCard: TimeMachineCard
				toDoEffectFor: 1 ]
		raise: Error
		withMessage:
		'The card cant be played if the spaceship has not completed 2 turns yet'
]

{ #category : 'redo ' }
GameCardTest >> test58WhenASpaceshipMakesMoreThanTwoMovementsThenDoesTheTimeMachineEffectWithTheLasTwoTurnsFuel [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 10 8 30 25 25 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.



	aGame moveSpaceship. "1->11" "60-10=50 fuel"
	aGame moveSpaceship. "1->19" "50-8=42"
	aGame moveSpaceship. "1->49 -> 19 lap 2 42-30=12"
	aGame spaceshipId: 1 useInstantCard: TimeMachineCard toDoEffectFor: 1. "reload 50"
	aGame moveSpaceship.
	aGame moveSpaceship. "1->69 -> 9 lap 4"

	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 9 andLap: 4).


	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test59WhenASpaceshipAllyWithOtherAndPlaysTimeMachineCardThenResetsTheFuelOfBothSpaceships [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 10 7 5 6 3 15 10 15 10 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.



	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame moveSpaceship. "(1) 30 -10 = 20 -> 11"
	aGame moveSpaceship. "(2) 30-7= 23 -> 8"
	aGame moveSpaceship. "(1) 20 -5 = 15 -> 16"
	aGame moveSpaceship. "(2) 23 -6 = 17 -> 14"
	aGame moveSpaceship. "(1) 15 -3 = 12 -> 19"
	aGame spaceshipId: 1 useInstantCard: TimeMachineCard toDoEffectFor: 1. "reloads to (1)->20 (2)->30"
	aGame moveSpaceship. "(2) 30 -15 = 15 -> 29"
	aGame moveSpaceship. "(1) 20 -10 = 12 -> 29"
	aGame moveSpaceship. "(2) 15 -15 = 0 -> 14 lap 2"
	aGame moveSpaceship. "(1) 10 -10 = 0 -> 9 lap 2"

	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 9 andLap: 2).
	result at: 2 put: (Position startGameWithCell: 14 andLap: 2).


	self assert: aGame spaceships positionsOfSpaceships equals: result
]

{ #category : 'redo ' }
GameCardTest >> test60WhenSpaceshipOnePlaysTwoTurnsAndSpaceshipTwoPlaysOneTurnAndSpaceshipOneWantsToPlayTimeMachineCardThenThrowsAnError [

	| aGame |
	aLoadedDie := LoadedDie of: #( 10 7 5 6 3 15 10 15 10 ).

	aGame := Game
		         numberOfSpaceships: 2
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.



	aGame usePermanentCard: AllyCard toDoEffectFor: 2.
	aGame moveSpaceship. "(1) 30 -10 = 20 -> 11"
	aGame moveSpaceship. "(2) 30-7= 23 -> 8"
	aGame moveSpaceship. "(1) 20 -5 = 15 -> 16"


	self
		should: [
			aGame
				spaceshipId: 1
				useInstantCard: TimeMachineCard
				toDoEffectFor: 1 ]
		raise: Error
		withMessage:
		'The card cant be played if the spaceship has not completed 2 turns yet'
]

{ #category : 'redo ' }
GameCardTest >> test61WhenASpaceshipPlaysATimeMachineCardAndAfterPlaysARedoCardThenTheRedoCardDoTheSameEffectAsTimeMachine [

	| result aGame |
	aLoadedDie := LoadedDie of: #( 10 8 7 ).

	aGame := Game
		         numberOfSpaceships: 1
		         with: aBoardCreator
		         playWith: aLoadedDie
		         andGameDeck: gameDeck.

	aGame moveSpaceship. "1 20-10=0 ->11"
	aGame moveSpaceship. "1 10-8=2 ->19"
	aGame spaceshipId: 1 useInstantCard: TimeMachineCard toDoEffectFor: 1. "reload to 20"
	aGame moveSpaceship. "1->20-7=13-> 26 "
	aGame spaceshipId: 1 useInstantCard: RedoCard toDoEffectFor: 1. "reload to 10"
	aGame moveSpaceship. "1->10-10=0 -> 36 6 lap 2"

	result := Dictionary new.
	result at: 1 put: (Position startGameWithCell: 6 andLap: 2).


	self assert: aGame spaceships positionsOfSpaceships equals: result
]
