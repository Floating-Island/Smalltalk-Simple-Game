Class {
	#name : #GameInCourse,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
GameInCourse >> hasFinished [
	^ false
]

{ #category : #interaction }
GameInCourse >> playNextTurnIn: aGame playedBy: aPlayer [ 
	aGame playedBy: aPlayer.
]

{ #category : #interaction }
GameInCourse >> winner [
	^ AssertionFailure new signal: 'There hasn''t been a winner yet...'
]
