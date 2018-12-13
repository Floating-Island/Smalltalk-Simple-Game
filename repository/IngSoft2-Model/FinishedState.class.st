Class {
	#name : #FinishedState,
	#superclass : #GameState,
	#instVars : [
		'winner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FinishedState class >> winner: aPlayer [
	^ self new initializeWithWinner: aPlayer
]

{ #category : #interaction }
FinishedState >> hasFinished [
	^ true
]

{ #category : #initialization }
FinishedState >> initializeWithWinner: aPlayer [
	winner := aPlayer
]

{ #category : #interaction }
FinishedState >> playNextTurnIn: aGame playedBy: aPlayer [
	^ AssertionFailure new signal: 'The game is over...'
]

{ #category : #accessing }
FinishedState >> winner [
	^ winner
]
