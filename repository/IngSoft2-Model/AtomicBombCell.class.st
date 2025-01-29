Class {
	#name : 'AtomicBombCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
AtomicBombCell >> applyEffectTo: aSpaceship on: aGame [

	aGame resetSpaceshipsToCellOne 
]

{ #category : 'as yet unclassified' }
AtomicBombCell >> reverseCell [
^ ReverseAtomicBombCell new.
]
