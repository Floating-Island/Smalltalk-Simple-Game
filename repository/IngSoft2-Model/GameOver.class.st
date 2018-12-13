Class {
	#name : #GameOver,
	#superclass : #GameState,
	#instVars : [
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameOver class >> winner: aPlayer [
	^ self new initializeWithWinner: aPlayer
]

{ #category : #interaction }
GameOver >> hasFinished [
	^ true
]

{ #category : #initialization }
GameOver >> initializeWithWinner: aPlayer [
	winner := aPlayer
]

{ #category : #interaction }
GameOver >> playNextTurnIn: aGame playedBy: aPlayer [
	^ AssertionFailure new signal: 'The game is over...'
]

{ #category : #accessing }
GameOver >> winner [
	^ winner
]
