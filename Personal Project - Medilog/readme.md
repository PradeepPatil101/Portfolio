# Medilog

Medilog helps you to save medical receipt and test reports into one place. It also enables you to share the receipt using shareable link.


## Features

- Cloud Application
- Login with Google
- Sharebale Link
- Unlimited File Saving

---
## Requirements

For development, you will only need Node.js and a node global package, Yarn, installed in your environement.

### Node
- #### Node installation on Windows

  Just go on [official Node.js website](https://nodejs.org/) and download the installer.
Also, be sure to have `git` available in your PATH, `npm` might need it (You can find git [here](https://git-scm.com/)).

- #### Node installation on Ubuntu

  You can install nodejs and npm easily with apt install, just run the following commands.

      $ sudo apt install nodejs
      $ sudo apt install npm

- #### Other Operating Systems
  You can find more information about the installation on the [official Node.js website](https://nodejs.org/) and the [official NPM website](https://npmjs.org/).

If the installation was successful, you should be able to run the following command.

    $ node --version
    v14.15.4

    $ npm --version
    6.14.20

If you need to update `npm`, you can make it using `npm`! Cool right? After running the following command, just open again the command line and be happy.

    $ npm install npm -g

###
### Yarn installation
  After installing node, this project will need yarn too, so just run the following command.

      $ npm install -g yarn

---

## Install

    $ git clone https://github.com/https://github.com/PradeepPatil101/MediLog
    $ cd MediLog
    $ yarn install or npm install

## Configure app

Open `./config.js` then edit it with your settings. You will need:

- clientId : Google OAuth Client ID
- secret : Google OAuth secret
- callback : callback URL
- dbconfig : Database credentials

Open or Create `./.env` then edit it with your settings. You will need:

- NODE_ENV: this value can be `dev` or `prod`

## Running the project

    $ npm start

## Simple build for production

    $ npm build