Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'test utilities' }
GameTest >> assert: a hasTheSameOrderThan: b [
	self assert: a asOrderedCollection equals: b asOrderedCollection
]

{ #category : #'test utilities' }
GameTest >> collectionOf16NoEffect [
	| distributor |
	distributor := FixedDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 100
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	^ distributor boardOfLength: 16
]

{ #category : #'test utilities' }
GameTest >> collectionOf5NoEffect [
	| distributor |
	distributor := FixedDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 100
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	^ distributor boardOfLength: 5
]

{ #category : #'test utilities' }
GameTest >> collectionOf80NoEffect [
	| distributor |
	distributor := FixedDistributor
		withProbabilityOfSpeedUp: 0
		wormhole: 0
		atomic: 0
		noEffect: 100
		moonwalk: 0
		andMaximumMoonwalkSteps: 5.
	^ distributor boardOfLength: 80
]

{ #category : #'create tests' }
GameTest >> gameDistributedWithPlayer: aPlayer and: anotherPlayer [
	| lapsAmount board die game deck noEffect speedUpEffect wormHoleEffect moonWalkEffect atomicEffect overload |
	noEffect := NoEffect new.
	speedUpEffect := SpeedUpEffect new.
	wormHoleEffect := WormholeEffect new.
	moonWalkEffect := MoonWalkEffect withSteps: 2.
	atomicEffect := AtomicEffect new.
	board := {speedUpEffect.
	speedUpEffect.
	noEffect.
	noEffect.
	noEffect.
	noEffect.
	wormHoleEffect.
	wormHoleEffect.
	moonWalkEffect.
	speedUpEffect} asOrderedCollection.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 7 . 3 . 8 . 1 . 6 . 10 . 1 . 5 . 6 . 3}).
	lapsAmount := 3.
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'test laps' }
GameTest >> gameForLapsWithPlayer: aPlayer and: anotherPlayer and: oneMorePlayer [
	| oneMoreDie anotherDie board die game deck overload |
	board := UtilitiesForTests collectionOf20NoEffect.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 7 . 1}).
	anotherDie := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 7 . 1}).
	oneMoreDie := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 7 . 1}).
	game := Game
		playedBy:
			{aPlayer.
			oneMorePlayer.
			anotherPlayer}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 2.
	^ game
]

{ #category : #'test laps' }
GameTest >> gameForPositionForWithPlayer: aPlayer and: anotherPlayer and: oneMorePlayer [
	| oneMoreDie anotherDie board die game deck overload |
	board := UtilitiesForTests collectionOf20NoEffect.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 5 . 1}).
	anotherDie := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 5 . 1}).
	oneMoreDie := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 5 . 1}).
	game := Game
		playedBy:
			{aPlayer.
			oneMorePlayer.
			anotherPlayer}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 2.
	^ game
]

{ #category : #'test results' }
GameTest >> gameForResultsAnotherIteratorWithPlayer: aPlayer and: anotherPlayer and: oneMorePlayer [
	| oneMoreDie anotherDie board die game deck overload |
	board := self collectionOf16NoEffect.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4}).
	anotherDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5 . 6}).
	oneMoreDie := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	game := Game
		playedBy:
			{aPlayer.
			oneMorePlayer.
			anotherPlayer}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'test results' }
GameTest >> gameForResultsIteratorWithPlayer: aPlayer and: anotherPlayer and: oneMorePlayer [
	| oneMoreDie anotherDie board die game deck overload |
	board := self collectionOf80NoEffect.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 5 . 6 . 40}).
	anotherDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 5 . 6 . 40}).
	oneMoreDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 5 . 6 . 40}).
	"this way, we are assured that the third player will win"
	game := Game
		playedBy:
			{aPlayer.
			oneMorePlayer.
			anotherPlayer}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'test return' }
