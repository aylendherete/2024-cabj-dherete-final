Class {
	#name : 'ReverseCard',
	#superclass : 'Object',
	#instVars : [
		'spaceshipAffected'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ReverseCard class >> toDoEffectFor: arg1 [

	^ self new initializeToDoEffectFor: arg1
]

{ #category : 'accessing' }
ReverseCard >> activateEffectOn: aGame forSpaceship: anId [

	| spaceshipToApplyEffect cellToEnter |
	spaceshipToApplyEffect := aGame spaceships detectSpaceshipWithId:
		                          anId.

	cellToEnter := aGame cellOfSpaceship: spaceshipToApplyEffect.

	cellToEnter activateReverseEffect.
]

{ #category : 'initialization' }
ReverseCard >> initializeToDoEffectFor: aSpaceshipId [

	spaceshipAffected := aSpaceshipId.
]
