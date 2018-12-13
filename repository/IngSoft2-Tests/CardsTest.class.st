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

{ #category : #cancellation }
CardsTest >> shortGameWithFirstPlayer: aPlayer andSecondPlayer: anotherPlayer [
	| die game collection board deck |
	collection := {22}.
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #overload }
CardsTest >> testAddCardToGameMakesGameToStoreIt [
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

{ #category : #acceleration }
CardsTest >> testUsingAccelerationCardAfterTheGameHasFinishedRaisesException [
	| playerNamedLeo playerNamedGlenn game acceleration |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	acceleration := AccelerationCard new.
	game := self shortGameWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: game hasFinished equals: true.
	playerNamedGlenn addCard: acceleration.
	self
		should: [ playerNamedGlenn uses: acceleration in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t use card when game has finished' ]
]

{ #category : #blank }
CardsTest >> testUsingBlankCardAfterTheGameHasFinishedRaisesException [
	| playerNamedLeo playerNamedGlenn game blank |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	blank := BlankCard new.
	game := self shortGameWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: game hasFinished equals: true.
	playerNamedGlenn addCard: blank.
	self
		should: [ playerNamedGlenn uses: blank in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t use card when game has finished' ]
]

{ #category : #cancellation }
CardsTest >> testUsingCancellationCardAfterTheGameHasFinishedRaisesException [
	| playerNamedLeo playerNamedGlenn game cancellation |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	cancellation := CancellationCard new.
	game := self shortGameWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: game hasFinished equals: true.
	playerNamedGlenn addCard: cancellation.
	self
		should: [ playerNamedGlenn uses: cancellation in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t use card when game has finished' ]
]

{ #category : #overload }
CardsTest >> testUsingOverloadCardAfterTheGameHasFinishedRaisesException [
	| playerNamedLeo playerNamedGlenn game overload |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	overload := OverloadCard new.
	game := self shortGameWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: game hasFinished equals: true.
	playerNamedGlenn addCard: overload.
	self
		should: [ playerNamedGlenn uses: overload in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t use card when game has finished' ]
]

{ #category : #redo }
CardsTest >> testUsingRedoCardAfterTheGameHasFinishedRaisesException [
	| playerNamedLeo playerNamedGlenn game redo |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	redo := RedoCard new.
	game := self shortGameWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: game hasFinished equals: true.
	playerNamedGlenn addCard: redo.
	self
		should: [ playerNamedGlenn uses: redo in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t use card when game has finished' ]
]

{ #category : #repeat }
CardsTest >> testUsingRepeatCardAfterTheGameHasFinishedRaisesException [
	| playerNamedLeo playerNamedGlenn game repeat |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	repeat := RepeatCard new.
	game := self shortGameWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: game hasFinished equals: true.
	playerNamedGlenn addCard: repeat.
	self
		should: [ playerNamedGlenn uses: repeat in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t use card when game has finished' ]
]

{ #category : #speed }
CardsTest >> testUsingSpeedCardAfterTheGameHasFinishedRaisesException [
	| playerNamedLeo playerNamedGlenn game speed |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	speed := SpeedCard new.
	game := self shortGameWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: game hasFinished equals: true.
	playerNamedGlenn addCard: speed.
	self
		should: [ playerNamedGlenn uses: speed in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Can''t use card when game has finished' ]
]
