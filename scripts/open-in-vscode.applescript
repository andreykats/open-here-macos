try
	tell application "Finder"
		set finderPath to POSIX path of (target of front window as alias)
	end tell
on error
	set finderPath to POSIX path of (path to desktop)
end try

do shell script "open -a 'Visual Studio Code' " & quoted form of finderPath
