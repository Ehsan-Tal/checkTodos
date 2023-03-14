#!/bin/bash


RED="\e[31m"
YELLOW="\e[33m"
RED="\e[31m"
GREEN="\e[32m"
LIGHTGREEN="\e[92m"
LIGHTRED="\e[91m"
NC="\e[0m"

PASS="✔️ "
FAIL="❌"
TABCHARACTERLIMIT="60"

#TODO: figure out the character limit for tabs
#TODO: figure out the tab:character ratio
#TODO: figure out a control structure that fits the bill
#		this control structure can allow us to refactor into an error and an exit


function ask_consent() {
        # question is internal, response is external

        echo " -- ${1}"
        read -p " --- Yes/No: " consent

        consent=${consent:0:1}
        consent=${consent^^}

}


function exit_script {
	echo -e "\nMirupafshim, ${USER}"
	exit 0
}

function exit_script_with_message {
	echo " - ${1:-Missing message}"
	exit_script
}



function print_status {
	message="$1"
	genre="$2"

	if [ "${#message}" -le ${TABCHARACTERLIMIT} ]; then
		echo -e "${message}"
	else
		echo -e "a ${genre} is too long, lol. Message=${message}"
	fi

	return 0
}


function process_error {
	message="${LIGHTRED} -- ERROR:${NC} ${1}"

	print_status "${message}" "process_error"

	unset message

	return 0
}


function subprocess_error {
	message="${RED} --- ERROR:${NC} ${1}"

	print_status "${message}" "subprocess_error"

	unset message

	return 0
}


function process_success {
	message="${GREEN} -- success:${NC} ${1}"

	print_status "${message}" "process_success"

	unset message

	return 0
}


function subprocess_success {
	message="${LIGHTGREEN} --- success:${NC} ${1}"

	print_status "${message}" "subprocess_success"

	unset message

	return 0
}






# The new checkTodos !
#	No replacing files !
#	No multiple greps !
#	2 Creation ops
#	1 Move op
#	1 Grep op


#TODO: sift _date from collected Todo
#TODO: check if more than TODAY
#TODO: cancel -[c]
#TODO: find if T_date matches B_date
#TODO: find if T_date matches C_date
#TODO: append -[x] to C
#TODO: form a template_todo
#TODO: add options support

#TODO: form a DOMAINS.md
#TODO: how updating headings ?
#TODO: how counting todos ?


TODAY=$(date "+%Y-%m-%d")
#TODODATE found later

ORIGINALDIRECTORYFILEPATH="$HOME/Agenda"
BACKUPDIRECTORYFILEPATH="${ORIGINALDIRECTORYFILEPATH}/Backups"
COMPLETEDDIRECTORYFILEPATH="${ORIGINALDIRECTORYFILEPATH}/Completed"


# OLDTODOFILE should be collected from an ls command
NEWTODOFILE="todos_${TODAY}"

NEWTODOFILEPATH="${ORIGINALDIRECTORYFILEPATH}/${NEWTODOFILE}"

#TODOFILEPATH="${ORIGINALDIRECTORYFILEPATH}" created later ?
#BACKUPFILEPATH="${BACKUPDIRECTORYFILEPATH}"
#COMPLETEDFILEPATH="${COMPLETEDDIRECTORYFILEPATH}"

declare -a COMPLETEDTODOSArray
#CONTENTSArray made later


echo " -- checking presence of the directories..."

DIRECTORYFILEPATHArray=(
	"${ORIGINALDIRECTORYFILEPATH}"
	"${BACKUPDIRECTORYFILEPATH}"
	"${COMPLETEDDIRECTORYFILEPATH}"
)

for (( i=0; i < "${#DIRECTORYFILEPATHArray[*]}"; i++ )); do
	DIRECTORYFILEPATH="${DIRECTORYFILEPATHArray[${i}]}"

	if [ -d "${DIRECTORYFILEPATH}" ]; then
		subprocess_success "$(basename ${DIRECTORYFILEPATH}) exists					${PASS}"
	
	else
		subprocess_success "$(basename ${DIRECTORYFILEPATH}) missing					${FAIL}"
        	ask_consent "Do you want to create ${DIRECTORYFILEPATH} ?"
	
		if [ ${consent} = "Y" ]; then
			echo " --- making directory"

			#TODO: unhash when done
			#mkdir ${DIRECTORYFILEPATH}
		else
			echo -e "CONSENT NEGATIVE"
        		exit_script
		fi

		unset consent

	fi

	unset DIRECTORYFILEPATH
done

unset DIRECTORYFILEPATHArray



# START OF:	ARRAY PACKAGING


#TODO:	backup raw file

#TODO:	Split input by major heading into packages
#TODO:	Split rest of code into source files

