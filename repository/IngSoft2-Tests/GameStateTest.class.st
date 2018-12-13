Class {
	#name : #GameStateTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'utilities for tests' }
GameStateTest >> gameForGameStateTestsWithPlayer: playerNamedLeo and: playerNamedGlenn [
	| die anotherDie game board deck |
	deck := CircularIterator over: {OverloadCard new}.
	die := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	anotherDie := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	board := UtilitiesForTests collectionOf20NoEffect.
	game := Game
		playedBy:
			{playerNamedLeo.
			playerNamedGlenn}
		throwing:
			{die.
			anotherDie}
		using: deck
		in: board
		andAmountOfLaps: 1.
	^ game
]

{ #category : #'finished state tests' }
GameStateTest >> testHasFinishedWhenFinished [
	| finishedState game playerNamedLeo playerNamedGlenn |
	finishedState := FinishedState new.
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForGameStateTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	self assert: finishedState hasFinished equals: true
]

{ #category : #'finished state tests' }
GameStateTest >> testHasFinishedWhenRunning [
	| runningState game playerNamedLeo playerNamedGlenn |
	runningState := RunningState new.
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForGameStateTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	self assert: runningState hasFinished equals: false
]

{ #category : #'finished state tests' }
GameStateTest >> testPlayersPositionWhenFinished [
	| finishedState game playerNamedLeo playerNamedGlenn |
	finishedState := FinishedState new.
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForGameStateTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	self
		should: [ finishedState playNextTurnIn: game playedBy: playerNamedLeo ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'The game is over...' ]
]

{ #category : #'running state tests' }
GameStateTest >> testPlayersPositionWhenRunning [
	| runningState game playerNamedLeo playerNamedGlenn |
	runningState := RunningState new.
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForGameStateTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	runningState playNextTurnIn: game playedBy: playerNamedLeo.
	runningState playNextTurnIn: game playedBy: playerNamedGlenn.
	self assert: (game positionFor: playerNamedLeo) equals: 3.
	self assert: (game positionFor: playerNamedGlenn) equals: 5
]
