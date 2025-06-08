# Copyright (c) 2025-present Diurnal Productions, LLC

# GMVU
A DSL for GDScript mimicking SwiftUI and other model-view-update-style languages

# Steps to Use
1. Create a new generator file by creating a new script and making it extend FluentGenerator.
2. At the top of that script, ensure you add the @tool annotation.
3. In your script, override the view() and export_path() functions.
4. In view(), make sure to return your entire view hierarchy.
5. In export_path(), make sure to return the path to the file, including the file name, but excluding the .tscn value. It will add that automatically. See the example for more.

# Some Vital Notes
In order to actually generate a file, you have to go to the script you've created and run it. There are shortcuts to do so, but you can also do so from the File menu in the Script Editor, where it will also show you the shortcut.

When using this, be careful about setting your scenes to the exact scene that is generated. It is better to generate the scenes in a separate folder, and then move them to where you want. The reason for that is that it *will* blow them away and rewrite them. If you're just iterating quickly, that's generally fine, but if you have stuff like a script and signal connections created or edits to the scenes directly, all those will be lost, if you've kept them all in the same folder after generation and not updated their names or anything.

I recommend "tearing away" the Script Editor when working with this plugin. In order to do so, there's a button in the top right of the Script Editor that looks sorta like a window on top of another window - click that button. When you do so, the Script Editor will pop out, and you can put the Scene Tree Editor and 2D view to the left of the current script, have the file that the script generates open, and just run the script; it will automatically update the view whenever you do so.

If you're going to apply your own scripts with the script_path() modifier, it is best to handle connections to signals directly in your _ready() function. That way, when the generator blows away your view, it will retain those connections; otherwise, anything connected in the editor will simply be erased, and you'll have to do them all over again.

# Testing
I'm still testing this library out! I've recently added the following, for which I do not have tests (if these aren't useful, please let me know in Issues):
1. if_else - allows conditional branching of views based on the current context. Requires a callable that accepts the current CustomControl as the main argument that is passed into it. Let me know in Issues if you want this to be a top-level function as well.
2. for_each - allows iteration over a list of items. Requires a callable that accepts a value from the Array passed in, and the current CustomControl. Let me know in Issues if you want this to be a top-level function as well.

# Future
I'm considering the following features, and am intending to try to implement them. Let me know how valuable they would be to you, if at all, in Issues.
1. Script generation - currently, it supports pointing to a script. I'd like to allow it to generate scripts and useful stuff on them such as variables and functions.
2. Signals - In addition to the previous being allowed to generate signals, I'd like to be able to define signal connections within the view hierarchy. This might not be possible yet, or it might require a string value only for the name of the function to connect to - let me know in Issues if you have preferences on this.
3. More, different Control nodes and support for them
4. StyleBox and other resource creation simplification in a similar style to this library

# History
Jun. 8, 2025 - Initial creation of fluent_generator.gd and MVU-style syntax
