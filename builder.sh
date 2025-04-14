
#take project name input
echo "enter the name of your project:"
read projectname

echo "creating folder $projectname..."
sleep 1
#create directory with the name of the project
mkdir $projectname

cd $projectname
echo "building frontend next application..."
#create next.js application named, 'projectname', later change the folder name to 'frontend'
npx create-next-app@latest $projectname --yes > /dev/null 2>&1
# (the yes flag is to use defaults for all options )

#change name of the projectdir to frontend
mv $projectname frontend

#initialize fastapi backend
mkdir backend

#navigate to backend directory
cd backend

#check the operating system
OS=$(uname -s)

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

echo "initializing fastapi backend..."
#install fastapi
$pinst install fastapi uvicorn> /dev/null 2>&1

#create main.py file
touch main.py
#write a basic endpoint 
echo "
from fastapi import FastAPI

app = FastAPI()


@app.get(\"/\")
async def root():
    return {\"message\": \"Hello World\"}" >> main.py


(uvicorn main:app --reload > /dev/null 2>&1 &) && echo "backend running on  : http://localhost:8000"
cd ../frontend && (npm run dev > /dev/null 2>&1 &) && echo "frontend running on  : http://localhost:3000"



