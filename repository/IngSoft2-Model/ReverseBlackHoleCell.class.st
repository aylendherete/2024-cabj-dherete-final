Class {
	#name : 'ReverseBlackHoleCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
ReverseBlackHoleCell >> applyEffectTo: aSpaceship on: aGame [

	aGame move: aSpaceship a: 4
]

{ #category : 'cells creation' }
ReverseBlackHoleCell >> reverseCell [

	^ BlackHoleCell new.
]
