Class {
	#name : 'FuelTank',
	#superclass : 'Object',
	#instVars : [
		'fuel',
		'capacity'
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

{ #category : 'initialization' }
FuelTank >> initializeFullWith: anAmountOfFuel [

	fuel := anAmountOfFuel.
	capacity := anAmountOfFuel.
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
FuelTank >> useFuel: anAmountOfFuel [

	fuel := fuel - anAmountOfFuel.
]
