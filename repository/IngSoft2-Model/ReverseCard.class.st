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
ReverseCard class >> toDoEffectFor: aSpaceshipId [
^ self new initializeToDoEffectFor: aSpaceshipId
]

{ #category : 'accessing' }
ReverseCard >> activateEffectOn: aGame forSpaceship: anId [

	| spaceshipToApplyEffect cellToEnter |
	spaceshipToApplyEffect := aGame spaceships detectSpaceshipWithId:
		                          anId.

	cellToEnter := aGame cellOfSpaceship: spaceshipToApplyEffect.

	cellAffected := cellToEnter.

	cellAffected activateReverseEffect.

	aGame activateCard: self
]

{ #category : 'action' }
ReverseCard >> deactivate [

	^ cellAffected activateReverseEffect.
	
]
