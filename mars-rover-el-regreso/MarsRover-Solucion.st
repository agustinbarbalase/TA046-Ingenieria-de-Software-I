!classDefinition: #TestMarsRover category: #'MarsRover-Solucion'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:42:57'!
test01MarsRoverDoestNotMoveWhenNoCommandsAreSent

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: '' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:05'!
test02RoverFacingNorthCanMoveForward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'f' endsAt: 0@1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:13'!
test03RoverFacingNorthCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'b' endsAt: 0@-1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:24'!
test04RoverFacingNorthHeadsEastAfterTurningRight

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'r' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:55'!
test05RoverFacingNorthHeadsWestAfterTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'l' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:26'!
test06RoverFacingEastHeadsSouthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'r' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:43'!
test07RoverFacingSouthHeadsWestWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'r' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:00'!
test08RoverFacingWestHeadsNorthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'r' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:20'!
test09RoverFacingEastHeadsNorthWhenTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'l' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:52'!
test10RoverFacingSouthHeadsEastWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'l' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:46:17'!
test11RoverFacingWestHeadsSouthWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'l' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:36'!
test12RoverFacingEastCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'f' endsAt: 1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:55'!
test13RoverFacingEastCanMoveBackwards

	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'b' endsAt: -1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:20'!
test14RoverFacingSouthCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'f' endsAt: 0@-1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:38'!
test15RoverFacingSouthCanMoveBackward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'b' endsAt: 0@1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:10'!
test16RoverFacingWestCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'f' endsAt: -1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:46'!
test17RoverFacingWestCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'b' endsAt: 1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:50:56'!
test18RoverCanProcessMultipleCommands

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'ff' endsAt: 0@2 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 6/30/2021 16:05:43'!
test19RoverStopsWhenProcessingAnInvalidCommand

	| marsRover |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	
	self should: [ marsRover processCommands: 'fxf' ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: marsRover invalidCommandErrorMessage.
			self assert: (marsRover isAt: 0@1 heading: #North).
		].
	
	! !


!TestMarsRover methodsFor: 'assertions' stamp: 'LL 7/1/2021 00:42:36'!
assertRoverStartingAt: aPosition heading: aCardinalPoint afterProcessing: aStringOfCommands endsAt: aFinalPosition heading: aFinalCardinalPoint

	| marsRover |
	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	
	marsRover processCommands: aStringOfCommands.
	
	self assert: (marsRover isAt: aFinalPosition heading: aFinalCardinalPoint)! !


!classDefinition: #TestMarsRoverLogger category: #'MarsRover-Solucion'!
TestCase subclass: #TestMarsRoverLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 12:28:20'!
test01MarsRoverLoggerLogsNothingWhenMarsRoverDoesNothing

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForPosition: positionLogger.
	
	self assert: (positionLogger logs) equals: OrderedCollection new.! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 11:50:08'!
test02MarsRoverLoggerLogsPositionWhenMarsRoverGoesFordward

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForPosition: positionLogger.
	marsRover processCommands: 'f'.
	
	self assert: (positionLogger logs) equals: (OrderedCollection with: '0@1').! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 11:57:17'!
test03MarsRoverLoggerLogsPositionWhenMarsRoverGoesBackwards

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForPosition: positionLogger.
	marsRover processCommands: 'b'.
	
	self assert: (positionLogger logs) equals: (OrderedCollection with: '0@ -1').! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 11:57:56'!
test04MarsRoverLoggerLogsHeadingWhenMarsRoverRotatesEast

	| marsRover headLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	headLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForHead: headLogger.
	marsRover processCommands: 'r'.
	
	self assert: (headLogger logs) equals: (OrderedCollection with: 'East').! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 12:03:06'!
test04MarsRoverLoggerLogsHeadingWhenMarsRoverRotatesWest

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #East.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForHead: positionLogger.
	marsRover processCommands: 'r'.
	
	self assert: (positionLogger logs) equals: (OrderedCollection with: 'South').! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 12:04:11'!
test05MarsRoverLoggerLogsHeadingWhenMarsRoverRotatesToSouth

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #East.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForHead: positionLogger.
	marsRover processCommands: 'l'.
	
	self assert: (positionLogger logs) equals: (OrderedCollection with: 'North').! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 12:05:36'!
test06MarsRoverLoggerLogsHeadingWhenMarsRoverRotatesToNorth

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #West.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForHead: positionLogger.
	marsRover processCommands: 'r'.
	
	self assert: (positionLogger logs) equals: (OrderedCollection with: 'North').! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 12:06:33'!
test07MarsRoverPositionLoggerLogsPositionsOnly

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForPosition: positionLogger.
	marsRover processCommands: 'frb'.
	
	self assert: (positionLogger logs) equals: (OrderedCollection with: '0@1' with: '-1@1').! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 12:07:15'!
test08MarsRoverHeadingLoggerLogsHeadingsOnly

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForHead: positionLogger.
	marsRover processCommands: 'frb'.
	
	self assert: (positionLogger logs) equals: (OrderedCollection with: 'East').! !

!TestMarsRoverLogger methodsFor: 'tests' stamp: 'AB 10/29/2024 12:07:42'!
test09MarsRoverSpyLoggerLogsAll

	| marsRover positionLogger |
	marsRover := MarsRover startingAt: 0@0 heading: #West.
	positionLogger := MarsRoverLogger new. 
	
	marsRover addSuscriberForHead: positionLogger.
	marsRover addSuscriberForPosition: positionLogger.
	marsRover processCommands: 'frb'.
	
	self assert: (positionLogger logs) equals: (OrderedCollection with: '-1@0' with: 'North' with: '-1@ -1').! !


!classDefinition: #TestMarsRoverWindowTracker category: #'MarsRover-Solucion'!
TestCase subclass: #TestMarsRoverWindowTracker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRoverWindowTracker methodsFor: 'tests' stamp: 'AB 10/29/2024 12:28:23'!
test01WindowsShowsNothingWhenMRRecentlyDeployed

	| marsRover windows |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	windows := MarsRoverWindowTracker new.
	
	self assert: (windows showCurrentStatus) equals: ''! !

!TestMarsRoverWindowTracker methodsFor: 'tests' stamp: 'AB 10/29/2024 12:31:16'!
test02WindowsShowsPositionWhenMRMoves

	| marsRover windows |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	windows := MarsRoverWindowTracker new.
	
	marsRover addSuscriberForPosition: windows.
	marsRover processCommands: 'f'.
	
	self assert: (windows showCurrentStatus) equals: '0@1'! !

!TestMarsRoverWindowTracker methodsFor: 'tests' stamp: 'AB 10/29/2024 12:30:22'!
test03WindowsShowsHeadingWhenMRRotatesEast

	| marsRover windows |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	windows := MarsRoverWindowTracker new.
	
	marsRover addSuscriberForHead: windows.
	marsRover processCommands: 'r'.
	
	self assert: (windows showCurrentStatus) equals: 'East'! !

!TestMarsRoverWindowTracker methodsFor: 'tests' stamp: 'AB 10/29/2024 12:30:43'!
test04WindowsShowsHeadingWhenMRRotatesWest

	| marsRover windows |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	windows := MarsRoverWindowTracker new.
	
	marsRover addSuscriberForHead: windows.
	marsRover processCommands: 'l'.
	
	self assert: (windows showCurrentStatus) equals: 'West'! !

!TestMarsRoverWindowTracker methodsFor: 'tests' stamp: 'AB 10/29/2024 12:30:28'!
test05WindowsShowsHeadingWhenMRRotatesSouth

	| marsRover windows |
	marsRover := MarsRover startingAt: 0@0 heading: #East.
	windows := MarsRoverWindowTracker new.
	
	marsRover addSuscriberForHead: windows.
	marsRover processCommands: 'r'.
	
	self assert: (windows showCurrentStatus) equals: 'South'.! !

!TestMarsRoverWindowTracker methodsFor: 'tests' stamp: 'AB 10/29/2024 12:31:22'!
test06WindowPositionTrackerShowsLastPositionOnly

	| marsRover windows |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	windows := MarsRoverWindowTracker new.
	
	marsRover addSuscriberForPosition: windows.
	marsRover processCommands: 'fbr'.
	
	self assert: (windows showCurrentStatus) equals: '0@0'! !

!TestMarsRoverWindowTracker methodsFor: 'tests' stamp: 'AB 10/29/2024 12:30:36'!
test07WindowHeadingTrackerShowsLastHeadingOnly

	| marsRover windows |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	windows := MarsRoverWindowTracker new.
	
	marsRover addSuscriberForHead: windows.
	marsRover processCommands: 'fbr'.
	
	self assert: (windows showCurrentStatus) equals: 'East'! !


!classDefinition: #MarsRover category: #'MarsRover-Solucion'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRover methodsFor: 'initialization' stamp: 'AB 10/29/2024 12:19:31'!
initializeStartingAt: aPosition heading: aCardinalPoint 
	
	| aHead |
	
	aHead := MarsRoverHead of: self facing: aCardinalPoint.
	position := MarsRoverValueProxy for: aPosition withNotificationBlock: [:aSuscriber :aValue | aSuscriber addPosition: aValue ].
	head := MarsRoverValueProxy for: aHead withNotificationBlock: [:aSuscriber :aValue | aSuscriber addHeading: aValue ].
	! !


!MarsRover methodsFor: 'process commands' stamp: 'LL 6/30/2021 15:54:14'!
processCommands: aStringWithCommands

	aStringWithCommands do: [ :aCommand | 
		self assertCommandIsValid: aCommand.
		self processCommand: aCommand.
	].
	
! !


!MarsRover methodsFor: 'testing' stamp: 'AB 10/29/2024 12:15:28'!
isAt: aPosition heading: aCardinalPoint

	^ position = aPosition and: [ head isHeading: aCardinalPoint ]! !


!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:54:11'!
assertCommandIsValid: aCommand

	^ (self isInvalidCommand: aCommand) ifTrue: [ self error: self invalidCommandErrorMessage ]! !

!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:48:06'!
invalidCommandErrorMessage

	^'Invalid command'! !

!MarsRover methodsFor: 'private - process commands' stamp: 'AB 10/29/2024 11:47:58'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ head value movingForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ head value movingBackwards ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ head value rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ head value rotateLeft ].
! !