#TODO:	create clean algorithmic process from source files
#TODO:	process every package
#TODO:	re-combine the packages
#TODO:	save completed with their respective headings


# END OF:	ARRAY PACKAGING

echo -e "\n - Backing up Todo file"
echo -e "${YELLOW} - NOTE:${NC} Todo is not implemented"



echo -e "\n - Gathering Todo (T) input"
echo -e "${YELLOW} - NOTE:${NC} Todo is not implemented"

while [ 1 ]; do


#	[ -s "${NEWTODOFILEPATH}" ] || touch ${NEWTODOFILEPATH}

	#OLDTODOFILE="$(ls ${ORIGINALDIRECTORYFILEPATH} | grep -i "todos" )"
	OLDTODOFILE="$(ls ${ORIGINALDIRECTORYFILEPATH} | grep -i "todos.md")"
	#TODO fix the grep to be specific to the todo file within
	OLDTODOFILEPATH="${ORIGINALDIRECTORYFILEPATH}/${OLDTODOFILE}"

	echo " --- checking if T file exists..."
	if [ -n "${OLDTODOFILE}" ]; then
		echo " --- reading T file contents..."

		i=0
		while IFS= read -r line; do
			
			CONTENTSArray[${i}]="${line}"
			i=$(( i + 1 ))

		done < ${OLDTODOFILEPATH}
		
		unset i


		echo " --- checking if T data exists..."
		if [ -n "${CONTENTSArray}" ]; then
			subprocess_success "${OLDTODOFILE} has data					${PASS}"
			break
	
		else 
			subprocess_error "${OLDTODOFILE:-'missing file'} is empty !					${FAIL}"
			exit_script
		fi

	else
		process_error "${OLDTODOFILE:-The todo file} is absent !				${FAIL}"
		echo " -- generating T file..."
		ask_consent "Do you want to generate a new one ?"

		if [ "${consent}" = "Y" ]; then
			generate_default_todo "${NEWTODOFILE}" || exit_script_with_message "ERROR: generate default todo function not sourced !"
		else
			exit_script_with_message "decided not to generate todo file"

		fi

		unset consent

	fi

done
# END OF T INPUT WHILE LOOP



echo -e "\n - Processing Todo (T) data"
echo -e "${YELLOW} - NOTE:${NC} Todos is not implemented"

#for i in "${CONTENTSArray[@]}"; do
#	echo $i
#done



#	START OF: -[c] destruction
echo " -- destroying cancelled..."
value="-[c]"

while [ 1 ]; do

	changes=false

	for index in "${!CONTENTSArray[@]}"; do
		contentString="${CONTENTSArray[$index]}"

		if [[ "${contentString:0:${#value}}" = "${value}" ]]; then
			CONTENTSArray=( "${CONTENTSArray[@]:0:${index}}"	 "${CONTENTSArray[@]:$((index + 1))}" )	
			echo " --- excluding: ${contentString}"
			changes=true
		fi
	done
	# end of for loop

	if [[ "${changes}" = false ]]; then
		process_success "Clean of Cancels"
		break
	fi

#	for ((i=0; i<9; i++)); do
#		echo "${CONTENTSArray[${i}]}"
#	done
#	read

done
# end of while loop


unset value
unset contentsSTRING

#	END OF: -[c] destruction



echo " -- checking if ${DATE} < TODAY..."

echo " --- extricating completed..."


echo -e "\n - Fiddling with Backups (B)"
echo -e "${YELLOW} - NOTE:${NC} Backups is not implemented"

echo " -- checking if ${DATE} < TODAY..."

echo " --- moving B file..."


echo -e "\n - Gathering Domain Todos (D) input"
echo -e "${RED} - WARNING: ${NC} Domain Todos are not implemented"

echo " -- reading D file contents"

echo " --- checking if D data exists..."

echo " -- check against DOMAINS.md..."

echo " --- generating D file..."


echo -e "\n - Processing Domain Todos (D) data"
echo -e "${RED} - WARNING: ${NC} Domain Todos are not implemented"

echo " -- destroying cancelled..."

echo " -- checking if ${DATE} < TODAY..."

echo " --- cutting completed..."

echo " -- counting lines..."

echo " --- update heading with new count..."


echo -e "\n - Fiddling with Completed (C)"
echo -e "${YELLOW} - NOTE:${NC} Completed is not implemented"

echo " -- checking if C data exists..."

echo " --- generating C file..."

echo " --- appending C data..."




echo -e "\n - Bluetooth"
echo -e "${RED} - WARNING: ${NC} not implemented"

#CONTENTSArray=( "${bluetoothArray[@]}" "${CONTENTSArray[@]}" )







