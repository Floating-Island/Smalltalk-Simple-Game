Class {
	#name : #FixedCardsDistributorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
FixedCardsDistributorTest >> occurrencesOf: aClass in: aCollection [
	^ (aCollection select: [ :each | each isMemberOf: aClass ]) size
]

{ #category : #tests }
FixedCardsDistributorTest >> testGenerateDeckOfExpectedLength [
	| deck distributor probabilities |
	probabilities := {(AccelerationCard -> 20).
	(BlankCard -> 20).
	(CancellationCard -> 2).
	(OverloadCard -> 48).
	(RedoCard -> 6).
	(RepeatCard -> 2).
	(SpeedCard -> 2)} asDictionary.
	distributor := FixedCardsDistributor withProbabilities: probabilities.
	deck := distributor deckOfSize: 10.
	self assert: deck size equals: 10
]

{ #category : #tests }
FixedCardsDistributorTest >> testRaisesExceptionWhenWrongProbabilities [
	self
		should: [ FixedCardsDistributor
				withProbabilities:
					{(AccelerationCard -> 20).
					(BlankCard -> 20).
					(CancellationCard -> 2).
					(OverloadCard -> 48).
					(RedoCard -> 6).
					(RepeatCard -> 2).
					(SpeedCard -> 4)} asDictionary ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The sum of probabilities should be 100' ]
]

{ #category : #tests }
FixedCardsDistributorTest >> testShouldGenerateBoardOfOnlyAcceleration [
	| deck distributor deckSize |
	distributor := FixedCardsDistributor withProbabilities: {(AccelerationCard -> 100)} asDictionary.
	deckSize := 7.
	deck := distributor deckOfSize: deckSize.
	self assert: deck size equals: deckSize.
	1 to: deckSize do: [ :eachIndex | self assert: ((deck at: eachIndex) isMemberOf: AccelerationCard) equals: true ]
]

{ #category : #tests }
FixedCardsDistributorTest >> testShouldGenerateBoardOfOnlyBlank [
	| deck distributor deckSize |
	distributor := FixedCardsDistributor withProbabilities: {(BlankCard -> 100)} asDictionary.
	deckSize := 7.
	deck := distributor deckOfSize: deckSize.
	self assert: deck size equals: deckSize.
	1 to: deckSize do: [ :eachIndex | self assert: ((deck at: eachIndex) isMemberOf: BlankCard) equals: true ]
]

{ #category : #tests }
FixedCardsDistributorTest >> testShouldGenerateBoardOfOnlyCancellation [
	| deck distributor deckSize |
	distributor := FixedCardsDistributor withProbabilities: {(CancellationCard -> 100)} asDictionary.
	deckSize := 7.
	deck := distributor deckOfSize: deckSize.
	self assert: deck size equals: deckSize.
	1 to: deckSize do: [ :eachIndex | self assert: ((deck at: eachIndex) isMemberOf: CancellationCard) equals: true ]
]

{ #category : #tests }
FixedCardsDistributorTest >> testShouldGenerateBoardOfOnlyOverload [
	| deck distributor deckSize |
	distributor := FixedCardsDistributor withProbabilities: {(OverloadCard -> 100)} asDictionary.
	deckSize := 7.
	deck := distributor deckOfSize: deckSize.
	self assert: deck size equals: deckSize.
	1 to: deckSize do: [ :eachIndex | self assert: ((deck at: eachIndex) isMemberOf: OverloadCard) equals: true ]
]

{ #category : #tests }
FixedCardsDistributorTest >> testShouldGenerateBoardOfOnlyRedo [
	| deck distributor deckSize |
	distributor := FixedCardsDistributor withProbabilities: {(RedoCard -> 100)} asDictionary.
	deckSize := 7.
	deck := distributor deckOfSize: deckSize.
	self assert: deck size equals: deckSize.
	1 to: deckSize do: [ :eachIndex | self assert: ((deck at: eachIndex) isMemberOf: RedoCard) equals: true ]
]

{ #category : #tests }
FixedCardsDistributorTest >> testShouldGenerateBoardOfOnlyRepeat [
	| deck distributor deckSize |
	distributor := FixedCardsDistributor withProbabilities: {(RepeatCard -> 100)} asDictionary.
	deckSize := 7.
	deck := distributor deckOfSize: deckSize.
	self assert: deck size equals: deckSize.
	1 to: deckSize do: [ :eachIndex | self assert: ((deck at: eachIndex) isMemberOf: RepeatCard) equals: true ]
]

{ #category : #tests }
FixedCardsDistributorTest >> testShouldGenerateBoardOfOnlySpeed [
	| deck distributor deckSize |
	distributor := FixedCardsDistributor withProbabilities: {(SpeedCard -> 100)} asDictionary.
	deckSize := 7.
	deck := distributor deckOfSize: deckSize.
	self assert: deck size equals: deckSize.
	1 to: deckSize do: [ :eachIndex | self assert: ((deck at: eachIndex) isMemberOf: SpeedCard) equals: true ]
]
