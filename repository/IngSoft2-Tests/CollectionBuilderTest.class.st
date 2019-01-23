Class {
	#name : #CollectionBuilderTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #utilities }
CollectionBuilderTest >> occurrencesOf: aClass in: aCollection [
	^ (aCollection select: [ :each | each isMemberOf: aClass ]) size
]

{ #category : #'effects tests' }
CollectionBuilderTest >> testGenerateCollectionOfAtomicEffectCheckClassOfContents [
	| collection builder collectionLength |
	builder := CollectionBuilder fixedDistribution.
	builder withAtomicProbability: 100.
	collectionLength := 7.
	collection := builder collectionOfLength: collectionLength.
	self assert: collection size equals: collectionLength.
	self assert: (self occurrencesOf: AtomicEffect in: collection) equals: collectionLength
]

{ #category : #'effects tests' }
CollectionBuilderTest >> testGenerateCollectionOfCardFromDeckEffectCheckClassOfContents [
	| collection builder collectionLength |
	builder := CollectionBuilder fixedDistribution.
	builder withCardFromDeckProbability: 100 usingDeck: (DeckManager containing: {BlankCard new}).
	collectionLength := 7.
	collection := builder collectionOfLength: collectionLength.
	self assert: collection size equals: collectionLength.
	self assert: (self occurrencesOf: CardFromDeckEffect in: collection) equals: collectionLength
]

{ #category : #'general tests' }
CollectionBuilderTest >> testGenerateCollectionOfExpectedLength [
	| builder |
	builder := CollectionBuilder fixedDistribution.
	builder withAtomicProbability: 49.
	builder withSpeedUpProbability: 51.
	self assert: (builder collectionOfLength: 10) size equals: 10
]

{ #category : #'effects tests' }
CollectionBuilderTest >> testGenerateCollectionOfMoonWalkEffectCheckClassOfContents [
	| collection builder collectionLength |
	builder := CollectionBuilder fixedDistribution.
	builder withMoonWalkProbability: 100 withSteps: 5.
	collectionLength := 7.
	collection := builder collectionOfLength: collectionLength.
	self assert: collection size equals: collectionLength.
	self assert: (self occurrencesOf: MoonWalkEffect in: collection) equals: collectionLength
]

{ #category : #'effects tests' }
CollectionBuilderTest >> testGenerateCollectionOfNoEffectCheckClassOfContents [
	| collection builder collectionLength |
	builder := CollectionBuilder fixedDistribution.
	builder withNoEffectProbability: 100.
	collectionLength := 7.
	collection := builder collectionOfLength: collectionLength.
	self assert: collection size equals: collectionLength.
	self assert: (self occurrencesOf: NoEffect in: collection) equals: collectionLength
]

{ #category : #'effects tests' }
CollectionBuilderTest >> testGenerateCollectionOfSpeedUpEffectCheckClassOfContents [
	| collection builder collectionLength |
	builder := CollectionBuilder fixedDistribution.
	builder withSpeedUpProbability: 100.
	collectionLength := 7.
	collection := builder collectionOfLength: collectionLength.
	self assert: collection size equals: collectionLength.
	self assert: (self occurrencesOf: SpeedUpEffect in: collection) equals: collectionLength
]

{ #category : #'effects tests' }
CollectionBuilderTest >> testGenerateCollectionOfWormholeEffectCheckClassOfContents [
	| collection builder collectionLength |
	builder := CollectionBuilder fixedDistribution.
	builder withWormholeProbability: 100.
	collectionLength := 7.
	collection := builder collectionOfLength: collectionLength.
	self assert: collection size equals: collectionLength.
	self assert: (self occurrencesOf: WormholeEffect in: collection) equals: collectionLength
]

{ #category : #'general tests' }
CollectionBuilderTest >> testRaisesExceptionWhenIncorrectTotalOfProbabilites [
	| builder |
	builder := CollectionBuilder fixedDistribution.
	builder withAtomicProbability: 50.
	builder withSpeedUpProbability: 51.
	self
		should: [ builder collectionOfLength: 7 ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The sum of probabilities should be 100' ]
]
