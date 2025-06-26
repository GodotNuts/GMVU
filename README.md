### Copyright (c) 2025-present Diurnal Productions, LLC

# GMVU
A DSL for GDScript mimicking SwiftUI and other model-view-update-style languages

# Steps to Use
1. Create a new generator file by creating a new script and making it extend FluentGenerator.
2. At the top of that script, ensure you add the @tool annotation.
3. In your script, override the view() and export_path() functions.
4. In view(), make sure to return your entire view hierarchy.
5. In export_path(), make sure to return the path to the file, including the file name, but excluding the .tscn value. It will add that automatically. See the example for more.

# Some Vital Notes
### In order to run the example, navigate to the example_generator_main_menu.gd file in the script editor and go to the File menu, then tap on Run near the bottom.

### In order to actually generate a file, you have to go to the script in which you've created the generator and run it, with one caveat being if you have a higher-level node that generates lower-level nodes and scripts through embedding, you only have to run the top-level node generator. There are shortcuts to do so, but you can also do so from the File menu in the Script Editor, where it will also show you the shortcut.

### When you add callables, variables, constants, unique_variables, exported variables, or onready variables to your script, it will forcibly overwrite the script that already exists, so be wary.

### When using this, be careful about directly using the exact scenes that are generated. It is better to generate the scenes in a separate folder, and then move them to where you want. The reason for that is that it *will* blow them away and rewrite them. If you're just iterating quickly, that's generally fine, but if you have stuff like a script and signal connections created or edits to the scenes directly, all those will be lost, if you've kept them all in the same folder after generation and not updated their names or anything.

### I recommend "tearing away" the Script Editor when working with this plugin. In order to do so, there's a button in the top right of the Script Editor that looks sorta like a window on top of another window - click that button. When you do so, the Script Editor will pop out, and you can put the Scene Tree Editor and 2D view to the left of the current script, have the file that the script generates open, and just run the script; it will automatically update the view whenever you do so.

### If you're going to apply your own scripts with the script_path() modifier, it is best to handle connections to signals directly in your _ready() function, if you have not added any other script changes in the generator. That way, when the generator blows away your view, it will retain those connections; otherwise, anything connected in the editor will simply be erased, and you'll have to do them all over again.

### When using this addon, if you make changes to a script via the generator interface, you *must* delete the associated generated script file(s) in order to see the changes. I'm working on a fix for this, but have not yet figured it out.


# Testing
I'm still testing this library out! I've recently added the following, for which I do not have tests (if these aren't useful, please let me know in Issues):
1. StyleBoxes - helpers exist to create all types and manipulate them
2. Textures - helpers exist to create texture2Ds, but are always the same type with the same settings

# Future
I'm considering the following features, and am intending to try to implement them. Let me know how valuable they would be to you, if at all, in Issues.
1. More, different Control nodes and support for them
2. More, different types of Textures if they would be useful to people
3. More, different types of resources generally
4. Fix for generated script files needing to be blown away before re-generating them; seems the script editor is caching the files, and I need to blow away that cache?

# History
Jun. 15, 2025 - Added ability to add custom animations to your UI controls through tweens created with .animation() modifier, see example for more
              - Added ability to just add functions from generator scripts directly to your generated scripts
Jun. 13, 2025 - Added raw_code() modifier which allows you to reference raw code from the destination script when generating a script
              - Added ability to fully embed generators, including any scripts they generate
              - Added ability to more or less fully generate any scripts you wish through modifiers to the node
Jun. 11, 2025 - Added CustomResources for Textures and StyleBoxes and derived resource types, Spacer top-level function to create spacers in your layouts easily, CustomArray, for_each top-level and child-level modifier, embedding generators, Controls, or CustomControls, more tests
Jun. 8, 2025  - Initial creation of fluent_generator.gd and MVU-style syntax
