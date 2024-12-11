Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#instVars : [
		'idOrCardToRedo'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RedoCard class >> toDoEffectFor: anIdOrCard [

	^ self new initializeToDoEffectFor: anIdOrCard
]

{ #category : 'accessing' }
RedoCard >> activateEffectOn: aGame forSpaceship: anId [

	| cardToRedo |
	cardToRedo := aGame lastCardPlayed toDoEffectFor: idOrCardToRedo.
	cardToRedo activateEffectOn: aGame forSpaceship: anId.
]

{ #category : 'initialization' }
RedoCard >> initializeToDoEffectFor: anIdOrCard [

	idOrCardToRedo := anIdOrCard
]
