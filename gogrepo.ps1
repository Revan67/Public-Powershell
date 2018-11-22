##################################
# Powershell Wrapper for GOG Repo
# By Revan67
##################################

# Folder paths
$repo = "D:\games\gog\Repo"
$ost = "D:\games\gog\Soundtracks\"

# GOG variables
$gog = "gogrepo.py"
$os = "windows"
$os2 = "linux"

# GOG repo commands
python.exe $gog update -skipknown -os $os $os2 -lang en
python.exe $gog update -update -os $os $os2 -lang en

# GOG execute downloads
python.exe $gog download $repo -os $os $os2 -lang en

# GOG verify Downloads and delete mismatch 
python.exe $gog verify $repo -d 

# Copy soundtracks
get-childitem -Recurse -path $repo -Include "*soundtrack*", "*ost*", "*flac*", "*mp3*" -Exclude "*.sh", "*.exe", "*poster*", "*postcard*", "*ghost*", "*lost*", "*post*", "*frost*"| copy-item -Destination $ost -Verbose

# Check duplicates delete mp3 if flac exists
gci $ost|? baseName -match '_mp3$|_flac$' |group { $_.basename -replace  '_mp3$|_flac$' }|? count -gt 1|select -exp group|? basename -match '_mp3$'|Remove-Item -Verbose