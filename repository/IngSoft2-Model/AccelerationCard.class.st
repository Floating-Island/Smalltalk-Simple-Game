Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
AccelerationCard >> activateOn: aGame to: aPlayerCollection [
	aGame updatePositionBy: 1 ofThePlayer: aGame currentPlayerTurn
]

{ #category : #interaction }
AccelerationCard >> applyOn: aGame to: aPlayer [
	aGame updateLastPlayedCard: self.
	aGame addCard: self asociatedWith: aGame playersPlaying
]

{ #category : #validation }
AccelerationCard >> assertCanBePlayedIn: aGame by: aPlayer [
	aGame turnOf: aPlayer
]
