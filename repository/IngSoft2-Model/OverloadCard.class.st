Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
OverloadCard >> affect: aPlayer in: aGame [
	aPlayer = aGame currentPlayerTurn
		ifTrue: [ aGame updatePositionOf: aPlayer by: 2 negated ]
]

{ #category : #validation }
OverloadCard >> assertCanBePlayedIn: aGame by: aPlayer [
	aGame hasFinished
		ifTrue: [ AssertionFailure new signal: 'Can''t use card when game has finished' ].
	aGame turnOf: aPlayer
]

{ #category : #interaction }
OverloadCard >> playIn: aGame against: aPlayer [
	self validateIsPlayer: aPlayer.
	aGame updateLastPlayedCard: self.
	aGame addCard: self asociatedWith: aPlayer
]

{ #category : #interaction }
OverloadCard >> removedFromAHandIn: aGame [
	
]

{ #category : #validation }
OverloadCard >> validateIsPlayer: aPlayer [
	^ (aPlayer isMemberOf: Player)
		ifFalse: [ AssertionFailure new signal: 'Overload Card only applies to players' ]
]
