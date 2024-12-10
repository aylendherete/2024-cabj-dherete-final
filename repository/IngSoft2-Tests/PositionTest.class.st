Class {
	#name : 'PositionTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
PositionTest >> test01PositioninitializeThenCellEqualsOne [

	| aPosition |
	aPosition := Position startGame.

	self assert: aPosition cell equals: 1
]

{ #category : 'tests' }
PositionTest >> test02PositioninitializeThenLapEqualsOne [

	| aPosition |
	aPosition := Position startGame.

	self assert: aPosition lap equals: 1
]

{ #category : 'tests' }
PositionTest >> test03PositioninitializeSetCellTwoThenCellEqualsTwo [

	| aPosition |
	aPosition := Position startGame.
	aPosition updateCell: 1.

	self assert: aPosition cell equals: 2
]

{ #category : 'tests' }
PositionTest >> test04PositioninitializeSetLapTwoThenLapEqualsTwo [

	| aPosition |
	aPosition := Position startGame.
	aPosition updateLap: 1.

	self assert: aPosition lap equals: 2
]

{ #category : 'tests' }
PositionTest >> test05PositionEqualsAnotherPosition [

	| aPosition position |
	aPosition := Position startGame.
	position := Position startGameWithCell: 1 andLap: 1.

	self assert: aPosition = position
]

{ #category : 'tests' }
PositionTest >> test06PositionIsNotEqualToAnotherPosition [

	| aPosition position |
	aPosition := Position startGame.
	position := Position startGameWithCell: 2 andLap: 1.

	self deny: aPosition = position
]

{ #category : 'tests' }
PositionTest >> test08PositionInitializeThenIsInLapOne [

	| aPosition |
	aPosition := Position startGame.

	self assert: (aPosition lap) equals: 1
]
