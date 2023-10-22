const importCwd = require('import-cwd');
const { Given, When, Then } = importCwd('@cucumber/cucumber');
const { browser, $, element, by } = require('protractor');
const chai = require('chai').use(require('chai-as-promised'));
const expect = chai.expect;
const request = require('request');
const axios = require('axios');

// /////////
// Feature 1
// /////////

var base_url = "http://localhost:3000/";

Given(/^I am at the home page$/, async () => {
    await browser.get("http://localhost:4200/");
    await expect(browser.getTitle()).to.eventually.equal('Pick a movie for me please!');
});

When(/^I click the Suggest me movies button$/, async () => {
  await $("button[name='Start now!']").click();
  await browser.sleep(300);
});

Then(/^I am prompted to answer the following question: "([^\"]*)"$/, async (question) => {
  await expect(element(by.id('prompt-header')).getText()).to.eventually.equal(question);
});

When(/^I click the next button "([^\"]*)"$/, async(value) => {
  await $("button[name='Next" + value + "']").click();
  await browser.sleep(300);
});

Then(/^I see a scale of faces ranging from a sad face to a happy face$/, async() => {
  await expect(element(by.id('sad-image')).getAttribute("value")).to.eventually.equal("Sad");
  await expect(element(by.id('neutral-image')).getAttribute("value")).to.eventually.equal("Neutral");
  await expect(element(by.id('happy-image')).getAttribute("value")).to.eventually.equal("Happy");
});

When(/^I select '(.*)' from the faces$/, async (emotion) => {
  const e= element(by.id(emotion.toLowerCase() + '-image'));
  await browser.executeScript("arguments[0].click();", e.getWebElement());
});

Then(/^I see several possible occasions$/, async() => {
  await expect(element(by.id('radioButton1')).getAttribute("value")).to.eventually.equal("Date Night");
  await expect(element(by.id('radioButton2')).getAttribute("value")).to.eventually.equal("Family Movie Night");
  await expect(element(by.id('radioButton3')).getAttribute("value")).to.eventually.equal("Movie With Friends");
  await expect(element(by.id('radioButton4')).getAttribute("value")).to.eventually.equal("Bored and Alone");
  await expect(element(by.id('radioButton5')).getAttribute("value")).to.eventually.equal("other");
});

When(/^I select '(.*)' for the occasion$/, async(occasion) => {
  const radioButton = element(by.css('input[name="occasion"][value=\"' + occasion + '\"]'));
  await radioButton.click();
});

Then(/^I see two empty year inputs$/, async() => {
  await expect(element(by.id('start_release_year')).getAttribute("value")).to.eventually.equal("");
  await expect(element(by.id('last_release_year')).getAttribute("value")).to.eventually.equal("");
});

When(/^I select from '(\d+)' to '(\d+)'$/, async (from, to) => {
  await element(by.id('start_release_year')).sendKeys(from);
  await element(by.id('last_release_year')).sendKeys(to);
});

Then(/^I see MPAA rating options$/, async() => {
  await expect(element(by.id('no-preference-check')).getAttribute("value")).to.eventually.equal("none");
  await expect(element(by.id('g-check')).getAttribute("value")).to.eventually.equal("G");
  await expect(element(by.id('pg-check')).getAttribute("value")).to.eventually.equal("PG");
  await expect(element(by.id('pg-13-check')).getAttribute("value")).to.eventually.equal("PG-13");
  await expect(element(by.id('r-check')).getAttribute("value")).to.eventually.equal("R");
});

When(/^I select a rating of '(.*)'$/, async (ageRating) => {
  const e = element(by.id(ageRating.toLowerCase() + '-check'));
  await e.click();
});

When(/^I click the submit button$/, async() => {
  await $("button[name='Submit']").click();
  await browser.sleep(3000);
});

Then(/^I see '(.*)' movie suggestion based on my answers$/, async (title) => {
  await expect(element(by.id('movie-title')).getText()).to.eventually.equal(title);
});

// /////////
// Feature 2
// /////////

// Given(/^I am on the home page$/, async () => {
//   await browser.get('http://www.example.com');
//   const pageTitle = await browser.getTitle();
//   expect(pageTitle).to.equal('Example Domain');
// });

// var base_url = "http://localhost:3000/";

Given(/^I am at the Add or update a movie page$/, async () => {
  await browser.get("http://localhost:4200/update-movies");
});

Given(/^I see the form to add or update a movie$/, async () => {
  const form = element(by.css('#movie-update-form'));
  await expect(form.isPresent()).to.eventually.equal(true);
});

When(/^I click the field for ‘Movie title’$/, async () => {
  const movieTitleField = element(by.css('#movie-title-input'));
  await movieTitleField.click();
});

When(/^I enter the movie title: (.+)$/, async (title) => {
  const movieTitleField = element(by.css('#movie-title-input'));
  await movieTitleField.sendKeys(title);
});

When(/^I click the field for ‘Genre’$/, async () => {
  const genreField = element(by.css('#genre-input'));
  await genreField.click();
});

When(/^I enter the genre of the movie: (.+)$/, async (genre) => {
  const genreField = element(by.css('#genre-input'));
  await genreField.sendKeys(genre);
});

When(/^I click the field for ‘Top 3 Actors\/Actresses’$/, async () => {
  const actor1Field = element(by.css('#actor-1-input'));
  await actor1Field.click();
});

