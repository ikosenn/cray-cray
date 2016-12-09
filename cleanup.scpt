set timeoutInSeconds to 60
set abortOnTimeout to true
tell application (path to frontmost application as text)
 try
 set dialogResult to display dialog "Do you want to clean downloads folder?" default button 2 giving up after timeoutInSeconds
 on error number -128
 return
 end try
end tell
if gave up of dialogResult and abortOnTimeout then
 return
end if
do shell script "/Users/user/Projects/cray-cray/cleanup.sh"
