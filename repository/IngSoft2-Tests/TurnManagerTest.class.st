Class {
	#name : 'TurnManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TurnManagerTest >> test01OneSpaceshipsThenTurnOneReturnsSpaceshipOne [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 1
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : 'tests' }
TurnManagerTest >> test02TwoSpaceshipsThenTurnTwoReturnsSpaceshipTwo [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 2
]

{ #category : 'tests' }
TurnManagerTest >> test03WhenRoundIsOverNextTurnIsTheFirstSpaceship [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.

	self assert: currentSpaceshipId equals: 1
]

{ #category : 'tests' }
TurnManagerTest >> test04WhenSpaceshipOneLosesTurnsTheNextTurnIsSpaceshipTwo [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 2
]

{ #category : 'tests' }
TurnManagerTest >> test05WhenSpaceshipOneLosesTwoTurnsThenSpaceshipTwoPlaysThem [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : 'tests' }
TurnManagerTest >> test06WhenEverySpaceshipsLosesTheirTurnThenReturnAnAllShipsDisabledHandler [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 1
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : 'tests' }
TurnManagerTest >> test07WhenSpaceshipLostTwoTurnsIsCalledTwiceAndTwoTurnsPassThenSpaceshipRecoversTurn [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 1
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager lostTurns: 2 by: 1.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]

{ #category : 'tests' }
TurnManagerTest >> test08OneSpaceshipLostOneTurnAndThenRecoversIt [

	| aTurnManager collectionOfSpaceships currentSpaceshipId |
	collectionOfSpaceships := CollectionOfSpaceships
		                          numberOfSpaceships: 2
		                          withAmountOfFuel: 5.

	aTurnManager := TurnManager manage: collectionOfSpaceships.
	aTurnManager lostTurns: 1 by: 1.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	aTurnManager nextTurn.
	currentSpaceshipId := aTurnManager spaceshipPlaying id.

	Spaceship initialize.
	self assert: currentSpaceshipId equals: 1
]
