try
	tell application "Finder"
		set finderPath to POSIX path of (target of front window as alias)
	end tell
on error
	set finderPath to POSIX path of (path to desktop)
end try

tell application "iTerm"
	activate
	set newWindow to (create window with default profile)
	tell current session of newWindow
		write text "cd " & quoted form of finderPath
	end tell
end tell
