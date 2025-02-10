Class {
	#name : 'GameOver',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
GameOver >> nextTurn [

	Error signal: 'The Game is Over'
]

{ #category : 'action' }
GameOver >> throw [

	Error signal: 'The Game is Over'
]
