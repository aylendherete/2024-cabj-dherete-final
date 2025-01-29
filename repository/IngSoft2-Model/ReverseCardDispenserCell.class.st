Class {
	#name : 'ReverseCardDispenserCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
ReverseCardDispenserCell >> applyEffectTo: aSpaceship on: aGame [

aGame takeOutOneRandomCardTo: aSpaceship 

]

{ #category : 'as yet unclassified' }
ReverseCardDispenserCell >> reverseCell [

	^ CardDispenserCell new
]
