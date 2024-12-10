Class {
	#name : 'EffectManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
EffectManagerTest >> should: anErrorBlock raise: anErrorClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
EffectManagerTest >> test02EffectManagerCreatesCollectionOfEffectsSizeTwoThenCollectionSizeEqualsTwo [

	| aEffectManager array collection |
	array := OrderedCollection with: Cell.
	aEffectManager := EffectManager
		                  manage: array
		                  withProbabilitiesDistribution: #( 100 ).

	collection := aEffectManager createCollectionSize: 2.

	self assert: collection size equals: 2
]

{ #category : 'tests' }
EffectManagerTest >> test03EffectManagerManagesOnlyOneObjectThenCollectionCreatedOnlyHasThatObject [

	| aEffectManager array collection |
	array := OrderedCollection with: Cell new.
	aEffectManager := EffectManager
		                  manage: array
		                  withProbabilitiesDistribution: #( 100 ).

	collection := aEffectManager createCollectionSize: 100.

	self assert: ((collection at: 100 atRandom) isKindOf: Cell)
]

{ #category : 'error testing' }
EffectManagerTest >> test04EffectManagerThrowsErrorWhenSumOfProbabilitiesIsGreaterOrLessThanOneHundred [

	| array aEffectManager |
	array := OrderedCollection with: Cell with: BlackHoleCell.
	self
		should: [
			aEffectManager := EffectManager
		                  manage: array
		                  withProbabilitiesDistribution: #( 80 30 ). ]
		raise: Error
		withMessage: 'Sum of probabilities must be equal to one hundred'
]

{ #category : 'error testing' }
EffectManagerTest >> test05EffectManagerThrowsErrorWhenSizesOfCollectionsRecivedDoNotMatch [

	| array aEffectManager |
	array := OrderedCollection with: Cell with: BlackHoleCell with: AtomicBombCell.
	self
		should: [
			aEffectManager := EffectManager
		                  manage: array
		                  withProbabilitiesDistribution: #( 80 20 ). ]
		raise: Error
		withMessage: 'Size of objects to manage must be equal to size of distribution probabilities'
]

{ #category : 'tests' }
EffectManagerTest >> test06EffectManagerManagesTwoObjectsThenGiveOneObjectGivesOneOrTheOther [

	| aEffectManager array object |
	array := OrderedCollection with: Cell new with: AccelerationCard new.
	aEffectManager := EffectManager
		                  manage: array
		                  withProbabilitiesDistribution: #( 50 50 ).

	object := aEffectManager giveOneObject.

	self assert:
		((object isKindOf: Cell) or: (object isKindOf: AccelerationCard))
]
