Class {
	#name : #RunningState,
	#superclass : #GameState,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
RunningState >> hasFinished [
	^ false
]

{ #category : #interaction }
RunningState >> playNextTurnIn: aGame playedBy: aPlayer [ 
	aGame playedBy: aPlayer.
]

{ #category : #interaction }
RunningState >> winner [
	^ AssertionFailure new signal: 'There hasn''t been a winner yet...'
]
