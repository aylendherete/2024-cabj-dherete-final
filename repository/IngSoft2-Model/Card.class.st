Class {
	#name : 'Card',
	#superclass : 'Object',
	#instVars : [
		'spaceshipAffected'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Card class >> toDoEffectFor: aSpaceshipId [

	^ self new initializeToDoEffectFor: aSpaceshipId
]

{ #category : 'comparing' }
Card >> = aCard [

	^ self class == aCard class
]

{ #category : 'effect' }
Card >> activateEffectOn: aGame forSpaceship: anId [
	
	aGame activateCard: self

]

{ #category : 'effect' }
Card >> applyEffectOn: throwResult for: spaceshipId [

	^ throwResult
]

{ #category : 'action' }
Card >> deactivate [

	^ true
]

{ #category : 'initialization' }
Card >> initializeToDoEffectFor: aSpaceshipId [

	spaceshipAffected := aSpaceshipId
]
