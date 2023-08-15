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

read -p "Do you need routing? (y/n) " WANT_ROUTER

case $WANT_ROUTER in
	[yY] ) 
		echo "Allright planning on installing router in the process hold on. \n"
		INSTALL_ROUTER=1
		;;
	[nN] )
		echo "Allright moving on. \n"
		;;
esac

read -p "Do you need state management in your app? (y/n) " WANT_STATE_MANAGER

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
		echo "
import { createRouter, createWebHistory } from 'vue-router'
const routes = []
const Router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes,
})

export default Router
		" > index.js
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
		echo "Creating store file\n"
		echo "
import {defineStore} from 'pinia'

export const useCounterStore = defineStore('store', () => {
	return {
		count: 0
	}
})
		" > index.js
		cd ../..
		;;
esac

echo "
Project initialized
--------------------------------------------------
if you want to use the router and or the pinia state manager, you need to import it in your main.js file
--------------------------------------------------

import { createApp } from 'vue'
import App from './App.vue'
import Router from './router'
import { createPinia } from 'pinia'

const app = createApp(App)
	app.use(Router)
	app.use(createPinia())
	app.mount('#app')

--------------------------------------------------
Happy coding :)
--------------------------------------------------
"

# run dev server to get started with the project
# npm run dev