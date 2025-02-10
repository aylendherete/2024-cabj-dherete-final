Class {
	#name : 'FuelTank',
	#superclass : 'Object',
	#instVars : [
		'fuel',
		'capacity',
		'lastFuels'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
FuelTank class >> fullWith: anAmountOfFuel [

	^ self new initializeFullWith: anAmountOfFuel
]

{ #category : 'action' }
FuelTank >> changeCapacity: aNumber [

	capacity := capacity + aNumber
]

{ #category : 'action' }
FuelTank >> consumeFuelAsReward [

	fuel := fuel - 1.
]

{ #category : 'initialization' }
FuelTank >> initializeFullWith: anAmountOfFuel [

	fuel := anAmountOfFuel.
	capacity := anAmountOfFuel.
	lastFuels := OrderedCollection new.
]

{ #category : 'asserting' }
FuelTank >> isEmpty [

	^ fuel <= 0
]

{ #category : 'action' }
FuelTank >> loadFuel: anAmountOfFuel [

	fuel := fuel + anAmountOfFuel
]

{ #category : 'set and get' }
FuelTank >> loadedWith [

	^ fuel
]

{ #category : 'action' }
FuelTank >> reloadToCapacity [

	fuel := capacity
]

{ #category : 'action' }
FuelTank >> restoreFuelToSecondLast [

	lastFuels size < 2 ifTrue: [
		Error signal:
			'The card cant be played if the spaceship has not completed 2 turns yet' ].
	fuel := lastFuels at: (lastFuels size - 1)
]

{ #category : 'action' }
FuelTank >> useFuel: anAmountOfFuel [

	lastFuels add: fuel.
	fuel := fuel - anAmountOfFuel.

]
