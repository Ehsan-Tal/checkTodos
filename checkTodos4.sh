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

	if [ "${#message}" -le ${TABCHARACTERLIMIT} ]; then
		echo -e "${message}"
	else
		echo -e "too long, lol. Message=${message}"
	fi

	return 0
}


function process_success {
	bulletStage="${2}"
	genre="success:"	
	tempString=$(printf "%${bulletStage}s")
	bullets=${tempString// /-} 
	
	if [ "${2}" -eq "1" ]; then
		PRIMARY="${GREEN}"
	else
		PRIMARY="${LIGHTGREEN}"
	fi

	message="${PRIMARY} ${bullets} ${genre}${NC} ${1}"

	print_status "${message}"

	unset message
	unset PRIMARY
	unset bulletStage
	unset genre
	unset tempString
	unset bullets

	return 0

}


function process_error {
	bulletStage="${2}"
	genre="error:"	
	tempString=$(printf "%${bulletStage}s")
	bullets=${tempString// /-} 

	if [ "${2}" -eq "1" ]; then
		PRIMARY="${RED}"
	else
		PRIMARY="${LIGHTRED}"
	fi

	message="${PRIMARY} ${bullets} ${genre}${NC} ${1}"

	print_status "${message}"

	unset message
	unset PRIMARY
	unset bulletStage
	unset genre
	unset tempString
	unset bullets

	return 0

}


function process {
	bulletStage="${2}"
	tempString=$(printf "%${bulletStage}s")
	bullets=${tempString// /-} 

	if [ "${2}" -eq "1" ]; then
		echo -e "\n ${bullets} ${1}"
	else
		echo -e " ${bullets} ${1}"
	fi


	unset message
	unset tempString
	unset bullets
	unset bulletStage

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
#TODO: find if T_date matches B_date
#TODO: find if T_date matches C_date
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

#COMPLETEDARRAY		made later
#CONTENTSARRAY		made later




process "Ensuring directories" "1"

process "checking presence of the directories..." "2"

DIRECTORYFILEPATHArray=(
	"${ORIGINALDIRECTORYFILEPATH}"
	"${BACKUPDIRECTORYFILEPATH}"
	"${COMPLETEDDIRECTORYFILEPATH}"
)

for (( i=0; i < "${#DIRECTORYFILEPATHArray[*]}"; i++ )); do
	DIRECTORYFILEPATH="${DIRECTORYFILEPATHArray[${i}]}"

	if [ -d "${DIRECTORYFILEPATH}" ]; then
		process_success "$(basename ${DIRECTORYFILEPATH}) exists					${PASS}" "2"
	
	else
		process_success "$(basename ${DIRECTORYFILEPATH}) missing					${FAIL}" "2"
        	ask_consent "Do you want to create ${DIRECTORYFILEPATH} ?"
	
		if [ ${consent} = "Y" ]; then
			process_success "making directory" "3"

			#TODO: unhash when done
			#mkdir ${DIRECTORYFILEPATH}
		else
			process_error "CONSENT NEGATIVE" "3"
        		exit_script
		fi

		unset consent

	fi

	unset DIRECTORYFILEPATH
done

unset DIRECTORYFILEPATHArray

process_success "Directories Exist" "1"



# START OF:	ARRAY PACKAGING


#TODO:	backup raw file

#TODO:	Split input by major heading into packages
#TODO:	Split rest of code into source files

#TODO:	create clean algorithmic process from source files
#TODO:	process every package
#TODO:	re-combine the packages
#TODO:	save completed with their respective headings


# END OF:	ARRAY PACKAGING




#	START OF: "Fiddling with Backups (B)"

process "Fiddling with Backups (B)" "1"
echo -e "${YELLOW} - NOTE:${NC} Backups is not implemented"


process "checking if ${DATE} < TODAY..." "2"

if [ ! true ]; then
	process "moving B file..." "3"
	# mv OLDTODOFILE ${BACKUPDIRECTORYFILEPATH}
	#TODO: unhash when done
fi


process_success "Fiddling with Backups (B)" "1"

#	END OF: "Fiddling with Backups (B)"




#	START OF: Gathering Todo (T) input

process "Gathering Todo (T) input" "1"
echo -e "${YELLOW} - NOTE:${NC} Todo is not implemented"


while [ 1 ]; do


#	[ -s "${NEWTODOFILEPATH}" ] || touch ${NEWTODOFILEPATH}

	#OLDTODOFILE="$(ls ${ORIGINALDIRECTORYFILEPATH} | grep -i "todos" )"
	OLDTODOFILE="$(ls ${ORIGINALDIRECTORYFILEPATH} | grep -i "todos.md")"
	#TODO fix the grep to be specific to the todo file within
	OLDTODOFILEPATH="${ORIGINALDIRECTORYFILEPATH}/${OLDTODOFILE}"


	process "checking if T file exists..." "2"

	if [ -n "${OLDTODOFILE}" ]; then

		process "reading T file contents..." "3"

		i=0
		while IFS= read -r line; do
			
			CONTENTSARRAY[${i}]="${line}"
			i=$(( i + 1 ))

		done < ${OLDTODOFILEPATH}
		
		unset i


		process "checking if T data exists..." "3"

		if [ -n "${CONTENTSARRAY}" ]; then
			process_success "${OLDTODOFILE} has data					${PASS}" "2"
			break
	
		else 
			process_error "${OLDTODOFILE:-'missing file'} is empty !					${FAIL}" "2"
			exit_script
		fi

	else
		process_error "${OLDTODOFILE:-The todo file} is absent !				${FAIL}" "2"
		


		ask_consent "Do you want to recover from the most recent backup ?"
		
		if [ "${consent}"  = "Y" ]; then
			process "recovering from last backup..." 2
		else
			process_error "decided not to recover" 2
		fi
		
		unset consent




		ask_consent "Do you want to generate a new one ?"

		if [ "${consent}" = "Y" ]; then
			process "generating T file..." "2"
			
			generate_default_todo "${NEWTODOFILE}" || exit_script_with_message "ERROR: generate default todo function not sourced !"
		else
			exit_script_with_message "decided not to generate todo file"
		fi

		unset consent

	fi

done
# END OF T INPUT WHILE LOOP

process_success "Gathering Todo (T) input" "1"
#	END OF: Gathering Todo (T) input




#	START OF:  Processing Todo (T) data
process "Processing Todo (T) data" "1"
echo -e "${YELLOW} - NOTE:${NC} not all items are implemented"


#	START OF: -[c] destruction
process "destroying cancelled..." 2
value="-[c]"


while [ 1 ]; do

	changes=false

	for index in "${!CONTENTSARRAY[@]}"; do
		contentString="${CONTENTSARRAY[$index]}"

		if [[ "${contentString:0:${#value}}" = "${value}" ]]; then
			CONTENTSARRAY=( "${CONTENTSARRAY[@]:0:${index}}"	 "${CONTENTSARRAY[@]:$((index + 1))}" )	
#			process "excluding: ${contentString}" 3
			changes=true
		fi
	done
	# end of for loop

	if [[ "${changes}" = false ]]; then
		process_success "Clean of Cancels" 2
		break
	fi

#	for ((i=0; i<9; i++)); do
#		echo "${CONTENTSARRAY[${i}]}"
#	done
#	read

done
# end of while loop


unset changes
unset value
unset contentSTRING

#	END OF: -[c] destruction




#	START OF: date checking

process "checking if ${DATE} < TODAY..." 2

#	TODO: take date from todo
#	TODO: check against it

makeCompleted=false

if [[ "${makeCompleted}" = true ]]; then

#	START OF: -[x] extrication
	process "extricating completed..." 3

	value="-[x]"
	declare -a COMPLETEDARRAY
	COMPLETEDARRAY+=("${CONTENTSARRAY[0]}")


	while [ 1 ]; do

		changes=false

		for index in "${!CONTENTSARRAY[@]}"; do
			contentString="${CONTENTSARRAY[$index]}"

			if [[ "${contentString:0:${#value}}" = "${value}" ]]; then
				CONTENTSARRAY=( "${CONTENTSARRAY[@]:0:${index}}"	 "${CONTENTSARRAY[@]:$((index + 1))}" )	
#				echo " ---- extricating: ${contentString}"
				COMPLETEDARRAY+=("${contentString}")
				changes=true
			fi
		done
		# end of for loop

		if [[ "${changes}" = false ]]; then
			process_success "X's Extricated" 2
			break
		fi

	done


	unset changes
	unset value
	unset contentSTRING
	unset COMPLETEDARRAY
#	END OF: -[x] extrication
fi

unset makeCompleted

process_success "Processed Todo (T) data" 1

#	END OF: date checking


if [ ! true ]; then

#	START OF: Gathering Domain Todos (D) input

process "Gathering Domain Todos (D) input" 1
echo -e "${RED} - WARNING: ${NC} Domain Todos are not implemented"

process "reading D file contents" 2

process "checking if D data exists..." 3

process "check against DOMAINS.md..." 2

process "generating D file..." 3

process_success "Gathering Domain Todos (D) input" 1

#	END OF: Gathering Domain Todos (D) input




#	START OF: Processing Domain Todos (D) data

process "Processing Domain Todos (D) data" 1
echo -e "${RED} - WARNING: ${NC} Domain Todos are not implemented"

process "destroying cancelled..." 2

process "checking if ${DATE} < TODAY..." 2

process "cutting completed..." 3

process "counting lines..." 2

process "update heading with new count..." 3

process_success "Processed Todo (T) data" 1

#	END OF: Processing Domain Todos (D) data




#	START OF: Bluetooth Process

process "Bluetooth Process" 1
echo -e "${RED} - WARNING: ${NC} Bluetooth Process not implemented"

#CONTENTSARRAY=( "${bluetoothArray[@]}" "${CONTENTSARRAY[@]}" )


process_success "Bluetooth Process" 1

#	END OF: Bluetooth Process

fi






