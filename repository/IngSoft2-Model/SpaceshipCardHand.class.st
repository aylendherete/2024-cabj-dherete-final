Class {
	#name : 'SpaceshipCardHand',
	#superclass : 'Object',
	#instVars : [
		'collectionOfCards',
		'aGameDeck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
SpaceshipCardHand class >> startGameWith: aGameDeck [

	^ self new initializeStartGameWith: aGameDeck
]

{ #category : 'action' }
SpaceshipCardHand >> gainACard [

	collectionOfCards add: (aGameDeck giveOneObject)
]

{ #category : 'initialization' }
SpaceshipCardHand >> initializeStartGameWith: gameDeck [

	aGameDeck := gameDeck.
	collectionOfCards := gameDeck createCollectionSize: 2
]

{ #category : 'removing' }
SpaceshipCardHand >> removeACard [

	| randomIndex |
	randomIndex:= (collectionOfCards size) atRandom.
	
	collectionOfCards removeAt: randomIndex.
	
]

{ #category : 'action' }
SpaceshipCardHand >> use: aCard [

	| cardToRemove |
	(collectionOfCards anySatisfy: [ :card | card = aCard ]) ifTrue: [
		cardToRemove := collectionOfCards detect: [ :card | card = aCard ].
		collectionOfCards remove: cardToRemove.
		^ true ].
	^ false
]
