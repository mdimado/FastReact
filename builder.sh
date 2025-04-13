
#take project name input
echo "enter the name of your project:"
read projectname

#create directory with the name of the project
mkdir $projectname

cd $projectname
#create next.js application named, 'projectname', later change the folder name to 'frontend'
npx create-next-app@latest $projectname --yes
# (the yes flag is to use defaults for all options )

#change name of the projectdir to frontend
mv $projectname frontend

#initialize fastapi backend
mkdir backend

#navigate to backend directory
cd backend

#check the operating system
OS=$(uname -s)
echo $OS

#activate python virtual env, diff for diff os
case "$OS" in
  Linux | Darwin)
    pinst=pip3
    python3 -m venv venv
    source venv/bin/activate
    ;;
  WindowsNT)
    pinst=pip
    python -m venv venv
    Activate .\venv\Scripts\activate
    ;;
esac

#install fastapi
$pinst install fastapi