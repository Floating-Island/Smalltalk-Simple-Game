Class {
	#name : #FixedEffectsDistributorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
FixedEffectsDistributorTest >> occurrencesOf: aClass in: aCollection [
	^ (aCollection select: [ :each | each isMemberOf: aClass ]) size
]

{ #category : #tests }
FixedEffectsDistributorTest >> testGenerateBoardOfOnlyAtomicEffectCheckClassOfContents [
	| board distributor boardLength |
	distributor := FixedEffectsDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 100
		noEffect: 0
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	boardLength := 7.
	board := distributor boardOfLength: boardLength.
	self assert: board size equals: boardLength.
	1 to: boardLength do: [ :eachIndex | self assert: ((board at: eachIndex) isMemberOf: AtomicEffect) equals: true ]
]

{ #category : #tests }
FixedEffectsDistributorTest >> testGenerateBoardOfOnlyMoonwalkEffectCheckClassOfContents [
	| board distributor boardLength |
	distributor := FixedEffectsDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 0
		moonwalk: 100
		andMaximumMoonwalkSteps: 5.
	boardLength := 7.
	board := distributor boardOfLength: boardLength.
	self assert: board size equals: boardLength.
	1 to: boardLength do: [ :eachIndex | self assert: ((board at: eachIndex) isMemberOf: MoonWalkEffect) equals: true ]
]

{ #category : #tests }
FixedEffectsDistributorTest >> testGenerateBoardOfOnlyNoEffectCheckClassOfContents [
	| board distributor boardLength |
	distributor := FixedEffectsDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 100
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	boardLength := 7.
	board := distributor boardOfLength: boardLength.
	self assert: board size equals: boardLength.
	1 to: boardLength do: [ :eachIndex | self assert: ((board at: eachIndex) isMemberOf: NoEffect) equals: true ]
]

{ #category : #tests }
FixedEffectsDistributorTest >> testGenerateBoardOfOnlySpeedUpEffectCheckClassOfContents [
	| board distributor boardLength |
	distributor := FixedEffectsDistributor
		withProbabilityOfSpeedUp: 100
		wormhole: 0
		atomic: 0
		noEffect: 0
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	boardLength := 7.
	board := distributor boardOfLength: boardLength.
	self assert: board size equals: boardLength.
	1 to: boardLength do: [ :eachIndex | self assert: ((board at: eachIndex) isMemberOf: SpeedUpEffect) equals: true ]
]

{ #category : #tests }
FixedEffectsDistributorTest >> testGenerateDeckOfExpectedLength [
	| board distributor |
	distributor := FixedEffectsDistributor
		withProbabilityOfSpeedUp: 20
		wormhole: 20
		atomic: 2
		noEffect: 48
		moonwalk: 10
		andMaximumMoonwalkSteps: 5.
	board := distributor boardOfLength: 10.
	self assert: board size equals: 10
]

{ #category : #tests }
FixedEffectsDistributorTest >> testRaisesExceptionWhenWrongProbabilities [
	self
		should: [ FixedEffectsDistributor
				withProbabilityOfSpeedUp: 20
				wormhole: 200
				atomic: 2
				noEffect: 47
				moonwalk: 10
				andMaximumMoonwalkSteps: 5 ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The sum of probabilities should be 100' ]
]

{ #category : #tests }
FixedEffectsDistributorTest >> testShouldGenerateDeckOfOnlyAcceleration [
	| board distributor boardLength |
	distributor := FixedEffectsDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 100
		atomic: 0
		noEffect: 0
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	boardLength := 7.
	board := distributor boardOfLength: boardLength.
	self assert: board size equals: boardLength.
	1 to: boardLength do: [ :eachIndex | self assert: ((board at: eachIndex) isMemberOf: WormholeEffect) equals: true ]
]
