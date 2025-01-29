Class {
	#name : 'ReverseWormhole',
	#superclass : 'Cell',
	#instVars : [
		'cellPosition',
		'positionToGoTo'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
ReverseWormhole class >> in: aPosition to: anotherPosition [

	^ self new initializeIn: aPosition to: anotherPosition
]

{ #category : 'action' }
ReverseWormhole >> applyEffectTo: aSpaceship on: aGame [

	| numberOfMovements cellOfSpaceship |
	cellOfSpaceship := aSpaceship position cell.
	numberOfMovements := positionToGoTo - cellOfSpaceship.
	
	aGame doReverseEffectWormholeOf: aSpaceship with: numberOfMovements
]

{ #category : 'accessing' }
ReverseWormhole >> cell [

	^ cellPosition
]

{ #category : 'initialization' }
ReverseWormhole >> initializeIn: aPosition to: anotherPosition [

	cellPosition := aPosition.
	positionToGoTo := anotherPosition
]

{ #category : 'as yet unclassified' }
ReverseWormhole >> reverseCell [

	^ Wormhole in: cellPosition to: positionToGoTo
]
