Class {
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'dice',
		'playersPosition',
		'state',
		'playersOrder',
		'laps',
		'board',
		'lastEffectPlayer',
		'lastPlayedCard',
		'permanentCardsAssociations'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Game class >> playedBy: aPlayerCollection throwing: aDice using: aDeck in: aBoard andAmountOfLaps: aLapAmount [ 
	^ self new
		initializePlayedBy: aPlayerCollection
		throwing: aDice
		using: aDeck
		in: aBoard
		andAmountOfLaps: aLapAmount 
]

{ #category : #interaction }
Game >> activatePermanentCards [
	permanentCardsAssociations
		associationsDo: [ :each | each key affect: each value in: self ]
]

{ #category : #updating }
Game >> addCard: aCard asociatedWith: aPlayerOrCollection [
	permanentCardsAssociations add: aCard -> aPlayerOrCollection
]

{ #category : #updating }
Game >> applyPositionEffectTo: aPlayer [ 
	(self effectInPositionOf: aPlayer) triggerOn: self afterMovementOf: aPlayer
]

{ #category : #accessing }
Game >> board [
	^ board
]

{ #category : #accessing }
Game >> boardLength [
	^ board size
]

{ #category : #accessing }
Game >> cards [
	^ permanentCardsAssociations keys asOrderedCollection
]

{ #category : #accessing }
Game >> currentPlayerTurn [
	^ playersOrder currentElement
]

{ #category : #interaction }
Game >> deal: aNumberOfCards toAllPlayersUsing: aDeck [
	self turnOrder do: [ :each | aNumberOfCards timesRepeat: [ each drawCardFrom: aDeck ] ]
]

{ #category : #accessing }
Game >> dice [
	^ dice
]

{ #category : #accessing }
Game >> effectInPositionOf: aPlayer [ 
	^board at: (self positionFor: aPlayer)
]

{ #category : #updating }
Game >> ends [
	state := FinishedState new.
]

{ #category : #initialization }
Game >> fillPlayersPositionUsing: aPlayerCollection [
	playersPosition := Dictionary new.
	aPlayerCollection do: [ :each | playersPosition at: each put: 1 ]
]

{ #category : #testing }
Game >> hasCard: aCard [
	^ permanentCardsAssociations includesKey: aCard
]

{ #category : #assertion }
Game >> hasPermanentCards [
	^(permanentCardsAssociations isNotEmpty)
]

{ #category : #initialization }
Game >> initializePlayedBy: aPlayerCollection throwing: aDice using: aDeck in: aBoard andAmountOfLaps: aLapAmount [
	board := aBoard.
	laps := aLapAmount.
	dice := aDice.
	self fillPlayersPositionUsing: aPlayerCollection.
	playersOrder := CircularIterator over: aPlayerCollection.
	permanentCardsAssociations := Dictionary new.
	lastEffectPlayer := NoEffect new -> self currentPlayerTurn.
	lastPlayedCard := BlankCard new.
	self deal: 2 toAllPlayersUsing: aDeck.
	state := RunningState new
]

{ #category : #accessing }
Game >> lapFor: aPlayer [
	^ (playersPosition at: aPlayer) // self boardLength
]

{ #category : #accessing }
Game >> laps [
	^ laps
]

{ #category : #interaction }
Game >> lastEffectAppliedToAPlayer [
	^ self lastEffectPlayer key 
]

{ #category : #accessing }
Game >> lastEffectPlayer [
	^lastEffectPlayer
]

{ #category : #accessing }
Game >> lastPlayedCard [
	^lastPlayedCard
]

{ #category : #interaction }
Game >> lastPlayerAffectedByAnEffect [
	^ self lastEffectPlayer value
]

{ #category : #updating }
Game >> nextPlayerTurn [
	playersOrder updateIteration
]

{ #category : #updating }
Game >> playTurn: aPlayer [ 
	state playNextTurnIn: self playedBy: aPlayer .
]

{ #category : #testing }
Game >> playedBy: aPlayer [
	| aNumberOfCells |
	self turnOf: aPlayer.
	aNumberOfCells := aPlayer throwDice: self dice.
	self updatePositionBy: aNumberOfCells ofThePlayer: aPlayer.
	self updateLastEffectPlayer: aPlayer.
	self activatePermanentCards.
	self applyPositionEffectTo: aPlayer.
	self nextPlayerTurn
]

{ #category : #accessing }
Game >> playersAffectedByCards [
	^ permanentCardsAssociations values asOrderedCollection
]

{ #category : #interaction }
Game >> playersPlaying [
	^ self positionOfPlayers keys
]

{ #category : #accessing }
Game >> positionFor: aPlayer [
	^ ((playersPosition at: aPlayer) % self boardLength = 0)
		ifTrue: [ self boardLength ]
		ifFalse: [ (playersPosition at: aPlayer) % self boardLength ]
]

{ #category : #accessing }
Game >> positionOfPlayers [
	^ playersPosition
]

{ #category : #interaction }
Game >> ranking [
	^(playersPosition associations asSortedCollection: [ :first :second | first value > second value ])
		collect: [ :assoc | assoc key ]
		
]

{ #category : #updating }
Game >> removeCard: aCard [
	(self hasCard: aCard)
		ifTrue: [ permanentCardsAssociations removeKey: aCard ]
]

{ #category : #assertion }
Game >> turnOf: player [
	^ player = playersOrder currentElement 
		ifFalse: [ AssertionFailure signal: ('This isn''t the turn of {1}' format: {player name}) ]
]

{ #category : #accessing }
Game >> turnOrder [
	^ playersOrder collection
]

{ #category : #updating }
Game >> updateLastEffectPlayer: aPlayer [ 
	lastEffectPlayer := (self effectInPositionOf: aPlayer)->(aPlayer)
]

{ #category : #updating }
Game >> updateLastPlayedCard: aCard [ 
	lastPlayedCard := aCard 
]

{ #category : #updating }
Game >> updatePositionBy: aNumberOfCells ofThePlayer: aPlayer [
	playersPosition at: aPlayer put: (playersPosition at: aPlayer) + aNumberOfCells.
	self validateFinalLapHasBeenReachedBy: aPlayer
]

{ #category : #updating }
Game >> validateFinalLapHasBeenReachedBy: aPlayer [
	(self lapFor: aPlayer) >=( laps)
		ifTrue: [ self ends ]
]
