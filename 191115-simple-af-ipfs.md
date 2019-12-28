---
title: Simple AF IPFS
date: 2019-11-15
---

<!-- THIS POST IS A WORK IN PROGRESS -->

## Making IPFS Simple AF

Storing data in one specific location is stupid. It's the #1 way to get screwed over when the company hosting your data collapses, steals it, gets hacked, or just full on dies. So instead you should store your data on a distributed network that has built in protection against all these issues.

We're going to create a script that connects to the IPFS network, creates a file, uploads that file to the IPFS network, and then requests the file from the network to make sure everything worked. This isn't a huge project, and you can skip right to the end if you want to see the script in full.

### Prerequisites

You're gonna need these X things installed:

1. [NPM](https://www.npmjs.com/)
2. [NodeJS](https://nodejs.org/en/)

To find out if you've got these two things installed run `npm --version` and `node --version` to find out. Both commands should print out the software's version number:

```bash
npm --version
> 6.13.0

node --version
> v12.12.0

```

Now that we've got that sorted, let's move on to actually doing stuff.

### Project Set Up

All we really need to do is create a directory to store our JavaScript file, and install IPFS into that directory using NPM.

1. Create a new directory to store your code:

    ```bash
    mkdir ~/simple-af-ipfs
    ```

2. Create a JavaScript file that we'll edit in the next step:

    ```bash
    touch simple.js
    ```

3. Install IPFS into this directory through NPM:

    ```bash
    npm install ipfs
    ```

### Build the Script

Now we've set up our project, we can start writing the actual code that's gonna do all the fun stuff I promised earlier. We're just going to create one function with an IPFS object in it. We'll then use that object to interact with the IPFS network. After everything's done we'll log everything back out to the console so you can see what happened.

1. Open up your `simple.js` file. The rest of the steps will take place within this file.
2. First up, let's tell NodeJS that you want to run this script in _strict mode_. This makes sure we don't accidentally break something:

    ```javascript
    "use script"
    ```

3. Create an _asynchronous_ function called `main`, and call it on the outside of the curly brackets: 

    ```javascript
    async function main() {

    }

    main();
    ```

    The rest of our code is going to come inside the curly brackets `{}`.

4. This is where the actual coding happens. We need to create an IPFS object we can use to interact with the network. Let's call it `node`:

    ```javascript
    const node = await IPFS.create();
    ```

    We've attached the `await` expression because our `main` function is an asynchronous function. Essentially, by adding this `await` tag we're telling our function to wait until we get a response from IPFS before moving onto the next line.

#### The Final Script

Here's the final script in full:

```javascript
"use strict"

// Import the IPFS package from NPM.
const IPFS = require('ipfs')

async function main () {

    // Create the IPFS project to interact with.
    const node = await IPFS.create();

    // Create a files object and upload it to the network
    const filesAdded = await node.add({
        path: 'hello.txt',
        content: 'Hello World 101'
    });

    // Request the file from the IPFS network.
    const fileBuffer = await node.cat(filesAdded[0].hash)

    // Print out the contents of the file gathered from the network.
    console.log('Added file contents:', fileBuffer.toString());
}

main()
```
