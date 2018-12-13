Class {
	#name : #FixedDistributor,
	#superclass : #Object,
	#instVars : [
		'fixedCollection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FixedDistributor class >> withProbabilityOfSpeedUp: aSpeedUpProbability wormhole: aWormholeProbability atomic: aAtomicProbability noEffect: aNoEffectProbability moonwalk: aMoonWalkProbability andMaximumMoonwalkSteps: aMaximumMoonwalkSteps [ 
	
	^self new initializeWithProbabilityOfSpeedUp: aSpeedUpProbability wormhole: aWormholeProbability atomic: aAtomicProbability noEffect: aNoEffectProbability moonwalk: aMoonWalkProbability andMaximumMoonwalkSteps: aMaximumMoonwalkSteps 
]

{ #category : #interaction }
FixedDistributor >> boardOfLength: aSize [
	| collection |
	collection := OrderedCollection new.
	aSize timesRepeat: [ collection add: self randomElementFromFixedCollection ].
	^ collection
]

{ #category : #interaction }
FixedDistributor >> collectionOf: aSize containingAll: aElement [
	^ OrderedCollection new: aSize withAll: aElement
]

{ #category : #initialization }
FixedDistributor >> initializeWithProbabilityOfSpeedUp: aSpeedUpProbability wormhole: aWormholeProbability atomic: aAtomicProbability noEffect: aNoEffectProbability moonwalk: aMoonWalkProbability andMaximumMoonwalkSteps: aMaximumMoonwalkSteps [
	self
		verifyCorrectProbabilitiesSum:
			{aSpeedUpProbability.
			aWormholeProbability.
			aAtomicProbability.
			aNoEffectProbability.
			aMoonWalkProbability}.
	fixedCollection := OrderedCollection new.
	fixedCollection addAll: (self collectionOf: aSpeedUpProbability containingAll: SpeedUpEffect new).
	fixedCollection addAll: (self collectionOf: aWormholeProbability containingAll: WormholeEffect new).
	fixedCollection addAll: (self collectionOf: aAtomicProbability containingAll: AtomicEffect new).
	fixedCollection addAll: (self collectionOf: aNoEffectProbability containingAll: NoEffect new).
	fixedCollection addAll: (self moonWalkcollectionOf: aMoonWalkProbability andMaximumSteps: aMaximumMoonwalkSteps)
]

{ #category : #interaction }
FixedDistributor >> moonWalkcollectionOf: aSize andMaximumSteps: steps [
	| collection |
	collection := OrderedCollection new.
	aSize timesRepeat: [ collection add: (MoonWalkEffect withSteps: steps atRandom) ].
	^ collection
]

{ #category : #interaction }
FixedDistributor >> randomElementFromFixedCollection [
	| index |
	index := fixedCollection size atRandom.
	^ fixedCollection at: index
]

{ #category : #validation }
FixedDistributor >> verifyCorrectProbabilitiesSum: aCollection [ 
	^ (aCollection sumNumbers: [ :each | each ]) = 100
		ifFalse: [ AssertionFailure signal: 'The sum of probabilities should be 100' ]
]
