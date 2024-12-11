Class {
	#name : 'Wormhole',
	#superclass : 'Cell',
	#instVars : [
		'cellPosition',
		'positionToGoTo'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
Wormhole class >> in: aPosition to: anotherPosition [

	^ self new initializeIn: aPosition to: anotherPosition
]

{ #category : 'action' }
Wormhole >> applyEffectTo: aSpaceship on: aGame [
	
	| numberOfMovements cellOfSpaceship |
	cellOfSpaceship := aSpaceship position cell.
	numberOfMovements := positionToGoTo - cellOfSpaceship.
	aSpaceship move: numberOfMovements
]

{ #category : 'accessing' }
Wormhole >> cell [

	^ cellPosition
]

{ #category : 'initialization' }
Wormhole >> initializeIn: aPosition to: anotherPosition [

	cellPosition := aPosition.
	positionToGoTo := anotherPosition
]
