Class {
	#name : 'GameOverTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
GameOverTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [ 
	self should: anErrorBlock raise: anErrorClass withExceptionDo: [:error | self assert: error messageText equals: anErrorMessage ].
]

{ #category : 'tests' }
GameOverTest >> testGameOverNextTurnIsInvalid [

self should: [(GameOver new) nextTurn] raise: Error withMessage:'The Game is Over'.
]
