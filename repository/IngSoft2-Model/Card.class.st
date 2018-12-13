Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #interaction }
Card >> affect: aPlayerOrCard in: aGame [ 
 ^self subclassResponsibility 
]

{ #category : #validation }
Card >> assertCanBePlayedIn: aGame by: aPlayer [
	 ^ self subclassResponsibility 
]

{ #category : #interaction }
Card >> playIn: aGame against: aPlayerOrCard [ 
	 ^ self subclassResponsibility 
]
