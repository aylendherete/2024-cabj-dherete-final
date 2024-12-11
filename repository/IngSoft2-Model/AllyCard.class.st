Class {
	#name : 'AllyCard',
	#superclass : 'Card',
	#instVars : [
		'game',
		'spaceshipId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
AllyCard >> = aCard [

	| compareResult |
	compareResult := self class == aCard class.
	compareResult ifTrue: [ ^ spaceshipAffected = aCard ally ].
	^ compareResult
]

{ #category : 'accessing' }
AllyCard >> activateEffectOn: aGame forSpaceship: anId [

	game := aGame.
	spaceshipId := anId.
	aGame ally: anId with: spaceshipAffected ofCard:self.
]

{ #category : 'set and get' }
AllyCard >> ally [

	^ spaceshipAffected 
]

{ #category : 'action' }
AllyCard >> deactivate [

	game stopAlly: spaceshipId.
]
