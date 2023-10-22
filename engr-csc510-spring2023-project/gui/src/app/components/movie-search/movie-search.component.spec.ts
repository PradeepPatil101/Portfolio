import { ComponentFixture, TestBed } from '@angular/core/testing';
import { FormBuilder } from '@angular/forms';
import { of, throwError } from 'rxjs';
import { MovieService } from 'src/app/mock_data/mock-movie-service';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { Movie } from '../../../../../common/movie';

import { MovieSearchComponent } from './movie-search.component';

describe('MovieSearchComponent', () => {
  let component: MovieSearchComponent;
  let fixture: ComponentFixture<MovieSearchComponent>;
  let movieServiceSpy: jasmine.SpyObj<MovieService>;

  const form = {
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
  }

  const movies: Movie[] = []

  beforeEach(async () => {
    const movie1 = new Movie();
    movie1.title = "Movie 1";
    movie1.genre = "Action";
    movie1.runtime = 120;
    movie1.mpaa_rating = "PG-13";
    movie1.release_year = 2020;
    movie1.imdb_rating = 7.5;
    movie1.critics_score = 80;
    movie1.director = "Director 1";
    movie1.actor1 = "Actor 1";
    movie1.actor2 = "Actor 2";
    movie1.actor3 = "Actor 3";
    movie1.actor4 = "";
    movie1.actor5 = "";

    movies.push(movie1); 

    const movie2 = new Movie();
    movie2.title = "The Godfather";
    movie2.genre = "Crime, Drama";
    movie2.runtime = 175;
    movie2.mpaa_rating = "R";
    movie2.release_year = 1972;
    movie2.imdb_rating = 9.2;
    movie2.critics_score = 98;
    movie2.director = "Francis Ford Coppola";
    movie2.actor1 = "Marlon Brando";
    movie2.actor2 = "Al Pacino";
    movie2.actor3 = "James Caan";
    movie2.actor4 = "";
    movie2.actor5 = "";
    movies.push(movie2);

    const movieServiceSpyObj = jasmine.createSpyObj('MovieService', ['findMovies']);
    await TestBed.configureTestingModule({
      declarations: [ MovieSearchComponent ],
      imports: [HttpClientTestingModule],
      providers: [
        FormBuilder,
        { provide: MovieService, useValue: movieServiceSpyObj },
      ],
    })
    .compileComponents();

    movieServiceSpy = TestBed.inject(MovieService) as jasmine.SpyObj<MovieService>;
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(MovieSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  describe('inputIsInvalid', () => {
    it('should return true when all fields are empty', () => {
      component.movieSearchForm.patchValue({
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
      });

      const result = component.inputIsInvalid();

      expect(result).toBeTrue();
    });

    it('should return false when imdb_rating is greater than 10', () => {
      component.movieSearchForm.patchValue({
        imdb_rating: 12
      });
      


      const result = component.inputIsInvalid();

      expect(result).toBeTrue();
    });

    it('should return true when actor1 is Tom Cruise', () => {
      component.movieSearchForm.patchValue({
       actor1: "Tom Cruise"
      });
      


      const result = component.inputIsInvalid();

      expect(result).toBeFalse();
    });


  });
});