Class {
	#name : 'FuelTankTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
FuelTankTest >> test01FuelTankInitializeWithAmountOfFuelThenIsLoadedWithTheSameAmount [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 10.

	self assert: aFuelTank loadedWith equals: 10
]

{ #category : 'tests' }
FuelTankTest >> test02FuelTankUseFuelThenLoadedWithFuelLessTheAmountUsed [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 10.
	aFuelTank useFuel: 3.
	
	self assert: aFuelTank loadedWith equals: 7
]

{ #category : 'tests' }
FuelTankTest >> test03FuelTankUseFuelAndLoadsTheSameAmountThenIsLoadedWithAmountInitializedWith [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 10.
	aFuelTank useFuel: 3.
	aFuelTank reloadToCapacity.

	self assert: aFuelTank loadedWith equals: 10
]

{ #category : 'tests' }
FuelTankTest >> test04FuelTankInitializeWithFuelThenIsNotEmpty [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 10.
	
	self deny: aFuelTank isEmpty
]

{ #category : 'tests' }
FuelTankTest >> test05FuelTankInitializedWithoutFuelThenIsEmpty [

	| aFuelTank |
	aFuelTank := FuelTank fullWith: 0.
	
	self assert: aFuelTank isEmpty
]
