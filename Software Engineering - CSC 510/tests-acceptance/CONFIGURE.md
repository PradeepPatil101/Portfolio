1. Start the server and the gui
2. Make sure chrome is updated to version 110
3. Go to the tests-acceptance folder and run these commands:

    $> `npm install`

    $> `npm run webdriver-update`

    $> `npm run webdriver-start`

You should see something like:
...
16:42:54.030 INFO [SeleniumServer.boot] - Selenium Server is up and running on port 4444

4. Run `npm test`
