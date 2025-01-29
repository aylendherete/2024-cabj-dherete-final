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

{ #category : 'cells creation' }
AtomicBombCell >> reverseCell [
^ ReverseAtomicBombCell new.
]
