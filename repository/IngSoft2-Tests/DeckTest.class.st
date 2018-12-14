Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckTest >> testDealingTopCardRemovesItFromDeck [
	| aDeck aCollection overload |
	overload := OverloadCard new.
	aCollection := {overload} asOrderedCollection.
	aDeck := Deck containing: aCollection.
	self assert: aDeck cardsLeft equals: 1.
	self assert: aDeck dealTopCard equals: overload.
	self assert: aDeck cardsLeft equals: 0
]
