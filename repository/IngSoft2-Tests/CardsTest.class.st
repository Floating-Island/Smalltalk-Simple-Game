Class {
	#name : #CardsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'utilities for tests' }
CardsTest >> gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn [
	| die game collection board deck |
	collection := {4 . 2 . 3 . 4 . 5}.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'utilities for tests' }
CardsTest >> gameForRepeatTestWithPlayer: playerNamedLeo and: playerNamedGlenn [
	| die game collection board deck |
	collection := {4 . 2 . 3 . 4 . 5}.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	NoEffect new.
	NoEffect new.
	NoEffect new.
	SpeedUpEffect new.
	NoEffect new.
	NoEffect new.
	NoEffect new.
	NoEffect new.
	NoEffect new}.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #overload }
CardsTest >> testAddCardToGame [
	| overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	overloadCard := OverloadCard new.
	self assert: (game hasCard: overloadCard) equals: false.
	overloadCard playIn: game against: playerNamedLeo.
	self assert: (game hasCard: overloadCard) equals: true.
	self assert: game playersAffectedByCards first equals: playerNamedLeo.
	self assert: game cards first equals: overloadCard
]

{ #category : #acceleration }
CardsTest >> testApplyAccelerationAddsOneToEveryRoll [
	| accelerationCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	accelerationCard := AccelerationCard new.
	self assert: (game hasCard: accelerationCard) equals: false.
	accelerationCard playIn: game against: playerNamedLeo.
	self assert: (game hasCard: accelerationCard) equals: true.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 6.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 4
]

{ #category : #cancellation }
CardsTest >> testApplyCancellationRemoveChosenCard [
	| cancellationCard overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	overloadCard := OverloadCard new.
	self assert: (game hasCard: overloadCard) equals: false.
	overloadCard playIn: game against: playerNamedLeo.
	self assert: (game hasCard: overloadCard) equals: true.
	cancellationCard := CancellationCard new.
	cancellationCard playIn: game against: overloadCard.
	self assert: (game hasCard: overloadCard) equals: false
]

{ #category : #overload }
CardsTest >> testApplyOverloadCardWithCardRaisesException [
	| overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	overloadCard := OverloadCard new.
	self
		should: [ overloadCard playIn: game against: overloadCard ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Overload Card only applies to players' ]
]

{ #category : #overload }
CardsTest >> testApplyOverloadSubstractsTwoToManyPlayersRoll [
	| overloadCard overloadCardCopy game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	overloadCard := OverloadCard new.
	self assert: (game hasCard: overloadCard) equals: false.
	overloadCard playIn: game against: playerNamedLeo.
	overloadCardCopy := overloadCard deepCopy.
	self assert: (game hasCard: overloadCardCopy) equals: false.
	overloadCardCopy playIn: game against: playerNamedGlenn.
	self assert: (game hasCard: overloadCard) equals: true.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 3.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 1
]

{ #category : #overload }
CardsTest >> testApplyOverloadSubstractsTwoToPlayerRoll [
	| overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	overloadCard := OverloadCard new.
	self assert: (game hasCard: overloadCard) equals: false.
	overloadCard playIn: game against: playerNamedLeo.
	self assert: (game hasCard: overloadCard) equals: true.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 3
]

{ #category : #redo }
CardsTest >> testApplyRedoReapplyOverloadCard [
	| redoCard overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	overloadCard := OverloadCard new.
	overloadCard playIn: game against: playerNamedLeo.
	redoCard := RedoCard new.
	redoCard playIn: game against: playerNamedLeo.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 1
]

{ #category : #repeat }
CardsTest >> testApplyRepeatRepeatsSpeedUpEffect [
	| repeatCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForRepeatTestWithPlayer: playerNamedLeo and: playerNamedGlenn.
	repeatCard := RepeatCard new.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 9.
	repeatCard playIn: game against: playerNamedLeo.
	self assert: (game positionFor: playerNamedLeo) equals: 3
]

{ #category : #speed }
CardsTest >> testApplySpeedAddsOneToPlayerRoll [
	| speedCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	speedCard := SpeedCard new.
	speedCard playIn: game against: playerNamedLeo.
	self assert: (game hasCard: speedCard) equals: true.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 6
]

{ #category : #speed }
CardsTest >> testApplySpeedCardWithCardRaisesException [
	| speedCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	speedCard := SpeedCard new.
	self
		should: [ speedCard playIn: game against: speedCard ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Speed Card only applies to players' ]
]

{ #category : #cancellation }
CardsTest >> testApplyWithPlayerRaisesException [
	| cancellationCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	cancellationCard := CancellationCard new.
	self
		should: [ cancellationCard playIn: game against: playerNamedLeo ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Cancellation Card only applies to other cards' ]
]

{ #category : #cancellation }
CardsTest >> testRaiseExceptionIfGameHasNoCards [
	| cancellationCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForCardTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	cancellationCard := CancellationCard new.
	self
		should: [ cancellationCard playIn: game against: cancellationCard ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'There are no permanent cards in the game' ]
]
