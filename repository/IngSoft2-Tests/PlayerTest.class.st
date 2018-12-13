Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'utilities for tests' }
PlayerTest >> gameForPlayerTestsWithPlayer: aPlayer and: anotherPlayer [
	| die game collection board deck |
	collection := {4 . 2 . 3 . 4 . 5}.
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

{ #category : #'cards tests' }
PlayerTest >> testAssignCardsToPlayer [
	| player firstCard secondCard |
	player := Player named: 'Alber'.
	firstCard := OverloadCard new.
	secondCard := CancellationCard new.
	player addCard: firstCard.
	player addCard: secondCard.
	self assert: (player hasCard: firstCard) equals: true.
	self assert: (player hasCard: secondCard) equals: true
]

{ #category : #'cards tests' }
PlayerTest >> testCardRemovedAfterUsingBlankCard [
	| blankCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	blankCard := BlankCard new.
	playerNamedGlenn addCard: blankCard.
	playerNamedGlenn uses: blankCard in: game against: playerNamedLeo.
	self assert: (playerNamedGlenn hasCard: blankCard) equals: false
]

{ #category : #tests }
PlayerTest >> testCheckPlayerName [
	| player |
	player := Player named: 'Leo'.
	self assert: player name equals: 'Leo'
]

{ #category : #'cards tests' }
PlayerTest >> testCheckTurnBeforeUsingAccelerationCard [
	| accelerationCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	accelerationCard := AccelerationCard new.
	playerNamedGlenn addCard: accelerationCard.
	self
		should: [ playerNamedGlenn uses: accelerationCard in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ]
]

{ #category : #'cards tests' }
PlayerTest >> testCheckTurnBeforeUsingCancellationCard [
	| overloadCard cancellationCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	cancellationCard := CancellationCard new.
	overloadCard := OverloadCard new.
	playerNamedLeo addCard: overloadCard.
	playerNamedLeo uses: overloadCard in: game against: playerNamedGlenn.
	playerNamedGlenn addCard: cancellationCard.
	playerNamedGlenn uses: cancellationCard in: game against: overloadCard.
	self assert: (playerNamedGlenn hasCard: cancellationCard) equals: false
]

{ #category : #'cards tests' }
PlayerTest >> testCheckTurnBeforeUsingOverloadCard [
	| overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	overloadCard := OverloadCard new.
	playerNamedGlenn addCard: overloadCard.
	self
		should: [ playerNamedGlenn uses: overloadCard in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ]
]

{ #category : #'cards tests' }
PlayerTest >> testCheckTurnBeforeUsingRedoCard [
	| redoCard overloadCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
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
PlayerTest >> testCheckTurnBeforeUsingRepeatCard [
	| repeatCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	repeatCard := RepeatCard new.
	playerNamedGlenn addCard: repeatCard.
	playerNamedGlenn uses: repeatCard in: game against: playerNamedGlenn.
	self assert: (playerNamedGlenn hasCard: repeatCard) equals: false
]

{ #category : #'cards tests' }
PlayerTest >> testCheckTurnBeforeUsingSpeedCard [
	| speedCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	speedCard := SpeedCard new.
	playerNamedGlenn addCard: speedCard.
	self
		should: [ playerNamedGlenn uses: speedCard in: game against: playerNamedGlenn ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'This isn''t the turn of Glenn' ]
]

{ #category : #'cards tests' }
PlayerTest >> testDrawCardFromDeckHasCardInHand [
	| player deck card |
	player := Player named: 'Alber'.
	card := OverloadCard new.
	deck := CircularIterator over: {card}.
	player drawCardFrom: deck.
	self assert: (player hasCard: card) equals: true
]

{ #category : #tests }
PlayerTest >> testPlayerThrowADie [
	| player die |
	player := Player named: 'Leo'.
	die := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2}).
	self assert: (player throwDice: {die}) equals: 1.
	self assert: (player throwDice: {die}) equals: 2
]

{ #category : #tests }
PlayerTest >> testPlayerThrowDice [
	| player die die2 die3 |
	die := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	die2 := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	die3 := Die withSides: 5 andGenerator: (CircularIterator over: {1 . 2 . 3 . 4 . 5}).
	player := Player named: 'Leo'.
	self
		assert:
			(player
				throwDice:
					{die.
					die2.
					die3})
		equals: 3.
	self
		assert:
			(player
				throwDice:
					{die.
					die2.
					die3})
		equals: 6.
	self
		assert:
			(player
				throwDice:
					{die.
					die2.
					die3})
		equals: 9
]

{ #category : #'cards tests' }
PlayerTest >> testPlayerUseCard [
	| accelerationCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	accelerationCard := AccelerationCard new.
	playerNamedLeo addCard: accelerationCard.
	playerNamedLeo uses: accelerationCard in: game against: {playerNamedGlenn}.
	self assert: (playerNamedLeo hasCard: accelerationCard) equals: false
]

{ #category : #'cards tests' }
PlayerTest >> testRaisesExceptionWhenTryingToUseACardThatDoesntHave [
	| speedCard game playerNamedLeo playerNamedGlenn |
	playerNamedLeo := Player named: 'Leo'.
	playerNamedGlenn := Player named: 'Glenn'.
	game := self gameForPlayerTestsWithPlayer: playerNamedLeo and: playerNamedGlenn.
	speedCard := SpeedCard new.
	self
		should: [ playerNamedLeo uses: speedCard in: game against: playerNamedLeo ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Leo doesn''t have that card in hand.' ]
]
