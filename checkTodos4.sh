#!/bin/bash


RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"

PASS="✔️ "
FAIL="❌"
TABCHARACTERLIMIT="48"

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

function process_error {
	message=" -- ERROR: ${1}"

	if [ "${#message}" -le ${TABCHARACTERLIMIT} ]; then
		echo "${message}"
	else
		echo " -- ERROR: ${#message} is too long, lol."
	fi

	unset message
}

function subprocess_error {
	message=" --- ERROR: ${1}"

	if [ "${#message}" -le ${TABCHARACTERLIMIT} ]; then
		echo "${message}"
	else
		echo " --- ERROR: ${#message} is too long, lol."
	fi

	unset message
}

function process_success {
	message=" -- success: ${1}"

	if [ "${#message}" -le ${TABCHARACTERLIMIT} ]; then
		echo "${message}"
	else
		echo " -- success: ${#message} is too long, lol."
	fi

	unset message
}

function subprocess_success {
	message=" --- success: ${1}"

	if [ "${#message}" -le ${TABCHARACTERLIMIT} ]; then
		echo "${message}"
	else
		echo " --- success: ${#message} is too long, lol."
	fi

	unset message
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
		mapfile -t CONTENTSArray < <(cat ${OLDTODOFILEPATH})

		echo ${CONTENTSArray}

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

echo " -- destroying cancelled..."

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