!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:42'!
isBackwardCommand: command

	^ command = $b! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:27'!
isForwardCommand: command

	^ command = $f! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:51:21'!
isInvalidCommand: aCommand
	^(self isForwardCommand: aCommand) not and: 
		[ (self isBackwardCommand: aCommand) not and: 
			[ (self isRotateRightCommand: aCommand) not and: 
				[ (self isRotateLeftCommand: aCommand) not ] ] ]! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:50:53'!
isRotateLeftCommand: command

	^ command = $l! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:27:33'!
isRotateRightCommand: command

	^ command = $r! !


!MarsRover methodsFor: 'dd - moving' stamp: 'AB 10/29/2024 11:37:15'!
moveDown

	self step: (0@-1).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'AB 10/29/2024 11:37:01'!
moveLeft

	self step: (-1@0).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'AB 10/29/2024 11:36:41'!
moveRight

	self step: (1@0).

! !

!MarsRover methodsFor: 'dd - moving' stamp: 'AB 10/29/2024 11:36:45'!
moveUp

	self step: (0@1).
! !

!MarsRover methodsFor: 'dd - moving' stamp: 'AB 10/29/2024 12:18:44'!
step: aStep
	
	position modifyValue: (position + aStep).! !


!MarsRover methodsFor: 'dd - heading' stamp: 'AB 10/29/2024 12:33:02'!
headEast

	self headTo: (MarsRoverHeadFacingEast of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'AB 10/29/2024 12:33:02'!
headNorth

	self headTo: (MarsRoverHeadFacingNorth of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'AB 10/29/2024 12:33:02'!
headSouth

	self headTo: (MarsRoverHeadFacingSouth of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'AB 10/29/2024 12:33:02'!
headTo: aHead

	head modifyValue: aHead.! !

!MarsRover methodsFor: 'dd - heading' stamp: 'AB 10/29/2024 12:33:02'!
headWest

	self headTo: (MarsRoverHeadFacingWest of: self).! !


!MarsRover methodsFor: 'observer' stamp: 'AB 10/29/2024 11:26:23'!
addSuscriberForHead: aSuscriberForHead

	head addSuscriber: aSuscriberForHead.
	! !

!MarsRover methodsFor: 'observer' stamp: 'AB 10/29/2024 11:25:59'!
addSuscriberForPosition: aSuscriberForPosition

	position addSuscriber: aSuscriberForPosition.

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Solucion'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 13:30:13'!
startingAt: aPoint heading: aCardinalPoint 
	
	^self new initializeStartingAt: aPoint heading: aCardinalPoint ! !


!classDefinition: #MarsRoverHead category: #'MarsRover-Solucion'!
Object subclass: #MarsRoverHead
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'AB 10/29/2024 11:59:58'!
accept: aVisitor

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:17:57'!
initializeOf: aMarsRover

	marsRover := aMarsRover! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
isHeading: aCardinalPoint

	^self class whenFacing: aCardinalPoint

	! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:36:46'!
rotateLeft

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 16:36:43'!
rotateRight

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHead class' category: #'MarsRover-Solucion'!
MarsRoverHead class
	instanceVariableNames: ''!

!MarsRoverHead class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	self subclassResponsibility.! !


!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 16:16:27'!
of: aMarsRover

	^self new initializeOf: aMarsRover! !

!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 19:46:37'!
of: aMarsRover facing: aCardinalPoint
	
	| headingSubclass |
	headingSubclass := self subclasses detect: [ :aHeadingSubclass | aHeadingSubclass whenFacing: aCardinalPoint ].
	
	^headingSubclass of: aMarsRover.! !


!classDefinition: #MarsRoverHeadFacingEast category: #'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'AB 10/29/2024 12:00:17'!
accept: aVisitor

	aVisitor visitMarsRoverHeadFacingEast.! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveLeft.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveRight.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:22'!
rotateLeft

	^marsRover headNorth.

	! !

!MarsRoverHeadFacingEast methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:10:14'!
rotateRight

	^marsRover headSouth.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingEast class' category: #'MarsRover-Solucion'!
MarsRoverHeadFacingEast class
	instanceVariableNames: ''!

!MarsRoverHeadFacingEast class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #East! !


!classDefinition: #MarsRoverHeadFacingNorth category: #'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'AB 10/29/2024 12:00:32'!
accept: aVisitor

	aVisitor visitMarsRoverHeadFacingNorth.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveDown.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveUp.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:33'!
rotateLeft

	^marsRover headWest.! !

!MarsRoverHeadFacingNorth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:10:58'!
rotateRight

	^marsRover headEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingNorth class' category: #'MarsRover-Solucion'!
MarsRoverHeadFacingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingNorth class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #North! !


!classDefinition: #MarsRoverHeadFacingSouth category: #'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'AB 10/29/2024 12:00:41'!
accept: aVisitor

	aVisitor visitMarsRoverHeadFacingSouth.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveUp.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveDown! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:43'!
rotateLeft

	^marsRover headEast.! !

!MarsRoverHeadFacingSouth methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:12:30'!
rotateRight

	^marsRover headWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingSouth class' category: #'MarsRover-Solucion'!
MarsRoverHeadFacingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingSouth class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #South! !


!classDefinition: #MarsRoverHeadFacingWest category: #'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'AB 10/29/2024 12:00:49'!
accept: aVisitor

	aVisitor visitMarsRoverHeadFacingWest.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveRight.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveLeft.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:06:52'!
rotateLeft

	^marsRover headSouth.! !

!MarsRoverHeadFacingWest methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 17:12:44'!
rotateRight

	^marsRover headNorth.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingWest class' category: #'MarsRover-Solucion'!
MarsRoverHeadFacingWest class
	instanceVariableNames: ''!

!MarsRoverHeadFacingWest class methodsFor: 'as yet unclassified' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #West! !


!classDefinition: #MarsRoverObserver category: #'MarsRover-Solucion'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverObserver methodsFor: 'observer' stamp: 'AB 10/29/2024 11:40:58'!
addHeading: aHead

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'observer' stamp: 'AB 10/29/2024 11:41:03'!
addPosition: aPosition

	self subclassResponsibility! !


!MarsRoverObserver methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:23:31'!
visitMarsRoverHeadFacingEast

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:23:34'!
visitMarsRoverHeadFacingNorth

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:23:39'!
visitMarsRoverHeadFacingSouth

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:23:46'!
visitMarsRoverHeadFacingWest

	self subclassResponsibility! !


!classDefinition: #MarsRoverLogger category: #'MarsRover-Solucion'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'AB 10/29/2024 11:51:38'!
initialize 
	
	logs := OrderedCollection new.! !


!MarsRoverLogger methodsFor: 'accessing' stamp: 'AB 10/29/2024 12:31:58'!
logs
	
	^ logs copy ! !


!MarsRoverLogger methodsFor: 'observer' stamp: 'AB 10/29/2024 12:02:20'!
addHeading: aHeading

	aHeading accept: self.! !

!MarsRoverLogger methodsFor: 'observer' stamp: 'AB 10/29/2024 11:55:50'!
addPosition: aPosition

	logs add: (aPosition asString).! !


!MarsRoverLogger methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:02:31'!
visitMarsRoverHeadFacingEast
	
	logs add: 'East'! !

!MarsRoverLogger methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:04:24'!
visitMarsRoverHeadFacingNorth

	logs add: 'North'! !

!MarsRoverLogger methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:03:37'!
visitMarsRoverHeadFacingSouth

	logs add: 'South'! !

!MarsRoverLogger methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:23:59'!
visitMarsRoverHeadFacingWest

	logs add: 'West'! !


!classDefinition: #MarsRoverWindowTracker category: #'MarsRover-Solucion'!
MarsRoverObserver subclass: #MarsRoverWindowTracker
	instanceVariableNames: 'currentStatus'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverWindowTracker methodsFor: 'initialization' stamp: 'AB 10/29/2024 12:29:59'!
initialize

	currentStatus := ''.! !


!MarsRoverWindowTracker methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:30:55'!
visitMarsRoverHeadFacingEast

	currentStatus := 'East'.! !

!MarsRoverWindowTracker methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:31:01'!
visitMarsRoverHeadFacingNorth

	currentStatus := 'North'! !

!MarsRoverWindowTracker methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:31:05'!
visitMarsRoverHeadFacingSouth

	currentStatus := 'South'.! !

!MarsRoverWindowTracker methodsFor: 'visitor' stamp: 'AB 10/29/2024 12:31:09'!
visitMarsRoverHeadFacingWest

	currentStatus := 'West'! !


!MarsRoverWindowTracker methodsFor: 'logs' stamp: 'AB 10/29/2024 12:29:13'!
showCurrentStatus
	
	^currentStatus copy! !


!MarsRoverWindowTracker methodsFor: 'observer' stamp: 'AB 10/29/2024 12:10:20'!
addHeading: aHeading

	aHeading accept: self.! !

!MarsRoverWindowTracker methodsFor: 'observer' stamp: 'AB 10/29/2024 12:29:13'!
addPosition: aPosition

	currentStatus := (aPosition asString).! !


!classDefinition: #MarsRoverValueProxy category: #'MarsRover-Solucion'!
ProtoObject subclass: #MarsRoverValueProxy
	instanceVariableNames: 'value suscribers notificationBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverValueProxy methodsFor: 'initialization' stamp: 'AB 10/29/2024 11:19:27'!
initializeFor: aValue withNotificationBlock: aNotificationBlock
	
	value := aValue.
	suscribers := OrderedCollection new.
	notificationBlock := aNotificationBlock.! !


!MarsRoverValueProxy methodsFor: 'accessing' stamp: 'AB 10/29/2024 11:22:39'!
modifyValue: aValue
	
	value := aValue.
	self notifyAll.! !


!MarsRoverValueProxy methodsFor: 'observer' stamp: 'AB 10/29/2024 11:20:29'!
addSuscriber: aSuscriber

	suscribers add: aSuscriber.! !

!MarsRoverValueProxy methodsFor: 'observer' stamp: 'AB 10/29/2024 11:21:29'!
notifyAll

	suscribers do: [:aSuscriber | notificationBlock value: aSuscriber value: value].! !


!MarsRoverValueProxy methodsFor: 'system primitives' stamp: 'AB 10/29/2024 12:17:48'!
doesNotUnderstand: aMessage

	^aMessage sendTo: value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverValueProxy class' category: #'MarsRover-Solucion'!
MarsRoverValueProxy class
	instanceVariableNames: ''!

!MarsRoverValueProxy class methodsFor: 'as yet unclassified' stamp: 'AB 10/29/2024 11:18:50'!
for: aValue withNotificationBlock: aNotificationBlock
	
	^self new initializeFor: aValue withNotificationBlock: aNotificationBlock.! !
