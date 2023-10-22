import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { MovieService } from 'src/app/services/movie.service';
import { Title } from '@angular/platform-browser';

@Component({
  selector: 'app-movie-update',
  templateUrl: './movie-update.component.html',
  styleUrls: ['./movie-update.component.css']
})
export class MovieUpdateComponent {
  movieUpdateForm = this.formBuilder.group({
    title: '',
    genre: '', 
    runtime: null, 
    mpaa_rating: '',
    release_year: null,
    imdb_rating: null,
    critics_score: null,
    director: '',
    actor1: '',
    actor2: '',
    actor3: ''
  })

  updateSucceeded: boolean;
  updateFailed: boolean;
  infoIsCorrect: boolean;
  loading: boolean; // indicates whether a request is being completed at this time

  constructor(private formBuilder: FormBuilder,
              private movieService: MovieService,
              private titleService: Title) {
    this.titleService.setTitle('Add or update a movie');
    this.updateSucceeded = false;
    this.updateFailed = false;
    this.infoIsCorrect = true;
    this.loading = false;
  }

  inputIsInvalid(): boolean {
    let form = this.movieUpdateForm.value;
    return (form.title === "" || form.genre === "" || form.runtime === null || form.mpaa_rating === ""
      || form.release_year === null || form.imdb_rating === null || form.critics_score === null
      || form.director === "" || form.actor1 === "" || form.actor2 === "" || form.actor3 === ""
      || form.imdb_rating! > 10 || form.imdb_rating! < 0 || form.critics_score! > 100 || form.critics_score! < 0);
  }

  onSubmit() {
    // Reset the booleans tracking the success and failure of the request
    this.updateSucceeded = false;
    this.updateFailed = false;
    this.infoIsCorrect = true;
    this.loading = true;

    // Check if all fields are provided
    if (this.inputIsInvalid()) {
      this.updateFailed = true;
      this.infoIsCorrect = false;
      this.loading = false;
    } else {
      // Make the request to the movie service and update the booleans appropriately
      this.movieService.updateMovie(JSON.stringify(this.movieUpdateForm.value)).subscribe(
        res => {
          if (res.status == 200) {
            this.updateSucceeded = true;
          } else {
            this.updateFailed = true;
          }
          this.loading = false;
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
