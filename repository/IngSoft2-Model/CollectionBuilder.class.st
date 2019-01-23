Class {
	#name : #CollectionBuilder,
	#superclass : #Object,
	#instVars : [
		'fixedDistributor',
		'probabilitiesTotal'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CollectionBuilder class >> fixedDistribution [
	^ self new initializeFixedDistribution
]

{ #category : #assertion }
CollectionBuilder >> assertCorrectProbabilitiesTotal [
	^ probabilitiesTotal = 100
		ifFalse: [ AssertionFailure signal: 'The sum of probabilities should be 100' ]
]

{ #category : #updating }
CollectionBuilder >> collectionOf: aSize containingAll: anElement [
	^ OrderedCollection new: aSize withAll: anElement
]

{ #category : #interaction }
CollectionBuilder >> collectionOfLength: aSize [
	| collection |
	self assertCorrectProbabilitiesTotal.
	collection := OrderedCollection new.
	aSize timesRepeat: [ collection add: self randomElementFromFixedDistributor ].
	^ collection
]

{ #category : #initialization }
CollectionBuilder >> initializeFixedDistribution [
	fixedDistributor := OrderedCollection new.
	probabilitiesTotal := 0
]

{ #category : #interaction }
CollectionBuilder >> moonWalkcollectionOf: aQuantity andMaximumSteps: maximumQuantity [
	| collection |
	collection := OrderedCollection new.
	aQuantity timesRepeat: [ collection add: (MoonWalkEffect withSteps: maximumQuantity atRandom) ].
	^ collection
]

{ #category : #interaction }
CollectionBuilder >> randomElementFromFixedDistributor [
	^ fixedDistributor atRandom
]

{ #category : #updating }
CollectionBuilder >> sumProbability: aQuantity [
	probabilitiesTotal := probabilitiesTotal + aQuantity
]

{ #category : #updating }
CollectionBuilder >> withAccelerationProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: AccelerationCard new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withAtomicProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: AtomicEffect new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withBlankProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: BlankCard new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withCancellationProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: CancellationCard new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withCardFromDeckProbability: aQuantity usingDeck: aDeckManager [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: (CardFromDeckEffect withDeck: aDeckManager)).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withMoonWalkProbability: aQuantity withSteps: maximumQuantity [
	fixedDistributor addAll: (self moonWalkcollectionOf: aQuantity andMaximumSteps: maximumQuantity).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withNoEffectProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: NoEffect new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withOverloadProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: OverloadCard new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withRedoProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: RedoCard new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withRepeatProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: RepeatCard new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withSpeedProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: SpeedCard new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withSpeedUpProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: SpeedUpEffect new).
	self sumProbability: aQuantity
]

{ #category : #updating }
CollectionBuilder >> withWormholeProbability: aQuantity [
	fixedDistributor addAll: (self collectionOf: aQuantity containingAll: WormholeEffect new).
	self sumProbability: aQuantity
]
