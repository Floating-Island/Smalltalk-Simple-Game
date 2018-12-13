Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
CancellationCard >> activateOn: aGame to: aCard [
	aGame removeCard: aCard
]

{ #category : #interaction }
CancellationCard >> applyOn: aGame to: aCard [
	self validateParameterIsACard: aCard.
	self validateGameHasCards: aGame.
	aGame updateLastPlayedCard: self.
	self activateOn: aGame to: aCard
]

{ #category : #validation }
CancellationCard >> assertCanBePlayedIn: aGame by: aPlayer [
	^ true
]

{ #category : #interaction }
CancellationCard >> validateGameHasCards: aGame [
	^ aGame hasPermanentCards
		ifFalse: [ AssertionFailure new signal: 'There are no permanent cards in the game' ]
]

{ #category : #validation }
CancellationCard >> validateParameterIsACard: aCard [
	^ (aCard isKindOf: Card)
		ifFalse: [ AssertionFailure new signal: 'Cancellation Card only applies to other cards' ]
]
