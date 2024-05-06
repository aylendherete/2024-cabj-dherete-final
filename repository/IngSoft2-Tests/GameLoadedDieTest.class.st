Class {
	#name : #GameLoadedDieTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
GameLoadedDieTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [ :error | self assert: error messageText equals: anErrorMessage ]
]

{ #category : #testsGame002 }
GameLoadedDieTest >> test00GameCreatedWithBoxesALoadedDieMovesSpaceshipSixPositions [

	| aGame |
	aGame := GameLoadedDie 
		         numberOfSpaceships: 1 
				   boardBoxes: 10
		         wormholeStartAndEnd: #(2 3)
		         playWithDice: #(6).

	self assert: aGame moveSpaceship equals: 6
]

{ #category : #testsGame002 }
GameLoadedDieTest >> test01GameMovesSpaceshipTwiceWithLoadedDieOf6ThenReturnsTwelve [

	| aGame |
	aGame := GameLoadedDie 
		         numberOfSpaceships: 1 
				   boardBoxes: 15
		         wormholeStartAndEnd: #(4 7)
		         playWithDice: #(6).
	aGame moveSpaceship.

	self assert: aGame moveSpaceship equals: 12
]

{ #category : #testsGame002 }
GameLoadedDieTest >> test02GameMovesSpaceshipFallsOnWormholeThenPositionIsTheOtherSide [

| aGame |
aGame:= GameLoadedDie numberOfSpaceships: 1 boardBoxes: 15 wormholeStartAndEnd: #(6 8) playWithDice: #(6) .

self assert: aGame moveSpaceship equals: 8. 


]

{ #category : #testsGame002 }
GameLoadedDieTest >> test03WhenSpaceshipReachesTheFinishLineThenIsGameLoadedDieOver [

| aGame resultOfGame |
resultOfGame:= #(12)asOrderedCollection .
aGame:= GameLoadedDie numberOfSpaceships: 1 boardBoxes: 12 wormholeStartAndEnd: #(5 7) playWithDice: #(6).
aGame moveSpaceship .

self assert: (aGame moveSpaceship) equals: resultOfGame.


]

{ #category : #tests }
GameLoadedDieTest >> test04InitializeWithTwoSpaceshipsMovesThreeTimesThenTheFirstOnesPositionIsTwelve [

| aGame |
aGame:= GameLoadedDie numberOfSpaceships: 2 boardBoxes: 50 wormholeStartAndEnd: #(40 45) playWithDice: #(6).
aGame moveSpaceship .
aGame moveSpaceship .

self assert: (aGame moveSpaceship) equals:12.
]

{ #category : #tests }
GameLoadedDieTest >> test05FirstSpaceshipWinsThenSecondSpaceshipCannotPlay [


self should: [ | aGame |
aGame:= GameLoadedDie numberOfSpaceships: 2 boardBoxes: 12 wormholeStartAndEnd: #(5 7) playWithDice: #(6).
aGame moveSpaceship .
aGame moveSpaceship .
aGame moveSpaceship .
aGame moveSpaceship . ] raise: Error withMessage: 'The Game is Over'.
]

{ #category : #tests }
GameLoadedDieTest >> test06SpaceshipOneWinsThenResultOfGameShowsPositions [

| aGame resultOfGame |
resultOfGame:= #(12 6)asOrderedCollection .
aGame:= GameLoadedDie numberOfSpaceships: 2 boardBoxes: 12 wormholeStartAndEnd: #(5 7) playWithDice: #(6).
aGame moveSpaceship .
aGame moveSpaceship .

self assert: (aGame moveSpaceship) equals: resultOfGame.
]