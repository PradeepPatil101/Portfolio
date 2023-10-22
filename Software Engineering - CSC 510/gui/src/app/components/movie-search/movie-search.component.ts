import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { MovieService } from 'src/app/services/movie.service';
import { Movie } from '../../../../../common/movie';
import { MovieSearchForm } from '../../../../../common/movieSearchForm';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'app-movie-search',
  templateUrl: './movie-search.component.html',
  styleUrls: ['./movie-search.component.css']
})
export class MovieSearchComponent {
  movieSearchForm = this.formBuilder.group<MovieSearchForm>({
    title: '',
    genre: '', 
    runtime: null, 
    mpaa_rating: '',
    release_year_start: null,
    release_year_end: null,
    imdb_rating: null,
    critics_score: null,
    director: '',
    actor1: '',
    actor2: '',
    actor3: '',
    approximate_runtime: false,
    approximate_release_year: false
  })

  // Tracks whether the user provided valid input
  infoIsCorrect: boolean;

  // Tracks whether the request to the backend was successful
  updateSucceeded: boolean;

  // Tracks whether the request to the backend failed
  updateFailed: boolean;

  // Tracks whether the request is processing
  loading: boolean;

  // Tracks whether the last request used approximate runtime
  lastReqApproximateRuntime: boolean | null | undefined;

  // Tracks whether the last request used approximate release year
  lastReqApproximateReleaseYear: boolean | null | undefined;

  // Contains movies found by searching
  movies: Movie[];

  constructor(private formBuilder: FormBuilder,
              private movieService: MovieService,
              private titleService: Title) {
    this.titleService.setTitle('Search for a movie');
    this.infoIsCorrect = false;
    this.updateSucceeded = false;
    this.updateFailed = false;
    this.loading = false;
    this.lastReqApproximateRuntime = false;
    this.lastReqApproximateReleaseYear = false;
    this.movies = [];
  }

  inputIsInvalid(): boolean {
    let form = this.movieSearchForm.value;
    return (form.title === "" && form.genre === "" && form.runtime === null && form.mpaa_rating === ""
      && form.release_year_start === null && form.release_year_end == null && form.imdb_rating === null && form.critics_score === null
      && form.director === "" && form.actor1 === "" && form.actor2 === "" && form.actor3 === ""
      || (form.imdb_rating! > 10 || form.imdb_rating! < 0 || form.critics_score! > 100 || form.critics_score! < 0));
  }

  resetBooleans() {
    this.updateSucceeded = false;
    this.updateFailed = false;
    this.infoIsCorrect = true;
    this.loading = true; 
    this.lastReqApproximateRuntime = this.movieSearchForm.value.approximate_runtime;
    this.lastReqApproximateReleaseYear = this.movieSearchForm.value.approximate_release_year;
  }

  onSubmit() {
    // Reset the booleans tracking the success and failure of the request
    this.resetBooleans();

    // Check if at least one field is provided
    if (this.inputIsInvalid()) {
      this.updateFailed = true;
      this.infoIsCorrect = false;
      this.loading = false;
    } else {
      // Make the request to the movie service and update the booleans appropriately
      this.movieService.findMovies(JSON.stringify(this.movieSearchForm.value)).subscribe(
        res => {
          this.updateSucceeded = true;
          this.loading = false;
          this.movies = res.body;
        },
        (err) => {
          if (err.status == 422) {
            this.infoIsCorrect = false;
          }
          this.updateFailed = true;
          this.loading = false;
        }
      )
    }
  }
}
