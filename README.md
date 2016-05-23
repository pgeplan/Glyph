# Glyph #
![alt text](glyph.png)
## Authors ##
Paige Plander

## Purpose ##
Glyph is an Image-based communication app for non-verbal individuals. It serves  
as a app replacement for traditional picture card binders (PECS) [(see image)](http://i.ebayimg.com/images/i/251456122294-0-1/s-l1000.jpg)

## Features ##
*	Ability to add icons to the the “IconTiles” CollectionView. Each icon   
will have an image and a label. When the user presses an Icon, it will   
audibly read out the label that corresponds to it. This feature replaces  
the traditional picture card binders that many orally impaired or autistic  
individuals use. 
*	Ability to create custom keyboards that are based off of words rather  
than individual characters. That will enable the user to more easily  
type out sentences, if they are not comfortable with typing or able  
to type out full sentences using a standard keyboard. Once they  
complete typing out the sentence, they can press a “Speak” button  
that will audibly read out the sentence (if they are non-verbal,  
this automated voice will allow them to “speak” to others).  

## Control Flow ##
*   Users initially are presented with a log in screen, to access their 
saved icons
*	Once logged in, they will be directed the main “Tiles” page, which  
displays all of their icon images and corresponding labels.
*   At the bottom of the view, their will be a tab bar allowing them to  
switch instead to the  “Text Speech” mode.
*	At the top of the view, Users will be able to access the app’s settings  
and folders (for example, a user might have a different folder for “Food,”  
“Activities,” and “People.”
*	The Settings button will lead the user to a separate settings page. Here, the user  
can choose to do one of the following:
    *	**Add an Icon Tile** - Allows the user to add a new image icon
	*	**Add a Keyboard** - Allows the user to add a new word-based keyboard,  
    which can be accessed in the “Text-Speech” Mode
	*	**Add a New Folder / Remove Folder** 
	*	**Switch to Basic Mode** - If the user is not able to scroll on an iPhone  
	(my brother has not yet learned to do this), switching to basic mode will  
disable scrolling within the table view, and instead replace this feature with  
forward and back buttons.  
	*	**Log out** 

## Implementation ##
### Model ###
* **User.swift** Stores a dictionary for the corresponding user’s icons   
and keyboards.
* **UserDataModel.swift** — Stores an array of Users, saved with Core Data
* **IconTile.swift** — a class for Icon Tiles, which will store their images,  
icon names, and folder name
* **IconTilesDataModel.swift** —  Stores a dictionary of the icon tiles  
and their corresponding folders (maps FolderNames to Icon objects).
* **IconTileCollectionViewCell.swift** - since I am making custom Collection  
View cells, this class will store the extra properties needed for   
the “Tiles” page 
* **TextSpeechDataModel.swift** — stores the custom keyboards for  
the “Text-Speech” mode.

### View ###
* **TilesCollectionView** - Collection view that displays all of   
the tiles icons. If the user is in basic mode, there will  
be two buttons at the bottom of the screen allowing   
them to navigate through tiles (as an alternative to scrolling)
* **TextSpeechView** - view that displays the current keyboard and   
a text field.
* **AddIconTileView** - View for creating a new icon
* **AddKeyboardView** - View will have a text field for created the  
keyboard’s name, and another one for adding keyboard buttons. 
* **SettingsTableView** - the view for the settings page 
* **LoginView** - will have a UIPicker for choosing an already existing   
user, and a button for adding a new user.

### Controller ###
*   **IconTilesCollectionViewController.swift** — dynamic collection
view  
controller for the user's tile icons
*   **TextSpeechViewController.swift** — will provide the   
TextSpeechView with the appropriate keyboard data from the   
TextSpeechDataModel.
*   **SettingsTableViewController.swift** — implements the necessary  
table view delegate and data source methods for settings.
*   **LoginViewController.swift** — alerts the data model of which  
user was selected from the user picker.
*   **AddIconViewController.swift** — creates a new IconTile object   
using the inputed user data.
*   **AddKeyboardViewController.swift** — takes the inputted strings  
to create a new keyboard.
