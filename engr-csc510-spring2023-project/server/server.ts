import express = require('express');

import bodyParser = require("body-parser");

import { Movie } from '../common/movie';
import { MovieRepository } from './movierepository';
import { MovieSearchForm } from '../common/movieSearchForm'

var taserver = express();
var movieRepo: MovieRepository = new MovieRepository();

movieRepo.populateMoviesRepositoryFromCSV();

var allowCrossDomain = function (req: any, res: any, next: any) {
  res.header('Access-Control-Allow-Origin', "*");
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  next();
}
taserver.use(allowCrossDomain);
taserver.use(bodyParser.json());

taserver.get('/movies', function (req: express.Request, res: express.Response) {

  res.send(JSON.stringify(movieRepo.getAllMovies()));

})

taserver.post('/movies', function (req: express.Request, res: express.Response) {

  var movie: Movie = new Movie();
  movie.title = req.body.title;
  movie.genre = req.body.genre;
  movie.runtime = req.body.runtime;
  movie.mpaa_rating = req.body.mpaa_rating;
  movie.release_year = req.body.release_year;
  movie.imdb_rating = req.body.imdb_rating;
  movie.critics_score = req.body.critics_score;
  movie.director = req.body.director;
  movie.actor1 = req.body.actor1;
  movie.actor2 = req.body.actor2;
  movie.actor3 = req.body.actor3;
  movie.actor4 = "";
  movie.actor5 = "";
  if (movie.title == null || movie.genre == null || movie.runtime == null || movie.mpaa_rating == null || movie.release_year == null || movie.imdb_rating == null || movie.critics_score == null || movie.director == null || movie.actor1 == null || movie.actor2 == null || movie.actor3 == null) {
    res.status(422).send(JSON.stringify(movie));
  }

  else {
    var movies: Movie[] = movieRepo.getAllMovies();
    var exists: boolean = false;
    for (var i = 0; i < movies.length; i++) {
      if (movies[i].title == movie.title) {
        exists = true;
        movies[i].genre = movie.genre;
        movies[i].runtime = movie.runtime;
        movies[i].mpaa_rating = movie.mpaa_rating;
        movies[i].release_year = movie.release_year;
        movies[i].imdb_rating = movie.imdb_rating;
        movies[i].critics_score = movie.critics_score;
        movies[i].director = movie.director;
        movies[i].actor1 = movie.actor1;
        movies[i].actor2 = movie.actor2;
        movies[i].actor3 = movie.actor3;
        res.status(200).send(JSON.stringify(movie));
        return;
      }
    }
    if (!exists) {
      movieRepo.add(movie);
      res.status(200).send(JSON.stringify(movie));
    }
  }
})

taserver.post('/recmovies', function (req: express.Request, res: express.Response) {
  // Parse the request body into its separate parts
  var emotion = req.body.emotion;
  if (emotion != "Happy" && emotion != "Sad" && emotion != "Neutral") {
    res.status(422).send(JSON.stringify(emotion));
  }
  var occasion = req.body.occasion;
  if (occasion != "Date Night" && occasion != "Family Movie Night" && occasion != "Movie With Friends" && occasion != "Bored and Alone" && occasion != "other") {
    res.status(422).send(JSON.stringify(occasion));
  }
  var mpaa_rating = req.body.mpaa_rating;
  if (mpaa_rating != "none" && mpaa_rating != "G" && mpaa_rating != "PG" && mpaa_rating != "PG-13" && mpaa_rating != "R") {
    res.status(422).send(JSON.stringify(mpaa_rating));
  }
  var start_release_year = req.body.start_release_year;
  var last_release_year = req.body.last_release_year;

  // Check if a start and last release year are provided - if not, set them to 0 and 9999 respectively
  if (start_release_year == null) {
    start_release_year = 0;
  }

  if (last_release_year == null) {
    last_release_year = 9999;
  }

  var genre: String[] = movieRepo.getGenre(occasion, emotion);
  var movies: Movie[] = movieRepo.getFilteredMovies(genre, mpaa_rating, start_release_year, last_release_year);
  if (movies.length == 0) {
    movies = movieRepo.getFilteredMovies(genre, mpaa_rating, (parseInt(start_release_year) - 25), (parseInt(last_release_year) + 25));
    if (movies.length == 0) {
      res.status(204).send(JSON.stringify([]));
    } else {
      for (var i = 5; i <= 25; i += 5) {
        movies = movieRepo.getFilteredMovies(genre, mpaa_rating, (parseInt(start_release_year) - i), (parseInt(last_release_year) + i));
        if (movies.length != 0) {
          break;
        }
      }
      res.status(206).send(JSON.stringify(movies));
    }
  } else {
    res.status(200).send(JSON.stringify(movies));
  }
})


taserver.listen(3000, function () {
  console.log('Server listening on port 3000!')
})

taserver.post('/findMovies', function (req: express.Request, res: express.Response) {
  // Parse the request body into a movie
  const form: MovieSearchForm = req.body as MovieSearchForm;

  // Check if at least one field was provided - if not, return an error code
  if (form.title === "" && form.genre === "" && form.runtime === null && form.mpaa_rating === ""
  && form.release_year_start === null && form.release_year_end === null && form.imdb_rating === null && form.critics_score === null
  && form.director === "" && form.actor1 === "" && form.actor2 === "" && form.actor3 === "") {
    res.status(422).send(JSON.stringify(form));
  }

  // Find and return movies matching the qualifications
  res.status(200).send(JSON.stringify(movieRepo.findMovies(form)));
})