Class {
	#name : 'ActiveDeck',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'lastCardPlayed'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ActiveDeck class >> startGame [

	^ self new initializeStartGame
]

{ #category : 'convenience' }
ActiveDeck >> activate: aCard [

	cards add: aCard .
	lastCardPlayed := aCard class
]

{ #category : 'action' }
ActiveDeck >> applyEffectOn: throwResult withCurrentSpaceship: spaceshipId [

	| auxNumber |
	auxNumber := throwResult.
	cards isEmpty ifTrue: [ ^ throwResult ].
	self each: [ :card |
		auxNumber := card applyEffectOn: auxNumber for: spaceshipId ].
	^ auxNumber
]

{ #category : 'removing' }
ActiveDeck >> each: aBlock [

	cards do: [ :card |
			aBlock value: card ]
]

{ #category : 'initialization' }
ActiveDeck >> initializeStartGame [

	cards := OrderedCollection new
]

{ #category : 'accessing' }
ActiveDeck >> lastCardPlayed [

	^ lastCardPlayed
]

{ #category : 'removing' }
ActiveDeck >> removeACard: cardToCancel [

	| anIndex indexToRemove |
	indexToRemove := 0.
	anIndex := 1.
	self each: [ :card |
		(card = cardToCancel) ifTrue: [
			indexToRemove := anIndex ].
		anIndex := anIndex + 1 ].
	(cards at: indexToRemove) deactivate.
	cards removeAt: indexToRemove.
]
