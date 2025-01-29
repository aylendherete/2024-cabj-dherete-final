Class {
	#name : 'BlackHoleCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
BlackHoleCell >> applyEffectTo: aSpaceship on: aGame [

	
	 aGame move: aSpaceship a: -4 
]

{ #category : 'as yet unclassified' }
BlackHoleCell >> reverseCell [

	^ ReverseBlackHoleCell new.
]
