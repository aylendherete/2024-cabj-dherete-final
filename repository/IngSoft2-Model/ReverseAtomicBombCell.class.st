Class {
	#name : 'ReverseAtomicBombCell',
	#superclass : 'Cell',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
ReverseAtomicBombCell >> applyEffectTo: aSpaceship on: aGame [

]

{ #category : 'cells creation' }
ReverseAtomicBombCell >> reverseCell [
^AtomicBombCell .
]
