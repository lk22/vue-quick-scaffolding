#!/bash/bin

# quick vue project scaffolding vue project 
# it needs to ask for vue router installation
# it needs to ask for pinia state manager installation

INSTALL_ROUTER=0
INSTALL_STATE_MANAGER=0
INSTALL_ROUTER_COMMAND="npm install vue-router@4"
INSTALL_STATE_MANAGER_COMMAND="npm install pinia"

echo "Before scaffolding your Vue project i have a few questions\n"
echo "What is your project called?"
read PROJECT_NAME
echo "Great, moving on\n"

read -p "Do you need routing? (y/n)" WANT_ROUTER

case $WANT_ROUTER in
	[yY] ) 
		echo "Allright planning on installing router in the process hold on. \n"
		INSTALL_ROUTER=1
		;;
	[nN] )
		echo "Allright moving on. \n"
		;;
esac

read -p "Do you need state management in your app? (y/n)" WANT_STATE_MANAGER

case $WANT_STATE_MANAGER in
	[yY] ) 
		echo "Allright planning on installing state manager in the process hold on. \n"
		INSTALL_STATE_MANAGER=1
		;;
	[nN] )
		echo "Allright moving on. \n"
		;;
esac

echo "Initializing project install process"
# initializing project

npm create vite@latest $PROJECT_NAME -- --template vue

# change into project directory
cd $PROJECT_NAME

# open in you're favourite editor
code .

case $INSTALL_ROUTER in
	1 )
		echo "Installing router"
		npm install vue-router@4
		cd src && mkdir router && cd router && touch index.js
		echo "import { createRouter, createWebHistory } from 'vue-router'\n\nconst routes = []\n\nconst router = createRouter({\n\thistory: createWebHistory(import.meta.env.BASE_URL),\n\troutes,\n})\n\nexport default router" > index.js
		cd ../..
		;;
esac

case $INSTALL_STATE_MANAGER in
	1 )
		echo "Installing state manager Pinia\n"
		echo "Looking for pinia package\n"
		npm install pinia
		echo "Creating store directory\n"
		cd src && mkdir store && cd store && touch index.js
		echo "import { createPinia } from 'pinia'\n\nexport const store = createPinia()" > index.js
		cd ../..
		;;
esac

# run dev server to get started with the project
npm run dev