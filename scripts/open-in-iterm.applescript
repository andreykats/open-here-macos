try
	tell application "Finder"
		set finderPath to POSIX path of (target of front window as alias)
	end tell
on error
	set finderPath to POSIX path of (path to desktop)
end try

if application "iTerm" is running then
	tell application "iTerm"
		create window with default profile
		tell current session of current window
			write text "cd " & quoted form of finderPath & " && clear"
		end tell
		activate
	end tell
else
	activate application "iTerm"
	delay 1
	tell application "iTerm"
		tell current session of current window
			write text "cd " & quoted form of finderPath & " && clear"
		end tell
	end tell
end if
