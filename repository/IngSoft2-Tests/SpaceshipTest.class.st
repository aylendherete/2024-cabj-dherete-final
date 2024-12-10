Class {
	#name : 'SpaceshipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'move' }
SpaceshipTest >> test001SpaceshipInitializeInPositionOneAndMovesOneTimeThenIsInPositionTwo [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 5.
	Spaceship initialize.
	aSpaceship move: 1.
	self assert: aSpaceship position cell equals: 2
]

{ #category : 'move' }
SpaceshipTest >> test002SpaceshipMovesTwiceAndIsInPositionThree [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 5.
	Spaceship initialize.
	aSpaceship move: 2.
	self assert: aSpaceship position cell equals: 3
]

{ #category : 'position' }
SpaceshipTest >> test004WhenSpaceshipMovesTwiceThenPositionIsCellThreeAndLap1 [

	| aSpaceship aPosition |
	aSpaceship := Spaceship launchWithFuel: 5.
	aPosition := Position startGameWithCell: 3 andLap: 1.
	Spaceship initialize.
	aSpaceship move: 2.
	self assert: aSpaceship position equals: aPosition
]

{ #category : 'move' }
SpaceshipTest >> test005WhenASpaceshipMovesTwiceWithTwoJumps [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 5.
	Spaceship initialize.
	aSpaceship move: 1.
	aSpaceship move: 1.
	self assert: aSpaceship position cell equals: 3
]

{ #category : 'move' }
SpaceshipTest >> test006WhenSpaceshipMovesTwoTimesAndOneTimeThenPositionIsFour [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 5.
	Spaceship initialize.
	aSpaceship move: 2.
	aSpaceship move: 1.
	self assert: aSpaceship position cell equals: 4
]

{ #category : 'tests - initialization' }
SpaceshipTest >> test007WhenOneSpaceshipIsInitializeThenTheIdIsOne [ 

	| aSpaceshipOne |
	aSpaceshipOne := Spaceship launchWithFuel: 4.
	Spaceship initialize.
	self assert: aSpaceshipOne id equals: 1
]

{ #category : 'tests - initialization' }
SpaceshipTest >> test008WhenTwoSpaceshipsAreLaunchedThenSpaceshipTwoIdEqualsTwo [ 

	| aSpaceshipOne aSpaceshipTwo |
	aSpaceshipOne := Spaceship launchWithFuel: 4.
	aSpaceshipTwo := Spaceship launchWithFuel: 5.
	Spaceship initialize.
	self assert: aSpaceshipTwo id equals: 2
]

{ #category : 'position' }
SpaceshipTest >> test009WhenSpaceshipIsLaunchedThenStartsOnCellOneAndLapOne [

	| aSpaceship aPosition |
	aSpaceship := Spaceship launchWithFuel: 5.
	aPosition := Position startGame.
	Spaceship initialize.
	self assert: aSpaceship position equals: aPosition
]

{ #category : 'tests - initialization' }
SpaceshipTest >> test010WhenSpaceshipIsInitializeWithFuelThenAmountOfFuelStaysTheSame [ 

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 6.
	Spaceship initialize.
	self assert: aSpaceship amountOfFuel equals: 6
]

{ #category : 'fuelTests' }
SpaceshipTest >> test011WhenSpaceshipMovesOnceThenFuelIsOneLessThanInitializeWith [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 5.
	aSpaceship move: 1.
	Spaceship initialize.
	self assert: aSpaceship amountOfFuel equals: 4
]

{ #category : 'fuelTests' }
SpaceshipTest >> test012SpaceshipMovesMoreThanOneCellThenFuelWasteNumberOfMovements [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 10.
	aSpaceship move: 7.
	Spaceship initialize.
	self assert: aSpaceship amountOfFuel equals: 3
]

{ #category : 'fuelTests' }
SpaceshipTest >> test013SpaceshipsTriesToMoveMoreThanFuelThenOnlyMovesTheFuelItHas [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 5.
	aSpaceship move: 6.
	Spaceship initialize.
	self assert: aSpaceship position cell equals: 6
]

{ #category : 'fuelTests' }
SpaceshipTest >> test015WhenSpaceshipLoadsFuelAfterLosingAllOfItThenFuelEqualsAmountLoaded [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 5.
	aSpaceship move: 1.
	aSpaceship loadFuel.
	Spaceship initialize.
	self assert: aSpaceship amountOfFuel equals: 5
]

{ #category : 'fuelTests' }
SpaceshipTest >> test016WhenSpaceshipMovesAfterLoadingFuelThenMoves [

	| aSpaceship |
	aSpaceship := Spaceship launchWithFuel: 10.
	aSpaceship move: 1.
	aSpaceship loadFuel.
	aSpaceship move: 8.
	Spaceship initialize.
	self assert: aSpaceship position cell equals: 10
]

{ #category : 'move' }
SpaceshipTest >> test018SpaceshipMovesBackwardsThenPositionIsEqualToMovement [

	| aSpaceship finalPosition |
	finalPosition := Position startGameWithCell: 6 andLap: 1.

	aSpaceship := Spaceship launchWithFuel: 40.

	aSpaceship move: 9.
	aSpaceship move: -4.
	Spaceship initialize.
	self assert: aSpaceship position equals: finalPosition
]

{ #category : 'fuelTests' }
SpaceshipTest >> test019SpaceshipMoveBackwardsThenUsesFuel [

	| aSpaceship |

	aSpaceship := Spaceship launchWithFuel: 40.

	aSpaceship move: 9.
	aSpaceship move: -4.
	Spaceship initialize.
	self assert: aSpaceship amountOfFuel equals: 27
]

{ #category : 'fuelTests' }
SpaceshipTest >> test020SpaceshipMovesAfterLoadingFuelThenItMovesToThatPosition [

	| aSpaceship finalPosition |
	aSpaceship := Spaceship launchWithFuel: 10.

	aSpaceship move: 5.
	aSpaceship move: 4.
	aSpaceship loadFuel.
	aSpaceship move: 1.
	finalPosition := Position startGameWithCell: 16 andLap: 1.
	aSpaceship move: 5.
	Spaceship initialize.
	self assert: aSpaceship position equals: finalPosition
]

{ #category : 'move' }
SpaceshipTest >> test025SpaceshipMovesBackwardsThenGoesBackOneLap [

	| aSpaceship finalPosition |
	aSpaceship := Spaceship launchWithFuel: 40.
	finalPosition := Position startGameWithCell: 10 andLap: 1.
	aSpaceship move: 10.
	aSpaceship move: -1.
	Spaceship initialize.
	self assert: aSpaceship position equals: finalPosition
]
