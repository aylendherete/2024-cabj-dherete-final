Class {
	#name : 'Cell',
	#superclass : 'Object',
	#instVars : [
		'applyReverse'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Cell >> activateReverseEffect [

	applyReverse:=true
]

{ #category : 'action' }
Cell >> applyEffectTo: aSpaceship on: aGame [

	
]

{ #category : 'initialization' }
Cell >> initialize [ 
	applyReverse :=false.
]
