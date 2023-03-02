#!/bin/bash


RED="\e[31m"
YELLOW="\e[33m"
NC="\e[0m"

PASS="✔️ "
FAIL="❌"

function ask_consent() {
        # question is internal, response is external

        echo " -- ${1}"
        read -p " --- Yes/No: " consent

        consent=${consent:0:1}
        consent=${consent^^}

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
		echo " --- success: $(basename ${DIRECTORYFILEPATH}) exists					${PASS}"
	
	else
		echo " --- ERROR: $(basename ${DIRECTORYFILEPATH}) missing					${FAIL}"
        	ask_consent "Do you want to create ${DIRECTORYFILEPATH} ?"
	
		if [ ${consent} = "Y" ]; then
			echo " --- making directory"

			#TODO: unhash when done
			#mkdir ${DIRECTORYFILEPATH}
		else
			echo -e "\n - Exiting"
        		exit 0
		fi

		unset consent

	fi

	unset DIRECTORYFILEPATH
done

unset DIRECTORYFILEPATHArray


echo -e "\n${YELLOW} - NOTE:${NC} Todo is not implemented"
echo -e "\n - Gathering Todo (T) input"

echo " -- find out T file..."

[ -s "${NEWTODOFILEPATH}" ] || touch ${NEWTODOFILEPATH}

OLDTODOFILE="$(ls ${ORIGINALDIRECTORYFILEPATH} | grep -i "todos"* )"

OLDTODOFILEPATH="${ORIGINALDIRECTORYFILEPATH}/${OLDTODOFILE}"

echo " --- checking if T file exists..."

echo " -- reading T file contents..."
mapfile -t CONTENTSArray < <(cat ${OLDTODOFILEPATH})

cat ${CONTENTSArray} | tail -5

echo " --- checking if T data exists..."

echo " ---- generating T file..."

#touch ${}
#echo "default" > ${NEWTODOFILE}

echo " Done ?"
read


echo -e "\n${YELLOW} - NOTE:${NC} Todos is not implemented"
echo -e "\n - Processing Todo (T) data"

echo " -- destroying cancelled..."

echo " -- checking if ${DATE} < TODAY..."

echo " --- extricating completed..."


echo -e "\n${YELLOW} - NOTE:${NC} Backups is not implemented"
echo -e "\n - Fiddling with Backups (B)"

echo " -- checking if ${DATE} < TODAY..."

echo " --- moving B file..."


echo -e "\n${RED} - WARNING: ${NC} Domain Todos are not implemented"
echo -e "\n - Gathering Domain Todos (D) input"

echo " -- reading D file contents"

echo " --- checking if D data exists..."

echo " -- check against DOMAINS.md..."

echo " --- generating D file..."


echo -e "\n${RED} - WARNING: ${NC} Domain Todos are not implemented"
echo -e "\n - Processing Domain Todos (D) data"

echo " -- destroying cancelled..."

echo " -- checking if ${DATE} < TODAY..."

echo " --- cutting completed..."

echo " -- counting lines..."

echo " --- update heading with new count..."


echo -e "\n${YELLOW} - NOTE:${NC} Completed is not implemented"
echo -e "\n - Fiddling with Completed (C)"

echo " -- checking if C data exists..."

echo " --- generating C file..."

echo " --- appending C data..."