GameTest >> gameForReturnLenghtOf: board [
	| aPlayer collection anotherPlayer lapsAmount die game deck overload |
	aPlayer := Player named: 'Leo'.
	anotherPlayer := Player named: 'Glenn'.
	collection := {1 . 2 . 3 . 4 . 5}.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	lapsAmount := 3.
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameForTurnOrderLike: aPlayer and: anotherPlayer [
	| die game collection board deck overload |
	collection := {1 . 2 . 3 . 4 . 5}.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: 1.
	self assert: game boardLength equals: 20.
	self assert: (game positionFor: aPlayer) equals: 1.
	self assert: (game positionFor: anotherPlayer) equals: 1.
	self
		assert: game dice
		equals:
			{die.
			die}.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameUsingAnAtomicEffectWithPlayer: aPlayer and: anotherPlayer [
	| collection lapsAmount board die game deck overload |
	collection := {1}.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	NoEffect new.
	AtomicEffect new.
	NoEffect new.
	NoEffect new}.
	lapsAmount := 3.
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameUsingAnotherAtomicEffectWithPlayer: aPlayer and: anotherPlayer [
	| collection lapsAmount board die game deck overload |
	collection := {6 . 6 . 1}.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	NoEffect new.
	AtomicEffect new.
	NoEffect new.
	NoEffect new}.
	lapsAmount := 3.
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'cards tests' }
GameTest >> gameUsingCardsWithFirstPlayer: aPlayer andSecondPlayer: anotherPlayer [
	| die game collection board deck overload |
	collection := {4 . 2 . 3 . 4 . 5}.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload}.
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

{ #category : #'cards tests' }
GameTest >> gameUsingCardsWithFirstPlayer: aPlayer andSecondPlayer: anotherPlayer WithDeck: aDeck [
	| collection board die game |
	collection := {1 . 2 . 3 . 4 . 5 . 20}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer}
		throwing: {die}
		using: aDeck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'test laps' }
GameTest >> gameWith5NoEffectBoard3LapsAndWithPlayer: aPlayer [
	| die game board deck overload |
	board := self collectionOf5NoEffect.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {5}).
	game := Game
		playedBy: {aPlayer}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: 3.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameWithPlayer: aPlayer and: anotherPlayer and: oneMorePlayer [
	| oneMoreDie anotherDie board die game deck overload |
	board := UtilitiesForTests collectionOf20NoEffect.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4}).
	anotherDie := Die withSides: 6 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5 . 6}).
	oneMoreDie := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	game := Game
		playedBy:
			{anotherPlayer.
			oneMorePlayer.
			aPlayer}
		throwing:
			{die.
			anotherDie.
			oneMoreDie}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'turn tests' }
GameTest >> gameWithPlayer: aPlayer and: anotherPlayer usingEffect: effect [
	| collection lapsAmount board die game deck overload |
	collection := {1}.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	effect.
	NoEffect new.
	NoEffect new.
	NoEffect new}.
	lapsAmount := 3.
	game := Game
		playedBy:
			{aPlayer.
			anotherPlayer}
		throwing: {die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	^ game
]

