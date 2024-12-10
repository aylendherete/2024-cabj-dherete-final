Class {
	#name : 'BoardCreatorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
BoardCreatorTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'initialization' }
BoardCreatorTest >> test01BoardCreatorInitializeThenCellsReturnsAmountOfCellsOnBoard [

	| aBoardCreator aWormholeCreator collectionOfCells |
	collectionOfCells := OrderedCollection new.
	5 timesRepeat: [ collectionOfCells add: Cell new ].

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	self assert: aBoardCreator cells equals: 5
]

{ #category : 'initialization' }
BoardCreatorTest >> test02BoardCreatorInitializeThenLapsReturnsAmountOfLaps [

	| aBoardCreator aWormholeCreator collectionOfCells |
	collectionOfCells := OrderedCollection new.
	5 timesRepeat: [ collectionOfCells add: Cell new ].

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.
	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 1
		                 withWormholeCreator: aWormholeCreator.

	self assert: aBoardCreator laps equals: 1
]

{ #category : 'tests' }
BoardCreatorTest >> test03BoardCreatorCreatesBoardWithCollectionOfCellsThenBoardHasThatCollectionPlusWhormHole [

	| board aBoardCreator aWormholeCreator collectionOfCells aConversor values |
	collectionOfCells := OrderedCollection new.
	aConversor := Conversor totalCells: 4 convertionValue: 8.
	values := OrderedCollection
		          with: (Parsecs ofValue: 10)
		          with: (LightYear ofValue: 24)
		          with: (Parsecs ofValue: 6)
		          with: (Parsecs ofValue: 4).


	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.

	collectionOfCells add: Cell new.
	collectionOfCells add: Cell new.
	collectionOfCells add: Cell new.
	collectionOfCells add: BlackHoleCell new.
	collectionOfCells add: AtomicBombCell new.
	collectionOfCells add: CardDispenserCell new.
	collectionOfCells add: (HyperGravityCell withValueToMove: 3).
	collectionOfCells add: (MoonWalkCell withValueToMove: 3).
	collectionOfCells add:
		(HyperJumpCell withConversor: aConversor andValues: values).


	aBoardCreator := BoardCreator
		                 with: collectionOfCells
		                 ofLaps: 2
		                 withWormholeCreator: aWormholeCreator.

	board := aBoardCreator createBoard.

	self assert: ((board at: 1) isKindOf: Cell).
	self assert: ((board at: 2) isKindOf: Wormhole).
	self assert: ((board at: 3) isKindOf: Wormhole).
	self assert: ((board at: 4) isKindOf: BlackHoleCell).
	self assert: ((board at: 5) isKindOf: AtomicBombCell).
	self assert: ((board at: 6) isKindOf: CardDispenserCell).
	self assert: ((board at: 7) isKindOf: HyperGravityCell).
	self assert: ((board at: 8) isKindOf: MoonWalkCell).
	self assert: ((board at: 9) isKindOf: HyperJumpCell)
]

{ #category : 'error testing' }
BoardCreatorTest >> test04BoardCreatorRecivesCollectionOfNotCellsThenErrorIsThrown [

	| aBoardCreator aWormholeCreator collectionOfNotCells |
	collectionOfNotCells := OrderedCollection new.
	5 timesRepeat: [ collectionOfNotCells add: Spaceship new ].

	aWormholeCreator := WormholeCreator withBeginning: 2 andEnd: 3.

	self
		should: [
			aBoardCreator := BoardCreator
				                 with: collectionOfNotCells
				                 ofLaps: 2
				                 withWormholeCreator: aWormholeCreator ]
		raise: Error
		withMessage: 'A board creator must recive a collection of cells'
]
