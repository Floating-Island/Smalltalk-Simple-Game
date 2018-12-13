Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: aString [
	^ self new initializeNamed: aString
]

{ #category : #updating }
Player >> addCard: aCard [ 
	cards add: aCard 
]

{ #category : #accessing }
Player >> cardsInHand [
	^ cards
]

{ #category : #interaction }
Player >> drawCardFrom: aDeck [
	self addCard: (aDeck next: aDeck)
]

{ #category : #testing }
Player >> hasCard: aCard [ 
	^cards includes: aCard 
]

{ #category : #initialization }
Player >> initializeNamed: theirOwnName [
	name := theirOwnName.
	cards := {  } asOrderedCollection 
]

{ #category : #accessing }
Player >> name [
	^name 
]

{ #category : #interaction }
Player >> quantityOfCardsInHand [
	^ cards size
]

{ #category : #updating }
Player >> removeCard: aCard [ 
	cards remove: aCard
]

{ #category : #interaction }
Player >> takesATurnIn: aGame [
	aGame playTurn: self
]

{ #category : #interaction }
Player >> throwDice: aDice [
	^ aDice sumNumbers: [ :aDie | aDie roll ]
]

{ #category : #interaction }
Player >> uses: aCard on: aGame affecting: aPlayerOrCard [
	(self hasCard: aCard)
		ifTrue: [ aCard assertCanBePlayedIn: aGame by: self.
			aCard applyOn: aGame to: aPlayerOrCard.
			self removeCard: aCard ]
		ifFalse: [ AssertionFailure new
				signal: ('{1} doesn''t have that card in hand.' format: {self name}) ]
]