{ #category : #'test return' }
GameTest >> testCheckGameHasFinishedWhenRunningAndFinished [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForResultsAnotherIteratorWithPlayer: playerNamedLeo and: playerNamedGlenn and: playerNamedAlbert.
	self assert: game hasFinished equals: false.
	"1st round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"1st round end."
	self assert: game hasFinished equals: false.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	self
		assert: game ranking
		hasTheSameOrderThan:
			{playerNamedGlenn.
			playerNamedAlbert.
			playerNamedLeo}.
	"2nd round start:"
	self assert: game hasFinished equals: false.
	playerNamedLeo takesATurnIn: game.
	self assert: game hasFinished equals: true.
	"2nd round end."
	"results:"
	self assert: (game positionFor: playerNamedLeo) equals: 16.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #tests }
GameTest >> testCreateGame [
	| game playerNamedLeo playerNamedGlenn die board collection deck overload |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	collection := {1 . 2 . 3 . 4 . 5}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: 1.
	self assert: game boardLength equals: 20.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self
		assert: game dice
		equals:
			{die.
			die}
]

{ #category : #tests }
GameTest >> testCreateGameWithBoard [
	| board game playerNamedLeo playerNamedGlenn die collection lapsAmount deck overload |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	collection := {1 . 2 . 3 . 4 . 5}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := {NoEffect new.
	WormholeEffect new.
	SpeedUpEffect new.
	AtomicEffect new.
	(MoonWalkEffect withSteps: 1)}.
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	self assert: game board equals: board
]

{ #category : #'create tests' }
GameTest >> testCreateGameWithDistributedBoardGiveRanking [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameDistributedWithPlayer: playerNamedLeo and: playerNamedGlenn.
	"First turn:"
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	playerNamedLeo takesATurnIn: game.	"dice rolls 1, ends in position 2."
	self assert: (game positionFor: playerNamedLeo) equals: 6.	"SpeedUp effect applied, goes 4 positions forward."
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 7, ends in position 8"
	self assert: (game positionFor: playerNamedGlenn) equals: 4.	"Wormhole effect applied, goes 4 positions backwards."
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	"Second turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 3, ends in position 9"
	self assert: (game positionFor: playerNamedLeo) equals: 9.	"moonwalk effect applied, Glenn goes 2 positions backwards."
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 8, ends in position 10"
	self assert: (game positionFor: playerNamedGlenn) equals: 4.	"SpeedUp effect applied, ends 4 positions forward. Ends in next lap."
	self assert: (game lapFor: playerNamedGlenn) equals: 1.
	"Third turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 1, ends in position 10"
	self assert: (game positionFor: playerNamedLeo) equals: 4.	"SpeedUp effect applied, ends 4 positions forward in next lap."
	self assert: (game lapFor: playerNamedLeo) equals: 1.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 6, ends in position 10"
	self assert: (game positionFor: playerNamedGlenn) equals: 4.	"SpeedUp effect applied, ends 4 positions forward. Ends in next lap."
	self assert: (game lapFor: playerNamedGlenn) equals: 2.
	"Fourth turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 10, ends in the same position, next lap."
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game lapFor: playerNamedLeo) equals: 2.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 1, ends in position 5"
	self assert: (game positionFor: playerNamedGlenn) equals: 5.
	self assert: (game lapFor: playerNamedGlenn) equals: 2.
	"Fifth turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 5, ends in position 9"
	self assert: (game positionFor: playerNamedLeo) equals: 9.	"moonwalk effect applied, Glenn goes 2 positions backwards."
	self assert: (game lapFor: playerNamedLeo) equals: 2.
	playerNamedGlenn takesATurnIn: game.	"dice rolls 6, ends in position 9"
	self assert: (game positionFor: playerNamedGlenn) equals: 9.	"moonwalk effect applied, Leo goes 2 positions backwards."
	self assert: (game lapFor: playerNamedGlenn) equals: 2.
	"Sixth turn:"
	playerNamedLeo takesATurnIn: game.	"dice rolls 3, ends in position 10"
	self assert: (game positionFor: playerNamedLeo) equals: 4.	"SpeedUp effect applied, goes 4 positions forward. Ends in next lap. Leo wins"
	self assert: (game lapFor: playerNamedLeo) equals: 3.
	self assert: (game positionFor: playerNamedGlenn) equals: 9.
	self assert: (game lapFor: playerNamedGlenn) equals: 2.
	self
		assert: game ranking
		hasTheSameOrderThan:
			{playerNamedLeo.
			playerNamedGlenn}
]

{ #category : #tests }
GameTest >> testCreateGameWithLaps [
	| game playerNamedLeo playerNamedGlenn die board collection lapsAmount deck overload |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			overload.
			overload.
			overload.
			overload.
			overload}.
	collection := {1 . 2 . 3 . 4 . 5}.
	die := Die withSides: 4 andGenerator: (CircularIterator over: collection).
	board := UtilitiesForTests collectionOf20NoEffect.
	lapsAmount := 3.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			die}
		using: deck
		in: board
		andAmountOfLaps: lapsAmount.
	self assert: game laps equals: 3
]

{ #category : #'turn tests' }
GameTest >> testCreateGameWithTurnOrder [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForTurnOrderLike: playerNamedLeo and: playerNamedGlenn.
	self
		assert: game turnOrder
		equals:
			{playerNamedLeo.
			playerNamedGlenn}
]

{ #category : #'test laps' }
GameTest >> testGameWithLapsHasEnded [
	| game playerNamedLeo |
	playerNamedLeo := Player named: 'Leo'.
	game := self gameWith5NoEffectBoard3LapsAndWithPlayer: playerNamedLeo.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 2.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 3.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self
		should: [ playerNamedLeo takesATurnIn: game ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game is over...' ].
	self assert: (game lapFor: playerNamedLeo) equals: 3.
	self assert: (game positionFor: playerNamedLeo) equals: 1
]

{ #category : #'test results' }
GameTest >> testGiveResultUsingAnotherCircularIterator [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameForResultsAnotherIteratorWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		and: playerNamedAlbert.
	"1st round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"1st round end."
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	"2nd round start:"
	playerNamedLeo takesATurnIn: game.
	self
		should: [ playerNamedAlbert takesATurnIn: game ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game is over...' ].
	self
		should: [ playerNamedGlenn takesATurnIn: game ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game is over...' ].
	"2nd round end."
	"results:"
	self assert: (game positionFor: playerNamedLeo) equals: 16.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'test results' }
GameTest >> testGiveResultUsingCircularIterator [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameForResultsIteratorWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		and: playerNamedAlbert.
	"1st round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"1st round end."
	"2nd round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"2nd round end."
	"results:"
	self assert: (game positionFor: playerNamedLeo) equals: 19.
	self assert: (game positionFor: playerNamedAlbert) equals: 25.
	self assert: (game positionFor: playerNamedGlenn) equals: 50
]

{ #category : #'cards tests' }
GameTest >> testGivesTwoCardsAtStartToEachPlayer [
	| playerNamedLeo playerNamedGlenn game |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	self assert: playerNamedLeo quantityOfCardsInHand equals: 2.
	self assert: playerNamedGlenn quantityOfCardsInHand equals: 2
]

{ #category : #'turn tests' }
GameTest >> testIquiryForWinnerRaisesExceptionWhenGameHasntFinished [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameWithPlayer: playerNamedGlenn and: playerNamedLeo and: playerNamedAlbert.
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	self assert: game hasFinished equals: false.
	self should: [ game winner ] raise: AssertionFailure withExceptionDo: [ :signal | self assert: signal messageText equals: 'There hasn''t been a winner yet...' ]
]

{ #category : #'test laps' }
GameTest >> testLapForPlayer [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameForLapsWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		and: playerNamedAlbert.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 2.
	self assert: (game lapFor: playerNamedAlbert) equals: 1.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	playerNamedLeo takesATurnIn: game.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 3.
	self assert: (game lapFor: playerNamedAlbert) equals: 2
]

{ #category : #'cards tests' }
GameTest >> testPlayerAbleToUseCancellationCardInOtherPlayersTurn [
	| overloadCard cancellationCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	cancellationCard := CancellationCard new.
	overloadCard := OverloadCard new.
	playerNamedLeo addCard: overloadCard.
	playerNamedLeo uses: overloadCard in: game against: playerNamedGlenn.
	playerNamedGlenn addCard: cancellationCard.
	playerNamedGlenn uses: cancellationCard in: game against: overloadCard.
	self assert: (playerNamedGlenn hasCard: cancellationCard) equals: false
]

{ #category : #'cards tests' }
GameTest >> testPlayerAbleToUseRepeatCardInOtherPlayersTurn [
	| repeatCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	repeatCard := RepeatCard new.
	playerNamedGlenn addCard: repeatCard.
	playerNamedGlenn uses: repeatCard in: game against: playerNamedGlenn.
	self assert: (playerNamedGlenn hasCard: repeatCard) equals: false
]

{ #category : #'test laps' }
GameTest >> testPositionForWithLaps [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameForPositionForWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		and: playerNamedAlbert.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 16.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 4.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 7.
	playerNamedAlbert takesATurnIn: game.
	self assert: (game positionFor: playerNamedAlbert) equals: 11
]

{ #category : #'test return' }
GameTest >> testReturnLengthOfBoard [
	| board game |
	board := {NoEffect new.
	WormholeEffect new.
	SpeedUpEffect new.
	AtomicEffect new.
	(MoonWalkEffect withSteps: 1)}.
	game := self gameForReturnLenghtOf: board.
	self assert: game boardLength equals: board size
]

{ #category : #'test return' }
GameTest >> testReturnRanking [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForResultsAnotherIteratorWithPlayer: playerNamedLeo and: playerNamedGlenn and: playerNamedAlbert.
	"1st round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"1st round end."
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	self
		assert: game ranking
		hasTheSameOrderThan:
			{playerNamedGlenn.
			playerNamedAlbert.
			playerNamedLeo}.
	"2nd round start:"
	playerNamedLeo takesATurnIn: game.
	"2nd round end."
	"results:"
	self assert: (game positionFor: playerNamedLeo) equals: 16.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'test return' }
GameTest >> testReturnWinner [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForResultsAnotherIteratorWithPlayer: playerNamedLeo and: playerNamedGlenn and: playerNamedAlbert.
	"1st round start:"
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	"1st round end."
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	self
		assert: game ranking
		hasTheSameOrderThan:
			{playerNamedGlenn.
			playerNamedAlbert.
			playerNamedLeo}.
	"2nd round start:"
	playerNamedLeo takesATurnIn: game.
	"2nd round end."
	"results:"
	self assert: (game positionFor: playerNamedLeo) equals: 16.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10.
	"Winner:"
	self assert: game winner equals: playerNamedLeo
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurn [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameWithPlayer: playerNamedGlenn
		and: playerNamedLeo
		and: playerNamedAlbert.
	playerNamedLeo takesATurnIn: game.
	playerNamedAlbert takesATurnIn: game.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithAtomicEffect [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameUsingAnAtomicEffectWithPlayer: playerNamedLeo
		and: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 2.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 2.
	self assert: (game lapFor: playerNamedGlenn) equals: 0.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self assert: (game lapFor: playerNamedGlenn) equals: 0
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithAtomicEffectOnLapNumber1 [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameUsingAnotherAtomicEffectWithPlayer: playerNamedLeo
		and: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 2.
	self assert: (game lapFor: playerNamedLeo) equals: 1.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 2.
	self assert: (game lapFor: playerNamedGlenn) equals: 1.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	self assert: (game lapFor: playerNamedGlenn) equals: 1
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithCorrectOrderOfPlayers [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameWithPlayer: playerNamedGlenn and: playerNamedLeo and: playerNamedAlbert.
	self assert: game currentPlayerTurn equals: playerNamedLeo.
	playerNamedLeo takesATurnIn: game.
	self assert: game currentPlayerTurn equals: playerNamedAlbert.
	playerNamedAlbert takesATurnIn: game.
	self assert: game currentPlayerTurn equals: playerNamedGlenn.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithMoonWalkEffect [
	| game playerNamedLeo playerNamedGlenn moonwalk |
	
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	moonwalk := MoonWalkEffect withSteps: 2.
	game := self gameWithPlayer: playerNamedLeo and: playerNamedGlenn usingEffect: moonwalk.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 2.	"Leo was in position 1 (NoEffect), die rolled 1, goes to position 2 but there's a MoonWalk (with 2 steps)"
	self assert: (game lapFor: playerNamedLeo) equals: 0.
	self assert: (game positionFor: playerNamedGlenn) equals: 4. "everyone else (Glenn) goes 2 positions backwards, they end in position 4 on lap -1."
	self assert: (game lapFor: playerNamedGlenn) equals: -1

]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithSpeedUpEffect [
	| game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		usingEffect: SpeedUpEffect new.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game lapFor: playerNamedLeo) equals: 1
	"was in position 1 (NoEffect), die rolled 1, goes to position 2 but there's a SpeedUp, goes 4 positions forward, ends in position 1 on lap 1."
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithWormholeEffect [
	|  game playerNamedLeo playerNamedGlenn  |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self
		gameWithPlayer: playerNamedLeo
		and: playerNamedGlenn
		usingEffect: WormholeEffect new.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 3.
	self assert: (game lapFor: playerNamedLeo) equals: -1
	"was in position 1 (NoEffect), die rolled 1, goes to position 2 but there's a Wormhole, goes back 4 positions, ends in position 3 on lap -1."
]

{ #category : #'turn tests' }
GameTest >> testSimulateTurnWithWrongOrderOfPlayersRaisesException [
	| game playerNamedLeo playerNamedAlbert playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedAlbert := Player named: 'Albert'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameWithPlayer: playerNamedGlenn and: playerNamedLeo and: playerNamedAlbert.
	self assert: game currentPlayerTurn equals: playerNamedLeo.
	playerNamedLeo takesATurnIn: game.
	self assert: game currentPlayerTurn equals: playerNamedAlbert.
	self
		should: [ playerNamedGlenn takesATurnIn: game ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ].
	playerNamedAlbert takesATurnIn: game.
	self assert: game currentPlayerTurn equals: playerNamedGlenn.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 4.
	self assert: (game positionFor: playerNamedAlbert) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 10
]

{ #category : #'cards tests' }
GameTest >> testUsingAccelerationCardRaisesExceptionWhenNotInPlayerTurn [
	| accelerationCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	accelerationCard := AccelerationCard new.
	playerNamedGlenn addCard: accelerationCard.
	self
		should: [ playerNamedGlenn uses: accelerationCard in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ]
]

{ #category : #'cards tests' }
GameTest >> testUsingOverloadCardRaisesExceptionWhenNotInPlayerTurn [
	| overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	overloadCard := OverloadCard new.
	playerNamedGlenn addCard: overloadCard.
	self
		should: [ playerNamedGlenn uses: overloadCard in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ]
]

{ #category : #'cards tests' }
GameTest >> testUsingRedoCardRaisesExceptionWhenNotInPlayerTurn [
	| redoCard overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	overloadCard := OverloadCard new.
	redoCard := RedoCard new.
	playerNamedLeo addCard: overloadCard.
	playerNamedGlenn addCard: redoCard.
	playerNamedLeo uses: overloadCard in: game against: playerNamedGlenn.
	self
		should: [ playerNamedGlenn uses: redoCard in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ]
]

{ #category : #'cards tests' }
GameTest >> testUsingSpeedCardRaisesExceptionWhenNotInPlayerTurn [
	| speedCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn.
	speedCard := SpeedCard new.
	playerNamedGlenn addCard: speedCard.
	self
		should: [ playerNamedGlenn uses: speedCard in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ]
]

{ #category : #'cards tests' }
GameTest >> testWithCardAndGiveRanking [
	| playerNamedLeo playerNamedGlenn game deck overload speed acceleration cancellation |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	overload := OverloadCard new.
	speed := SpeedCard new.
	acceleration := AccelerationCard new.
	cancellation := CancellationCard new.
	overload := OverloadCard new.
	deck := DeckManager
		containing:
			{overload.
			speed.
			acceleration.
			cancellation}.
	game := self gameUsingCardsWithFirstPlayer: playerNamedLeo andSecondPlayer: playerNamedGlenn WithDeck: deck.
	self assert: playerNamedLeo quantityOfCardsInHand equals: 2.
	self assert: playerNamedGlenn quantityOfCardsInHand equals: 2.
	"First round"
	self assert: (game positionFor: playerNamedLeo) equals: 1.
	self assert: (game positionFor: playerNamedGlenn) equals: 1.
	playerNamedLeo uses: overload in: game against: playerNamedGlenn.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 2.
	playerNamedGlenn uses: acceleration in: game against: playerNamedLeo.
	playerNamedGlenn takesATurnIn: game.
	"Second round"
	self assert: (game positionFor: playerNamedLeo) equals: 2.
	self assert: (game positionFor: playerNamedGlenn) equals: 2.
	playerNamedLeo uses: speed in: game against: playerNamedLeo.
	playerNamedGlenn uses: cancellation in: game against: overload.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 7.
	playerNamedGlenn takesATurnIn: game.
	"Third round"
	self assert: (game positionFor: playerNamedLeo) equals: 7.
	self assert: (game positionFor: playerNamedGlenn) equals: 7.
	playerNamedLeo takesATurnIn: game.
	self assert: (game positionFor: playerNamedLeo) equals: 14.
	playerNamedGlenn takesATurnIn: game.
	self assert: (game positionFor: playerNamedGlenn) equals: 8.
	self
		assert: game ranking
		hasTheSameOrderThan:
			{playerNamedGlenn.
			playerNamedLeo}
]
