Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'utilities for tests' }
EffectTest >> gameForEffectsTestsWithPlayer: aPlayer and: anotherPlayer and: anotherMorePlayer [
	| oneMoreDie anotherDie board die game deck |
	board := UtilitiesForTests collectionOf20NoEffect.
	deck := DeckManager containing: ((FixedCardsDistributor withProbabilities: {(OverloadCard -> 100)} asDictionary) deckOfSize: 10).
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4}).
	anotherDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5 . 6}).
	oneMoreDie := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer.
			anotherMorePlayer}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'atomic effect tests' }
EffectTest >> testAtomicEffectAppliedAfterATurnEveryoneGoesBackToStart [
	| effect game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForEffectsTestsWithPlayer: playerNamedLeo and: playerNamedAlbert and: playerNamedGlenn.
	effect := AtomicEffect new.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedAlbert) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	effect triggerOn: game afterMovementOf: playerNamedAlbert.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedAlbert) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1
]

{ #category : #'atomic effect tests' }
EffectTest >> testAtomicEffectAppliedEveryoneGoesBackToStart [
	| effect game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForEffectsTestsWithPlayer: playerNamedLeo and: playerNamedAlbert and: playerNamedGlenn.
	effect := AtomicEffect new.
	self assert: (game positionFor: playerNamedAlbert) equals: 1.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	effect triggerOn: game afterMovementOf: playerNamedAlbert.
	self assert: (game positionFor: playerNamedAlbert) equals: 1.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1
]

{ #category : #'moonwalk effect tests' }
EffectTest >> testMoonWalkAppliedMovesEveryoneBack5SpacesExceptThePlayer [
	| number positionAlbert effect game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForEffectsTestsWithPlayer: playerNamedLeo and: playerNamedAlbert and: playerNamedGlenn.
	number := 5.
	effect := MoonWalkEffect withSteps: number.
	positionAlbert := game positionFor: playerNamedAlbert.
	self assert: (game positionFor: playerNamedAlbert) equals: positionAlbert.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self assert: (game lapFor: playerNamedAlbert) equals: 0.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	effect triggerOn: game afterMovementOf: playerNamedAlbert.
	self assert: (game positionFor: playerNamedAlbert) equals: positionAlbert.
	self assert: (game positionFor: playerNamedLeo) equals: 16.
	self assert: (game positionFor: playerNamedGlenn) equals: 16.
	self assert: (game lapFor: playerNamedAlbert) equals: 0.
	self assert: (game lapFor: playerNamedLeo) equals: -1.
	self assert: (game lapFor: playerNamedGlenn) equals: -1
]

{ #category : #'moonwalk effect tests' }
EffectTest >> testMoonWalkInitializedWith7Steps [
	| number effect |
	number := 7.
	effect := MoonWalkEffect withSteps: number.
	self assert: effect steps equals: number
]

{ #category : #'no effect tests' }
EffectTest >> testNoEffectAppliedNoChangeToPlayerPosition [
	| position effect game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForEffectsTestsWithPlayer: playerNamedLeo and: playerNamedAlbert and: playerNamedGlenn.
	effect := NoEffect new.
	position := game positionFor: playerNamedAlbert.
	effect triggerOn: game afterMovementOf: playerNamedAlbert.
	self assert: (game positionFor: playerNamedAlbert) equals: position
]

{ #category : #'random card tests' }
EffectTest >> testRandomEffectAppliedPlayerGetsCardFromCollection [
	| effect game playerNamedLeo playerNamedAlbert playerNamedGlenn overload speed deck |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForEffectsTestsWithPlayer: playerNamedLeo and: playerNamedAlbert and: playerNamedGlenn.
	overload := OverloadCard new.
	speed := SpeedCard new.
	deck := DeckManager
		containing:
			{overload.
			speed}.
	effect := CardFromDeckEffect withDeck: deck.
	self assert: (playerNamedAlbert hasCard: overload) equals: false.
	self assert: (playerNamedLeo hasCard: speed) equals: false.
	effect triggerOn: game afterMovementOf: playerNamedAlbert.
	effect triggerOn: game afterMovementOf: playerNamedLeo.
	self assert: (playerNamedAlbert hasCard: overload) equals: true.
	self assert: (playerNamedLeo hasCard: speed) equals: true
]

{ #category : #'speed up tests' }
EffectTest >> testSpeedUpAppliedGoForward4Positions [
	| position effect game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForEffectsTestsWithPlayer: playerNamedLeo and: playerNamedAlbert and: playerNamedGlenn.
	effect := SpeedUpEffect new.
	position := game positionFor: playerNamedAlbert.
	effect triggerOn: game afterMovementOf: playerNamedAlbert.
	self assert: (game positionFor: playerNamedAlbert) equals: position + 4
]

{ #category : #'wormhole effect tests' }
EffectTest >> testWormHoleAppliedGoBack4Positions [
	| effect game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForEffectsTestsWithPlayer: playerNamedLeo and: playerNamedAlbert and: playerNamedGlenn.
	effect := WormholeEffect new.
	self assert: (game positionFor: playerNamedAlbert) equals: 1.
	effect triggerOn: game afterMovementOf: playerNamedAlbert.
	self assert: (game positionFor: playerNamedAlbert) equals: 17.
	self assert: (game lapFor: playerNamedAlbert) equals: -1
]
