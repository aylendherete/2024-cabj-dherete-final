Class {
	#name : 'CardDispenserCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardDispenserCell >> applyEffectTo: aSpaceship on: aGame [

	aGame giveOneCardTo: aSpaceship
]

{ #category : 'as yet unclassified' }
CardDispenserCell >> reverseCell [ 
^ReverseCardDispenserCell new.
]
