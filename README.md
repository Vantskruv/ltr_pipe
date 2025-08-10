This is a partial fork of ltr_pipe from UglyDwarfs Linuxtrack project (https://github.com/uglyDwarf/linuxtrack).
I have been trying make the code more barebone, there is still much to do, but it seems it works for now.
The main purpose is to create a bridge between the TrackIR hardware and OpenTrack software.
With some modification of UglyDwarf:s code this is possible via UDP.

To compile the code (I hope it works for you), create a subdirectory (i.e. build) and enter it. Then compile it:
$ cmake ..
$ make

If everything turned out well, you should have two files:
liblinuxtrack.so
ltr_pipe

Copy the start_tracking and stop_tracking files into the build folder, and run start_tracking.
If you look in to the file start_tracking, it is set to output to port 4242 (you can change that if you want).
Open up OpenTrack, and select UDP over network as input, and set the same port as you have in your start_tracking file.
