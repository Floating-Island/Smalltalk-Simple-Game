Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
AccelerationCard >> affect: aPlayerCollection in: aGame [
	aGame updatePositionBy: 1 ofThePlayer: aGame currentPlayerTurn
]

{ #category : #validation }
AccelerationCard >> assertCanBePlayedIn: aGame by: aPlayer [
	aGame turnOf: aPlayer
]

{ #category : #interaction }
AccelerationCard >> playIn: aGame against: aPlayer [
	aGame updateLastPlayedCard: self.
	aGame addCard: self asociatedWith: aGame playersPlaying
]
