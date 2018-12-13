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
