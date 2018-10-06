Class {
	#name : #CircularIterator,
	#superclass : #Object,
	#instVars : [
		'currentIndex',
		'collection'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CircularIterator class >> over: anArray [ 
	^ self new initializeUsing: anArray.
]

{ #category : #initialization }
CircularIterator >> initializeUsing: aCollection [
	collection := aCollection.
	currentIndex := 0
]

{ #category : #accessing }
CircularIterator >> next: aSides [
	currentIndex = collection  size
		ifTrue: [ currentIndex := 0 ].
	currentIndex := currentIndex + 1.
	^ collection at: currentIndex
]