Class {
	#name : 'ReverseCard',
	#superclass : 'Card',
	#instVars : [
		'cellAffected',
		'game'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ReverseCard class >> toDoEffectFor: aCellAffected [

	^ self new initializeToDoEffectFor:
		  aCellAffected 
]

{ #category : 'comparing' }
ReverseCard >> = arg1 [

	| tmp1 |
	tmp1 := self class == arg1 class.
	tmp1 ifTrue: [
		^ cellAffected = arg1 cell or: cellAffected = arg1 cell reverseCell ].
	nil.
	^ tmp1
]

{ #category : 'accessing' }
ReverseCard >> activateEffectOn: aGame forSpaceship: aSpaceship [

	game := aGame.
	cellAffected := aGame activateReverseEffectOn: cellAffected.
	aGame activateCard: self
]

{ #category : 'accessing' }
ReverseCard >> cell [ 
^cellAffected 
]

{ #category : 'action' }
ReverseCard >> deactivate [

	^ game activateReverseEffectOn: cellAffected.
]

{ #category : 'initialization' }
ReverseCard >> initializeToDoEffectFor: aCellAffected [

	cellAffected := aCellAffected .
]
