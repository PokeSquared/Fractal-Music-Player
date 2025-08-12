# <img width="50" height="50" alt="logofractal" src="https://github.com/user-attachments/assets/b474f229-33d1-4fe4-b949-d2abbcbf4827" /> Fractal Music Player 

This is a simple music player I created in a few days using Godot. You can create your own albums and playlists, with custom pictures, background gradients, and songs. When downloaded, it comes with a "config.txt" file. This contains the data for albums.


**DISCLAIMER: I DO NOT OWN THE RIGHTS TO THE SONGS IN THE IMAGES, THESE ARE PURELY FOR SHOWING THE UI**
<details>
  <summary>Images of the Program</summary>
<img width="1141" height="636" alt="image" src="https://github.com/user-attachments/assets/180fa2df-f588-4929-932e-53ff383a16c0" />
<img width="1141" height="636" alt="image" src="https://github.com/user-attachments/assets/cc195180-295c-4107-8b33-67a0a502be1d" />
</details>

# Config.txt

Here is an example of a config.txt file, if not formatted like this problems can occur. Everything behind the "//" are comments.

```
?-? // The beginning of the file.
#0000FF // The accent color, # is not needed but it has to be hex. This is repsonsible for the color of the progress bar and volume bar.
----- // Album divider
Test Album // Album Name
#0000FF // Gradient color 1
#FF0000 // Gradient color 2, these make up the gradient in the background.
User\[username]\Albums\album1.png // Album Image (This path is fake.)
User\[username]\Albums\song1.mp3 // Song 1 (This path is fake.)
User\[username]\Albums\song2.mp3 // Song 2 (This path is fake.) , there can be a virtually infinite number of songs on an album.
----- // ending of file, if there was another album, this would be a divider, and the next album would look just like this.
```

The release of the program comes with a seperate program to add albums, however it can't modify existing ones, or modify the accent color. 

# Issues / Things to take into account

Having a config.txt file that doesn't follow the layout can cause unprecedented problems. But probably a crash.

At the moment, only MP3 files are supported for songs, however various image types like png and jpg are supported.

I plan on working on this project more, adding features, although it may be slow with school starting for me -- as of August 11th, 2025.

# Tutorial

WIP

# Extra

Feel free to take the project and update it if you wish, and if you want to help me send me bugs and errors you find, alongside feature ideas.

I hope you enjoy my program!