When(/^I enter the name of actor\/actress #1: (.+)$/, async (actor1) => {
  const actor1Field = element(by.css('#actor-1-input'));
  await actor1Field.sendKeys(actor1);
});

When(/^I enter the name of actor\/actress #2: (.+)$/, async (actor2) => {
  const actor2Field = element(by.css('#actor-2-input'));
  await actor2Field.sendKeys(actor2);
});

When(/^I enter the name of actor\/actress #3: (.+)$/, async (actor3) => {
  const actor3Field = element(by.css('#actor-3-input'));
  await actor3Field.sendKeys(actor3);
});

When(/^I click the field for ‘IMDB Rating’$/, async () => {
  const imdbRatingField = element(by.css('#imdb-rating'));
  await imdbRatingField.click();
});

When(/^I enter the IMDB rating of the movie: (.+)$/, async (imdbRating) => {
  const imdbRatingField = element(by.css('#imdb-rating'));
  await imdbRatingField.sendKeys(imdbRating);
});

When(/^I click the field for ‘Rotten Tomatoes Rating’$/, async () => {
  const rottenTomatoesRatingField = element(by.css('#rotten-tomatoes-rating'));
  await rottenTomatoesRatingField.click();
});

When(/^I enter the Rotten Tomatoes rating of the movie: (.+)$/, async (rottenTomatoesRating) => {
  const rottenTomatoesRatingField = element(by.css('#rotten-tomatoes-rating'));
  await rottenTomatoesRatingField.sendKeys(rottenTomatoesRating);
});
  
  When(/^I click the field for ‘Director’$/, async () => {
    const directorInput = element(by.id('movie-director-input'));
    await directorInput.click();
  });
  
  When(/^I enter ‘(.*)’ into the field for ‘Director’$/, async (directorName) => {
    const directorInput = element(by.id('movie-director-input'));
    await directorInput.sendKeys(directorName);
  });

  When(/^I click the field for ‘Year released’$/, async () => {
    const yearInput = element(by.id('year-released-input'));
  await yearInput.click();
    });
    
    When(/^I enter ‘(\d+)’ into the field for ‘Year released’$/, async (year) => {
      const yearInput = element(by.id('year-released-input'));
      await yearInput.sendKeys(year);
    });

    When(/^I click the field for ‘Runtime’$/, async () => {
      const runtimeInput = element(by.id('runtime-input'));
      await runtimeInput.click();
    });

    When(/^I enter ‘(.*)’ into the field for ‘Runtime’$/, async (runtime) => {
      const runtimeInput = element(by.id('runtime-input'));
      await runtimeInput.sendKeys(runtime);
    });

    When(/^I select ‘(.*)’ for the ‘MPAA Rating’ field$/, async (mpaaRating) => {
      const mpaaInput = element(by.id(`${mpaaRating.toLowerCase()}-mpaa-input`));
      await mpaaInput.click();
    });    
    
  
  
  When(/^I click the ‘Submit’ button$/, async () => {
      const submitButton = element(by.id('submit-form'));
      await browser.sleep(300);
      await browser.executeScript('window.scrollTo(0,document.body.scrollHeight)');
      await browser.sleep(300);
    await browser.actions().mouseMove(submitButton).perform();
    await browser.sleep(300);
    await browser.actions().click().perform();
  });

  Then('I should see a success message on the page', async function () {
    let expectedMessage = "Success!\nThanks for the info - we'll take it from here."
    const successMessageElement = await element(by.css('.request-success .alert-success'));
    const successMessageText = await successMessageElement.getText();
    await expect(successMessageText).to.equal(expectedMessage);
  });
  
// /////////
// Feature 3
// /////////

Given(/^I am at the Search page$/, async () => {
  await browser.get("http://localhost:4200/search-movies");
  await browser.sleep(500);
});

Given(/^I see the title search bar with filters below$/, async () => {
  const titleSearchBar = element(by.id('movie-title-input'));
  const genreFilter = element(by.id('genre-input'));
  const mpaaFilter = element(by.id('mpaa-select'));
  expect(await titleSearchBar.isPresent()).to.be.true;
  expect(await genreFilter.isPresent()).to.be.true;
  expect(await mpaaFilter.isPresent()).to.be.true;
});

When(/^I type in a title: (.+)$/, async (title) => {
  const titleSearchBar = element(by.id('movie-title-input'));
  await titleSearchBar.sendKeys(title);
});

When(/^I select a genre: (.+)$/, async (genre) => {
  const genreFilter = element(by.id('genre-input'));
  await genreFilter.sendKeys(genre);
});

When(/^I select an MPAA Rating: (.+)$/, async (mpaa) => {
  const mpaaFilter = await element(by.id('mpaa-select'));
  const option = await mpaaFilter.element(by.css(`option[value="${mpaa}"]`));
  await option.click();
});


When(/^I click the Search button$/, async function () {
  const submitButton = await element(by.id('search-button'));
  await submitButton.click();
  await browser.sleep(300);
});

Then(/^I see a filtered list of movies below the search$/, async () => {
  await browser.sleep(300);
  const header = element(by.id('successHeading'));
  const headerText = await header.getText();
  expect(headerText).equal("Good news! It looks like the following movies match your criteria:");
});




  



