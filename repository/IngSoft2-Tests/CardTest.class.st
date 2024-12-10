Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test01ActiveDeckActivateOverLoadCardThenApplyEffectApplysEffectOfIt [
	| aActiveDeck |
	aActiveDeck := ActiveDeck startGame.
	aActiveDeck activate: (OverloadCard toDoEffectFor: 2).

	self assert: (aActiveDeck applyEffectOn: 10 withCurrentSpaceship: 2) equals: 8
]

{ #category : 'tests' }
CardTest >> test02ActiveDeckRemoveOverloadCardThenNoEffectOnThatId [
	| aActiveDeck |
	aActiveDeck := ActiveDeck startGame.
	aActiveDeck activate: (OverloadCard toDoEffectFor: 2).
	aActiveDeck activate: (OverloadCard toDoEffectFor: 3).
	
	aActiveDeck removeACard: (OverloadCard toDoEffectFor: 3).

	self assert: (aActiveDeck applyEffectOn: 10 withCurrentSpaceship: 3) equals: 10
]
