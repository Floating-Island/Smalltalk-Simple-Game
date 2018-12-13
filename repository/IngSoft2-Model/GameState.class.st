Class {
	#name : #GameState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
GameState >> hasFinished [
	self subclassResponsibility
]

{ #category : #interaction }
GameState >> playNextTurnIn: aGame playedBy: aPlayer [
	self subclassResponsibility
]
