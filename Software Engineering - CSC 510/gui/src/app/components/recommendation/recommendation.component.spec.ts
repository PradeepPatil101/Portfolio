import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RecommendationComponent } from './recommendation.component';
import { HttpClientTestingModule } from '@angular/common/http/testing';
import { MovieService } from 'src/app/mock_data/mock-movie-service';
import { CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { Router } from '@angular/router';


import { Movie } from '../../../../../common/movie';
import { of, Observable, Observer } from 'rxjs';

describe('RecommendationComponent', () => {
  let component: RecommendationComponent;
  let fixture: ComponentFixture<RecommendationComponent>;
  let movieServiceSpy: jasmine.SpyObj<MovieService>;
  let service: MovieService;
  

  
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
    
    

  beforeEach(async () => {
    service = new MovieService();
    // movieServiceSpy = jasmine.createSpyObj('MovieService', ['getMovieRecommendations', 'getStatusCode']);

    // movieServiceSpy.getMovieRecommendations.and.returnValue([movie1,movie2]);


    await TestBed.configureTestingModule({
      declarations: [ RecommendationComponent ],
      imports: [HttpClientTestingModule],
      providers: [
        MovieService
      ],
      schemas: [ CUSTOM_ELEMENTS_SCHEMA ]
    })
    .compileComponents();

    
    console.log(service);
    
});

beforeEach(() => {
  fixture = TestBed.createComponent(RecommendationComponent);
  component = fixture.componentInstance;
  service = TestBed.inject(MovieService);
  fixture.detectChanges();
});


  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should load movie recommendations on initialization', () => {
    component.recommendations = [];
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

    const testMovies: Movie[] = [
      movie1, movie2
    ];
    const statusCode = -1;

    component.loadMovieRecommendations();
    component.recommendations = testMovies;

    expect(component.recommendations).toEqual(testMovies);
    expect(component.statusCode).toEqual(statusCode);
  });
  

  it('should show next recommendation', () => {
    component.recommendations = [];
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
    const testMovies: Movie[] = [
      movie1, movie2
    ];
    component.recommendations = testMovies;
    component.currentRecIdx = 0;

    component.showNextRecommendation();

    expect(component.currentRecIdx).toEqual(1);
    expect(component.currentRecMovie).toEqual(testMovies[1]);
  });

  it('should redirect to homepage', () => {
    const router = TestBed.inject<Router>(Router);
    spyOn(router, 'navigate');
    component.redirectToHomepage();
    expect(router.navigate).toHaveBeenCalledWith(['/']);
  });
  
});
