# Mystrust
![Alt text](readme/title.jpg?raw=true "Title")
![Alt text](readme/citizenSelector.jpg?raw=true "Citizen Selector")

Mystrust is a game of suspicion and making the best out of a bad situation. As the player, you will take on the role of an inquisitor of the Church in the land of Varangia. The people's hearts have been corrupted by a vile taint and are beginning to turn on one another. Worse still a few have even embraced the taint and work towards the vile, twisted goals of the one who commands it.

It is your job to oust the tainted individuals while sending the agents back for questioning. Needless to say, the innocent should remain completely unharmed.

#How To Build
Mystrust uses gradle to build the love file. For the sake of convenience, we make use of the Gradle Wrapper to make the build process easier. From within the main project folder, type:

./gradlew buildZip

This will produce the love file in the build/distributions folder:

build/distributions/mystrust.love

#How To Run The Game
To run the game, simply load it in the Love2d engine:

love build/distributions/mystrust.love

#Where are my save files?
Mystrust stores a number of save files to keep track of game state and user preferences. The exact location depends on the OS you are running and Love2D's configuration: https://love2d.org/wiki/love.filesystem

The files Mystrust saves are:
* save.dat: This is your save file. It holds the data for your player character and the town you are in.
* soundOptions.dat: This file holds the sound configuration options including volume levels.
* videoOptions.dat: This file holds the video configuration options including fullscreen mode and window size.
