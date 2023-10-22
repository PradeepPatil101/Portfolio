Feature: Search for a movie
  As a user of the website,
  I want to be able to search for a movie

Scenario: Filter for a movie by title
  Given I am at the Search page
  And I see the title search bar with filters below
  When I type in a title: <title>
  And I click the Search button
  Then I see a filtered list of movies below the search

Examples:
  | title | genre | MPAA rating |
  | The Godfather  | Drama | R |
  | The Lion King  | Animation | G | 
  | The Dark Knight | Action | PG-13 |

Scenario: Filter for a movie by genre and MPAA rating
  Given I am at the Search page
  And I see the title search bar with filters below
  When I select a genre: <genre> 
  And I select an MPAA Rating: <MPAA rating> 
  And I click the Search button
  Then I see a filtered list of movies below the search

Examples:
  | title | genre | MPAA rating |
  | The Godfather  | Drama | R |
  | The Lion King  | Animation | G | 
  | The Dark Knight | Action | PG-13 |



