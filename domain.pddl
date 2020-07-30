;;Domain for cleaning floor tiles
;; A domain file for CMP2020M assignment 2018/2019

;; Assignment by
;; Callum Dyson-Gainsborough DYS17643101

;; Define the name for this domain (needs to match the domain definition
;;   in the problem files)

(define (domain floor-tile)

	;; We only require some typing to make this plan faster. We can do without!
	(:requirements :typing)

	;; We have two types: robots and the tiles, both are objects
	(:types robot tile - object)

	;; define all the predicates as they are used in the probem files
	(:predicates  

    ;; described what tile a robot is at
    (robot-at ?r - robot ?x - tile)

    ;; indicates that tile ?x is above tile ?y
    (up ?x - tile ?y - tile)

    ;; indicates that tile ?x is below tile ?y
    (down ?x - tile ?y - tile)

    ;; indicates that tile ?x is right of tile ?y
    (right ?x - tile ?y - tile)

    ;; indicates that tile ?x is left of tile ?y
    (left ?x - tile ?y - tile)
    
    ;; indicates that a tile is clear (robot can move there)
    (clear ?x - tile)

    ;; indicates that a tile is cleaned
    (cleaned ?x - tile)
 	)
	
  
;;Robot Clean Actions
;;The robot is required to clean, however it is only able to clean up and down 1 tile from itself. therefore I have split the cleaning into two separate actions, clean up and clean down. These are both very similar and the only difference is which direction they look and which tile they clean. These actions work by taking in the robot, current location and the target location, then using these parameters it needs to check that the target location is actually next to the robot (in the direction specified), then if this is true then it needs to make sure that it can clean the targeted tile ensuring it is both clear and hasn't been cleaned already. Then it can move onto the actions, simply cleaning the targeted tile.

;;Clean Above
 (:action clean-up
  :parameters (?r - robot ?y - tile ?x - tile);;Pass parameters (current robot, new location, current location)
  :precondition (and 
		(up ?y ?x);;Check that the tile is above the robot
		(robot-at ?r ?x);;Check that robot is currently at tile ?x
  		(clear ?y);;Check that tile ?y is clear so that the robot can move there
        (not(cleaned ?y));;Check that the tile hasn't been cleaned already
	)
  :effect (and 
		(cleaned ?y);;Clean the targeted tile (?y)
  )
 )

;;Clean Below
 (:action clean-down
  :parameters (?r - robot ?y - tile ?x - tile);;Pass parameters (current robot, new location, current location)
  :precondition (and 
		(down ?y ?x);;Check that the tile is below the robot
		(robot-at ?r ?x);;Check that robot is currently at tile ?x
  		(clear ?y);;Check that tile ?y is clear so that the robot can move there
        (not(cleaned ?y));;Check that the tile hasn't been cleaned already
	)
  :effect (and 
		(cleaned ?y);;Clean the targeted tile (?y)
  )
 )

;;Robot Move Actions
;;I have implemented the movement of the robot as 4 separate actions, up, down, left, and right. These are all very similar in how they work, the only difference being which direction the robot will move in. These work by taking in the robot, current location and the target location, then using these parameters it needs to check that the target location is actually next to the robot (in the direction specified), then if this is true then it needs to make sure that it can move to the targeted tile ensuring it is both clear and hasn't been cleaned. After this the robot is ready to move, firstly it needs to move itself, then it needs to ensure that the robot has moved, after this it needs to make sure to update which tiles are clear or not by marking the tile it was just on as clear and the current tile as not clear.

;;Move Up
 (:action up 
  :parameters (?r - robot ?y - tile ?x - tile);;Pass parameters (current robot, new location, current location)
  :precondition (and 
		(up ?y ?x);;Check that the tile is above the robot
		(robot-at ?r ?x);;Check that robot is currently at tile ?x
  		(clear ?y);;Check that tile ?y is clear so that the robot can move there
        (not(cleaned ?y));;Check that the tile hasn't been cleaned already
	)
  :effect (and 
		(robot-at ?r ?y);;Move the robot to targeted tile (?y)
		(not(robot-at ?r ?x));;Check that the robot has moved
		(clear ?x);;Update the tiles and mark previous position as clear
		(not(clear ?y));;Check that current position is marked as not clear
  )
 )

;;Move Down
 (:action down 
  :parameters (?r - robot ?y - tile ?x - tile);;Pass parameters (current robot, new location, current location)
  :precondition (and 
		(down ?y ?x);;Check that the tile is below the robot
		(robot-at ?r ?x);;Check that robot is currently at tile ?x
  		(clear ?y);;Check that tile ?y is clear so that the robot can move there
        (not(cleaned ?y));;Check that the tile hasn't been cleaned already
	)
  :effect (and 
		(robot-at ?r ?y);;Move the robot to targeted tile (?y)
		(not(robot-at ?r ?x));;Check that the robot has moved
		(clear ?x);;Update the tiles and mark previous position as clear
		(not(clear ?y));;Check that current position is marked as not clear
  )
 )

;;Move Right
 (:action right 
  :parameters (?r - robot ?y - tile ?x - tile);;Pass parameters (current robot, new location, current location)
  :precondition (and 
		(right ?y ?x);;Check that the tile is to the right side of the robot
		(robot-at ?r ?x);;Check that robot is currently at tile ?x
  		(clear ?y);;Check that tile ?y is clear so that the robot can move there
        (not(cleaned ?y));;Check that the tile hasn't been cleaned already
	)
  :effect (and 
		(robot-at ?r ?y);;Move the robot to targeted tile (?y)
		(not(robot-at ?r ?x));;Check that the robot has moved
		(clear ?x);;Update the tiles and mark previous position as clear
		(not(clear ?y));;Check that current position is marked as not clear
  )
 )

;;Move Left
 (:action left 
  :parameters (?r - robot ?y - tile ?x - tile);;Pass parameters (current robot, new location, current location)
  :precondition (and 
		(left ?y ?x);;Check that the tile is to the left side of the robot
		(robot-at ?r ?x);;Check that robot is currently at tile ?x
  		(clear ?y);;Check that tile ?y is clear so that the robot can move there
        (not(cleaned ?y));;Check that the tile hasn't been cleaned already
	)
  :effect (and 
		(robot-at ?r ?y);;Move the robot to targeted tile (?y)
		(not(robot-at ?r ?x));;Check that the robot has moved
		(clear ?x);;Update the tiles and mark previous position as clear
		(not(clear ?y));;Check that current position is marked as not clear
  )
 )

)

;;References
;;Helmert, M. (undated). An Introduction to PDDL. Available at: http://www.cs.toronto.edu/~sheila/2542/s14/A1/introtopddl2.pdf [Accessed 15 Apr. 2019].
;;Russell, S. and Norvig, P. (2016). Artificial intelligence: A Modern Approach. 3rd edition. Harlow: Pearson Education.