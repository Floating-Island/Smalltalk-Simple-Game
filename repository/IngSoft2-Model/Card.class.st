Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
Card >> activateOn: aGame to: aPlayerCollection [ 
 ^self subclassResponsibility 
]

{ #category : #interaction }
Card >> applyOn: aGame to: aCollection [ 
	 ^ self subclassResponsibility 
]

{ #category : #validation }
Card >> assertCanBePlayedIn: aGame by: aPlayer [
	 ^ self subclassResponsibility 
]
