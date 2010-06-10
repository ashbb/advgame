Mini Project: Adventure Game
============================

This is a mini project for Ruby Programming Core Course at [RubyLearning.org](http://www.rubylearning.org/class/).

Objective
---------

To build a tiny adventure game. Adventure games are full of objects - everything from the locations ('Rooms') to the Treasures they contain. This project is thanks to Huw Collingbourne.


Milestone1
----------

The first task is to decide on the main classes which will define the objects in the game. Most game objects - whether they are Rooms, Treasures, Weapons or Monsters - must have at least two properties: a name and a description. Start by creating a base class, called Thing, from which more specialized classes will descend. Write the relevant methods so that the two attributes are accessible outside of the class.

Example usage of the Thing class:

	Thing.new('Satish', 'Ruby Evangelist')


Milestone2
----------

Let's move on to create some more specific descendant classes.

Step 1
------
The Room class is just a Thing but it adds on some 'exit' attributes. These attributes will be used to indicate which room, if any, is located at the North, South, West and East exits of the current room.

Example usage of the Room class:

	rooms = []
	rooms << Room.new("The Entrance", "a foot of tree", -1, -1, -1, 1)                          # room:0
	rooms << Room.new("Dragon's Lair", "a huge and glittering lair", -1, 5, 0, 2)               # room:1
	rooms << Room.new("Troll Cave", "a dank and gloomy cave", -1, -1, 1, -1)                    # room:2
	rooms << Room.new("Crystal Dome", "a vast dome of glass", -1, 7, -1, -1)                    # room:3
	rooms << Room.new("Boggy Field", "a dark cold pond", -1, -1, -1, 5)                         # room:4
	rooms << Room.new("Mirror Room", "a room made by mirror", 1, -1, 4, 6)                      # room:5
	rooms << Room.new("Witchy Forest", "a forest witches live in", -1, 8, 5, 7)                 # room:6
	rooms << Room.new("Colorful Desert", "a desert covered by seven-colored sand", 3, 9, 6, -1) # room:7
	rooms << Room.new("The Exit", "a small hole", 6, -1, -1, -1)                                # room:8
	rooms << Room.new("Treasure Room", "a fabulous golden chamber", 7, -1, -1, -1)              # room:9
	

The rooms are located in these positions -

	============== The Map ===============
	 room:0 -- room:1 -- room:2    room:3
	             |                   |
	 room:4 -- room:5 -- room:6 -- room:7
	                       |         |
	                     room:8    room:9
	======================================

Now the code statement:

	# the numbers indicate positions North, South, West, East
	Room.new("Dragon's Lair", "a huge and glittering lair", -1, 5, 0, 2)               # room:1

indicates that to the North of Room 1, there is no Room i.e. -1 in the code. To the South of Room 1, there is Room 5 i.e. 5 in the code. To the West of Room 1 is Room 0 i.e. 0 in the code and to the East of Room 1 is Room 2 i.e. 2 in the code.


Step 2
------
Any adventure game needs a map (a collection of Rooms). For the sake of simplicity, the Map class will simply be a class that contains an array of rooms. You could, of course, use the default Ruby Array class for this purpose. Or you could make the Map class a descendant of Array. Let us not use the plain Array class for the simple reason that you might want to add special behavior to the Map at a later date. Other reasons are:

1. We don't want our code to have access to the whole range of Array methods when we use a Map object and

2. We may decide to change the Map class in a later revision of the code (the Ruby 'Hash' class - a key/value 'dictionary' - could be used).

Example usage of the Map class:

	map = Map.new(rooms)


Step 3
------
The adventure game also needs a Player (to provide the first person perspective as you move through the game). We could create a special one-off class for the Player. However, we've decided that we may need more than one object with the ability to move through the game (maybe we'll make it multi-player or maybe we'll add some 'characters' who can move around through the game environment) which is why we've create a more generic class called Actor. This class has a position attribute to indicate which room it is in at any given moment.

Example usage of the Actor class:

	player = Actor.new("The Player", "You", 0)


Milestone 3
-----------

Two more classes round things off:

First
-----
A Game class which owns the Map.

Example usage of the Game class:

	game = Game.new(map, player)

Second
------
An Implementer class. The Implementer is, in effect, the software equivalent of you - the person who programmed the game. It stands above all other objects and can look down upon and manipulate the entire world of the game with a godlike omniscience. Another way to think of the Implementer is as a sort of chess-player moving pieces (the various objects) around on a board (the map). This means that only one special object, the Implementer, owns the game and needs to know where each object is (i.e. in which Room) and how to move it from one Room to another.

The Implementer starts by initializing the game, then, in response to commands to move the player (or, in principle, any other object of the Actor class) in a specific direction, it looks for an exit in the current Room (given by the player's position in the map - game.map[player.position]) and, if it is a positive number, it alters the player's position to the map index given by the new number, otherwise (if the number is -1) there is no exit in that direction and a reply is returned to say so.

- define six classes, Thing, Room, Map, Actor, Game, Implementer
- save your code to the file named adv_game.rb

Now, let us test this simple Adventure game by simulating user interaction.

	# test_snippet.rb
	STDOUT.sync = true
	require 'adv_game'
	
	player = Actor.new "Loogink", "Ruby Lover Creature", 0
	imp = Implementer.new player
	
	print "> "
	until (cmd = gets.chomp).empty?
	  puts imp.move_actor_to(player, cmd)
	  puts imp.look_at(player)
	  print "\n> "
	end


Sample Game Log
---------------

	>ruby test_snippet.rb
	> e
	Go East.
	Loogink moved to the room:1.
	Room name: Dragon's Lair
	Description: a huge and glittering lair
	Existed doors: South, West, East
	
	> e
	Go East.
	Loogink moved to the room:2.
	Room name: Troll Cave
	Description: a dank and gloomy cave
	Existed doors: West
	
	> e
	Go East.
	No exit. Loogink stayed in the room:2.
	Room name: Troll Cave
	Description: a dank and gloomy cave
	Existed doors: West
	
	> w
	Go West.
	Loogink moved to the room:1.
	Room name: Dragon's Lair
	Description: a huge and glittering lair
	Existed doors: South, West, East
	
	> s
	Go South.
	Loogink moved to the room:5.
	Room name: Mirror Room
	Description: a room made by mirror
	Existed doors: North, West, East
	
	> e
	Go East.
	Loogink moved to the room:6.
	Room name: Witchy Forest
	Description: a forest witches live in
	Existed doors: South, West, East
	
	> s
	Go South.
	Loogink moved to the room:8.
	Room name: The Exit
	Description: a small hole
	Existed doors: North
	
	> 
	>Exit code: 0


Have Fun
--------

Let's execute your `adv_game.rb` with Shoes!

- git clone git://github.com/ashbb/advgame.git
- cd advgame/lib
- replace adv_game.rb to your code
- run adv_on_shoes.rb with your Shoes


Game Scenario
-------------
You must travel through the old mine (from The Entrance to The Exit). 
You may issue the command n to move to the north. 
You may likewise move in other directions by issuing the commands e (east) or s (south) or w (west). 
You may also issue the command l to look at your current location. 
And g to get the Treasure Star.
The commands are not case sensitive. 
These are the only commands that the program will accept. 
The game ends after you get the Treasure Star and find your way to The Exit and issue the l command there.


Snapshots
---------

![advgame-snapshot1.png](http://github.com/ashbb/advgame/raw/master/imgs/advgame-snapshot1.png)

![advgame-snapshot2.png](http://github.com/ashbb/advgame/raw/master/imgs/advgame-snapshot2.png)

![advgame-snapshot3.png](http://github.com/ashbb/advgame/raw/master/imgs/advgame-snapshot3.png)


Note
----

You can download **Shoes** from [here](http://shoes.heroku.com/downloads).
