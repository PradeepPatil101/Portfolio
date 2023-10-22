Feature: Add or update a movie
  As a user of the website,
  I want to be able to add or update a movie
  so that other users can see the new movie details.

Scenario: Adding or updating a movie
  Given I am at the Add or update a movie page
  And I see the form to add or update a movie
  When I click the field for ‘Movie title’
  And I enter the movie title: <title>
  And I click the field for ‘Genre’
  And I enter the genre of the movie: <genre>
  And I click the field for ‘Top 3 Actors/Actresses’
  And I enter the name of actor/actress #1: <actor1>
  And I enter the name of actor/actress #2: <actor2>
  And I enter the name of actor/actress #3: <actor3>
  And I click the field for ‘IMDB Rating’
  And I enter the IMDB rating of the movie: <imdbRating>
  And I click the field for ‘Rotten Tomatoes Rating’
  And I enter the Rotten Tomatoes rating of the movie: <rottenTomatoesRating>
  And I click the field for ‘Director’
  And I enter ‘<directorName>’ into the field for ‘Director’
  And I click the field for ‘Year released’
  And I enter ‘<year>’ into the field for ‘Year released’
  And I click the field for ‘Runtime’
  And I enter ‘<runtime>’ into the field for ‘Runtime’
  When I select ‘<mpaa>’ for the ‘MPAA Rating’ field
  When I click the ‘Submit’ button
  Then I should see a success message on the page

Examples:
  | title          | genre      | actor1        | actor2         | actor3         | imdbRating | rottenTomatoesRating | directorName  | year | runtime | mpaa |
  | The Godfather  | Drama      | Marlon Brando | Al Pacino      | James Caan     | 9.2        | 97                   | Francis Ford Coppola | 1972 | 175 | R |
  | The Lion King  | Animation  | Matthew Broderick | Jeremy Irons | James Earl Jones | 8.5        | 93                   | Roger Allers, Rob Minkoff | 1994 | 162 | G | 
  | The Dark Knight | Action    | Christian Bale | Heath Ledger   | Aaron Eckhart  | 9.0        | 94                   | Christopher Nolan | 2008 | 162 | PG-13 |
