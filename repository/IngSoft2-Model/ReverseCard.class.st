Class {
	#name : 'ReverseCard',
	#superclass : 'Card',
	#instVars : [
		'cellAffected',
		'position',
		'game'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ReverseCard class >> toDoEffectFor: aCellAffected [

	^ self new initializeToDoEffectFor:
		  aCellAffected 
]

{ #category : 'comparing' }
ReverseCard >> = aCard [

	| compareResult |
	compareResult := self class == aCard class.
	compareResult ifTrue: [ ^ (cellAffected = aCard cell or: cellAffected= aCard cell reverseCell)].
	^ compareResult
]

{ #category : 'accessing' }
ReverseCard >> activateEffectOn: aGame forSpaceship: anId [
	"cellAffected activateReverseEffect."

	game := aGame.
	cellAffected:=aGame activateReverseEffectOn: cellAffected inPosition: position.

	aGame activateCard: self
]

{ #category : 'accessing' }
ReverseCard >> cell [ 
^cellAffected 
]

{ #category : 'action' }
ReverseCard >> deactivate [

	^ game activateReverseEffectOn: cellAffected inPosition: nil.
]

{ #category : 'initialization' }
ReverseCard >> initializeToDoEffectFor: aCellAffected [

	cellAffected := aCellAffected .
]
