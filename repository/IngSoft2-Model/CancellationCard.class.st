Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
CancellationCard >> affect: aCard in: aGame [
	aGame toDiscardPile: (aGame removeCard: aCard)
]

{ #category : #validation }
CancellationCard >> assertCanBePlayedIn: aGame by: aPlayer [
	aGame hasFinished
		ifTrue: [ AssertionFailure new signal: 'Can''t use card when game has finished' ]
]

{ #category : #interaction }
CancellationCard >> playIn: aGame against: aCard [
	self validateIsCard: aCard.
	self validateGameHasCards: aGame.
	aGame updateLastPlayedCard: self.
	self affect: aCard in: aGame
]

{ #category : #interaction }
CancellationCard >> validateGameHasCards: aGame [
	^ aGame hasPermanentCards
		ifFalse: [ AssertionFailure new signal: 'There are no permanent cards in the game' ]
]

{ #category : #validation }
CancellationCard >> validateIsCard: aCard [
	^ (aCard isKindOf: Card)
		ifFalse: [ AssertionFailure new signal: 'Cancellation Card only applies to other cards' ]
]
