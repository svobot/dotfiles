function fish_title
	set old_status $status
	if [ $old_status != 0 ]
		echo "⚠ ($old_status)    "
	end
	pwd
end

