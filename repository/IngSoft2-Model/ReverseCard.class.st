Class {
	#name : 'ReverseCard',
	#superclass : 'Card',
	#instVars : [
		'cellAffected'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ReverseCard class >> toDoEffectFor: aCellAffected [

	^ self new initializeToDoEffectFor: aCellAffected 
]

{ #category : 'comparing' }
ReverseCard >> = aCard [

	| compareResult |
	compareResult := self class == aCard class.
	compareResult ifTrue: [ ^ cellAffected = aCard cell ].
	^ compareResult
]

{ #category : 'accessing' }
ReverseCard >> activateEffectOn: aGame forSpaceship: anId [


	cellAffected activateReverseEffect.

	aGame activateCard: self
]

{ #category : 'accessing' }
ReverseCard >> cell [ 
^cellAffected 
]

{ #category : 'action' }
ReverseCard >> deactivate [

	^ cellAffected activateReverseEffect.
	
]

{ #category : 'initialization' }
ReverseCard >> initializeToDoEffectFor: aCellAffected [ 

	cellAffected := aCellAffected .
]
