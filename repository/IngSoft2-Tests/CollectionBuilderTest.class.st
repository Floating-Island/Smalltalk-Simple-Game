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
CollectionBuilderTest >> testGenerateCollectionSpeedUpEffectCheckClassOfContents [
	| collection builder collectionLength |
	builder := CollectionBuilder fixedDistribution.
	builder withSpeedupProbability: 100.
	collectionLength := 7.
	collection := builder collectionOfLength: collectionLength.
	self assert: collection size equals: collectionLength.
	self assert: (self occurrencesOf: SpeedUpEffect in: collection) equals: collectionLength
]
