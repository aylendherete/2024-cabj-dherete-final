Class {
	#name : 'CardDispenserCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardDispenserCell >> applyEffectTo: aSpaceship on: aGame [

	applyReverse ifTrue:[aGame takeOutOneRandomCardTo: aSpaceship ] ifFalse:[aGame giveOneCardTo: aSpaceship].
]
