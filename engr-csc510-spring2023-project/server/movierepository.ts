import { Movie } from '../common/movie';
import { MovieSearchForm } from '../common/movieSearchForm'
import { parse } from 'csv-parse';
import * as path from "path";
import * as fs from "fs";

export class MovieRepository {
  movies: Movie[] = [];

  async populateMoviesRepositoryFromCSV() {
    const csvFilePath = path.resolve(__dirname, '../data/movies.csv');

    const headers = ['title', 'genre', 'runtime', 'mpaa_rating', 'release_year',
      'imdb_rating', 'critics_score', 'director', 'actor1', 'actor2', 'actor3',
      'actor4', 'actor5'];

    const fileContent = fs.readFileSync(csvFilePath, { encoding: 'utf-8' });

    return new Promise<void>((resolve, reject) => {
      parse(fileContent, {
        delimiter: ',',
        columns: headers,
      }, (error, result: Movie[]) => {
        if (error) {
          console.error(error);
          reject(error);
        } else {
          for (var i = 1; i < result.length; i++) {
            this.add(result[i]);
          }
          resolve();
        }
      });
    });
  }

  getGenre(occasion: String, emotion: String): String[] {
    var returnGenre: string[] = [];
    if (occasion == "Date Night" && emotion == "Happy") {
      returnGenre.push("Comedy");
      return returnGenre;
    }
    else if (occasion == "Date Night" && emotion == "Neutral") {
      returnGenre.push("Drama");
      return returnGenre;
    }
    else if (occasion == "Date Night" && emotion == "Sad") {
      returnGenre.push("Animation");
      return returnGenre;
    }
    else if (occasion == "Family Movie Night" && emotion == "Happy") {
      returnGenre.push("Animation");
      return returnGenre;
    }
    else if (occasion == "Family Movie Night" && emotion == "Neutral") {
      returnGenre.push("Comedy");
      return returnGenre;
    }
    else if (occasion == "Family Movie Night" && emotion == "Sad") {
      returnGenre.push("Comedy");
      return returnGenre;
    }
    else if (occasion == "Movie With Friends" && emotion == "Happy") {
      returnGenre.push("Action & Adventure");
      returnGenre.push("Science Fiction & Fantasy");
      return returnGenre;
    }
    else if (occasion == "Movie With Friends" && emotion == "Neutral") {
      returnGenre.push("Mystery & Suspense");
      return returnGenre;
    }
    else if (occasion == "Movie With Friends" && emotion == "Sad") {
      returnGenre.push("Horror");
      return returnGenre;
    }
    else if (occasion == "Bored and Alone" && emotion == "Happy") {
      returnGenre.push("Action & Adventure");
      returnGenre.push("Science Fiction & Fantasy");
      return returnGenre;
    }
    else if (occasion == "Bored and Alone" && emotion == "Neutral") {
      returnGenre.push("Documentary");
      returnGenre.push("Drama");
      return returnGenre;
    }
    else if (occasion == "Bored and Alone" && emotion == "Sad") {
      returnGenre.push("Animation");
      returnGenre.push("Comedy");
      return returnGenre;
    } else if (occasion == "other" && emotion == "Happy") {
      returnGenre.push("Animation");
      returnGenre.push("Comedy");
      returnGenre.push("Science Fiction & Fantasy");
      returnGenre.push("Action & Adventure");
    } else if (occasion == "other" && emotion == "Neutral") {
      returnGenre.push("Documentary");
      returnGenre.push("Drama");
      returnGenre.push("Comedy");
      returnGenre.push("Mystery & Suspense");
    } else if (occasion == "other" && emotion == "Sad") {
      returnGenre.push("Drama");
      returnGenre.push("Animation");
      returnGenre.push("Comedy");
      returnGenre.push("Horror");
    }
    return returnGenre;

  }

  add(movie: Movie): Movie {
    var result: Movie = new Movie();
    result.copyFrom(movie);
    this.movies.push(result);
    return result;
  }

  getAllMovies(): Movie[] {
    return this.movies;
  }

  getFilteredMovies(genres: String[], mpaa_rating: String,
    start_release_year: number, last_release_year: number): Movie[] {
    var returnMovies: Movie[] = this.movies.filter((movie) => {
      if (mpaa_rating == "none") {
        return movie.release_year >= start_release_year &&
          movie.release_year <= last_release_year &&
          genres.includes(movie.genre);
      }
      return movie.mpaa_rating == mpaa_rating &&
        movie.release_year >= start_release_year &&
        movie.release_year <= last_release_year &&
        genres.includes(movie.genre);
    });
    return returnMovies.sort(() => Math.random() - 0.5);
  }

  findMovies(form: MovieSearchForm): Movie[] {
    return this.movies.filter((movie) => {
      // Each field (mpaa rating, title, etc) may be null or empty, so check if they're null before checking for equality
      if (form.title != '' && movie.title.toLowerCase() != form.title.toLowerCase()) {
        return false;
      }

      if (form.genre != '' && movie.genre.toLowerCase() != form.genre.toLowerCase()) {
        return false;
      }

      if (form.director != '' && movie.director.toLowerCase() != form.director.toLowerCase()) {
        return false;
      }

      if (form.mpaa_rating != '' && movie.mpaa_rating != form.mpaa_rating) {
        return false;
      }

      // Movie actors and actresses may be presented in any order, they just have to exist in the movie's list
      let movieCast: string[] = [movie.actor1.toLowerCase(), movie.actor2.toLowerCase(), movie.actor3.toLowerCase(), movie.actor4.toLowerCase(), movie.actor5.toLowerCase()];
      if (form.actor1 != '' && !movieCast.includes(form.actor1.toLowerCase())) {
        return false;
      }

      if (form.actor2 != '' && !movieCast.includes(form.actor2.toLowerCase())) {
        return false;
      }

      if (form.actor3 != '' && !movieCast.includes(form.actor3.toLowerCase())) {
        return false;
      }

      // The provided IMDB rating and critics score are the lower bounds. E.g. if the provided IMDB rating is 5.4, this should return
      // all movies with an IMDB rating of 5.4 or higher
      if (form.imdb_rating != null && movie.imdb_rating < form.imdb_rating) {
        return false;
      }

      if (form.critics_score != null && movie.critics_score < form.critics_score) {
        return false;
      }

      if (form.runtime != null) {
        // If the user has said so, movies within 10 minutes of the provided runtime on either side are acceptable matches
        if (form.approximate_runtime == true) {
          if ((movie.runtime > form.runtime + 10 || movie.runtime < form.runtime - 10)) {
            return false;
          }
        } else {
          // Otherwise, the movie runtime must match the provided runtime exactly
          if (movie.runtime != form.runtime) {
            return false;
          }
        }
      }

      if (form.release_year_start != null) {
        if (form.approximate_release_year) {
          // If the user has said so, movies released within 5 years of the provided release year on either side are acceptable matches
          if ((movie.release_year < form.release_year_start - 5)) {
            return false;
          }
        } else {
          if (movie.release_year < form.release_year_start) {
            return false;
          }
        }
      }

      if (form.release_year_end != null) {
        if (form.approximate_release_year) {
          // If the user has said so, movies released within 5 years of the provided release year on either side are acceptable matches
          if ((movie.release_year > form.release_year_end + 5)) {
            return false;
          }
        } else {
          if (movie.release_year > form.release_year_end) {
            return false;
          }
        }
      }

      // If all checks pass, the movie meets the qualifications and should be returned
      return true;
    });
  }
}