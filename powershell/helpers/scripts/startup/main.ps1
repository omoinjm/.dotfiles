# Define the path to vcvarsall.bat
$vcvarsallPath = "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvarsall.bat"

# Define the architecture (x64 in this case)
$architecture = "x64"

# Run vcvarsall.bat and then use the 'cl' command
& $vcvarsallPath $architecture