Class {
	#name : #DeckManagerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckManagerTest >> testAddToDiscardPileAddsItToDiscardPile [
	| deckManager cardCollection overload accelleration discarded |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	discarded := deckManager dealTopCard.
	self assert: discarded equals: overload.
	self assert: deckManager cardsLeftInDeck equals: 1.
	self assert: deckManager cardsInDiscardPile equals: 0.
	deckManager addToDiscardPile: discarded.
	self assert: deckManager cardsInDiscardPile equals: 1
]

{ #category : #tests }
DeckManagerTest >> testAddToDiscardPileRaisesExceptionWhenNotACard [
	| deckManager cardCollection overload accelleration discarded |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	discarded := 1.
	self
		should: [ deckManager addToDiscardPile: discarded ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Only cards are accepted in a DeckManager...' ].
	self assert: deckManager cardsInDiscardPile equals: 0
]

{ #category : #tests }
DeckManagerTest >> testCardsLeftGivesCardsInDeck [
	| deckManager cardCollection overload |
	overload := OverloadCard new.
	cardCollection := {overload} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: cardCollection size
]

{ #category : #tests }
DeckManagerTest >> testCreationWithObjectsOtherThanCardsRaisesException [
	| deckManager cardCollection |
	cardCollection := {1} asOrderedCollection.
	self
		should: [ deckManager := DeckManager containing: cardCollection ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Only cards are accepted in a DeckManager...' ]
]

{ #category : #tests }
DeckManagerTest >> testDealTopCardRemovesTopCardFromDeck [
	| deckManager cardCollection overload accelleration |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsLeftInDeck equals: 2.
	self assert: deckManager dealTopCard equals: overload.
	self assert: deckManager cardsLeftInDeck equals: 1.
	self assert: deckManager dealTopCard equals: accelleration.
]

{ #category : #tests }
DeckManagerTest >> testDealTopCardWhileDiscarPileEmptyRaisesException [
	| deckManager cardCollection overload accelleration |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	self assert: deckManager cardsInDiscardPile equals: 0.
	self assert: deckManager cardsLeftInDeck equals: 2.
	self
		should: [ deckManager dealTopCard ]
		raise: AssertionFailure
		withExceptionDo: [ :signal | self assert: signal messageText equals: 'Discard pile is empty...' ].
	deckManager addToDiscardPile: overload.
	deckManager dealTopCard.
	self assert: deckManager cardsLeftInDeck equals: 1
]

{ #category : #tests }
DeckManagerTest >> testRemovingAllCardsFromDeckMakesAllInDiscardPileTransferedToDeck [
	| deckManager cardCollection overload accelleration discardedOverload discardedAcceleration |
	overload := OverloadCard new.
	accelleration := AccelerationCard new.
	cardCollection := {overload.
	accelleration} asOrderedCollection.
	deckManager := DeckManager containing: cardCollection.
	deckManager addToDiscardPile: CancellationCard new.
	self assert: deckManager cardsInDiscardPile equals: 1.
	self assert: deckManager cardsLeftInDeck equals: 2.
	discardedOverload := deckManager dealTopCard.
	self assert: discardedOverload equals: overload.
	deckManager addToDiscardPile: discardedOverload.
	self assert: deckManager cardsLeftInDeck equals: 1.
	discardedAcceleration := deckManager dealTopCard.
	self assert: discardedAcceleration equals: accelleration.
	self assert: deckManager cardsLeftInDeck equals: 2.
	self assert: deckManager cardsInDiscardPile equals: 0.
	deckManager addToDiscardPile: discardedAcceleration.
	self assert: deckManager cardsInDiscardPile equals: 1
]
