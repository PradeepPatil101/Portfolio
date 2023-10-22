Feature: As an end user
  I want to fill out a form
  So that I can have a movie recommended to me

Scenario: Filling Out Form to get a movie recommended
  Given I am at the home page
  When I click the Suggest me movies button
  Then I am prompted to answer the following question: "What is the occasion?"
  And I see several possible occasions
  When I select '<occasion>' for the occasion
  And I click the next button "1"
  Then I am prompted to answer the following question: "How are you today?"
  And I see a scale of faces ranging from a sad face to a happy face
  When I select '<emotion>' from the faces
  And I click the next button "2"
  Then I am prompted to answer the following question: "How old would you like the movie to be?"
  And I see two empty year inputs
  When I select from '<fromYear>' to '<toYear>'
  And I click the next button "3"
  Then I am prompted to answer the following question: "Do you have a preference for the age-appropriateness of the movie?"
  And I see MPAA rating options
  When I select a rating of '<rating>'
  And I click the submit button
  Then I see '<title>' movie suggestion based on my answers


Examples:
  | occasion           | emotion | fromYear | toYear | rating        | title                     |
  | Date Night         | Happy   | 1970     | 1980   | G             | The Shaggy D.A.           |
  | Movie With Friends | Neutral | 2000     | 2002   | PG-13         | The Mothman Prophecies    |
  | other              | Neutral | 1960     | 1971   | G             | Let It Be                 |
  | Bored and Alone    | Neutral | 1960     | 1971   | no-preference | Let It Be                 |
  | Family Movie Night | Happy   | 2006     | 2006   | G             | Doogal                    |
  | Bored and Alone    | Sad     | 2011     | 2011   | R             | A Good Old Fashioned Orgy |
