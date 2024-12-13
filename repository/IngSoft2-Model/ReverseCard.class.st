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
ReverseCard class >> toDoEffectFor: aSpaceshipId [
^ self new initializeToDoEffectFor: aSpaceshipId
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
