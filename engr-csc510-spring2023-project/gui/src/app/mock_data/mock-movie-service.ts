import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { HttpClientModule } from '@angular/common/http';
import { Movie } from '../../../../common/movie';
import { NgModule } from '@angular/core';

@NgModule({
  imports: [HttpClientModule],
  providers: [MovieService],
})

@Injectable()
export class MovieService {
  recommendedMovies: Array<Movie>;
  statusCode: number;


 

  constructor() {
    this.recommendedMovies = new Array<Movie>();
    this.statusCode = -101;

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
    this.recommendedMovies.push(movie1);
    const movie2 = new Movie();
movie2.title = "Movie 2";
movie2.genre = "Comedy";
movie2.runtime = 95;
movie2.mpaa_rating = "PG";
movie2.release_year = 2019;
movie2.imdb_rating = 6.8;
movie2.critics_score = 70;
movie2.director = "Director 2";
movie2.actor1 = "Actor 4";
movie2.actor2 = "Actor 5";
movie2.actor3 = "Actor 6";
movie2.actor4 = "";
movie2.actor5 = "";
this.recommendedMovies.push(movie2);

const movie3 = new Movie();
movie3.title = "Movie 3";
movie3.genre = "Drama";
movie3.runtime = 110;
movie3.mpaa_rating = "R";
movie3.release_year = 2018;
movie3.imdb_rating = 8.2;
movie3.critics_score = 90;
movie3.director = "Director 3";
movie3.actor1 = "Actor 7";
movie3.actor2 = "Actor 8";
movie3.actor3 = "Actor 9";
movie3.actor4 = "";
movie3.actor5 = "";
this.recommendedMovies.push(movie3);

const movie4 = new Movie();
movie4.title = "Movie 4";
movie4.genre = "Horror";
movie4.runtime = 85;
movie4.mpaa_rating = "R";
movie4.release_year = 2021;
movie4.imdb_rating = 6.0;
movie4.critics_score = 60;
movie4.director = "Director 4";
movie4.actor1 = "Actor 10";
movie4.actor2 = "Actor 11";
movie4.actor3 = "Actor 12";
movie4.actor4 = "";
movie4.actor5 = "";
this.recommendedMovies.push(movie4);

  }
  



  getAllMovies(): Observable<Array<Movie>> {
    this.recommendedMovies = new Array<Movie>();
    this.statusCode = -101;

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
    this.recommendedMovies.push(movie1);
    const movie2 = new Movie();
movie2.title = "Movie 2";
movie2.genre = "Comedy";
movie2.runtime = 95;
movie2.mpaa_rating = "PG";
movie2.release_year = 2019;
movie2.imdb_rating = 6.8;
movie2.critics_score = 70;
movie2.director = "Director 2";
movie2.actor1 = "Actor 4";
movie2.actor2 = "Actor 5";
movie2.actor3 = "Actor 6";
movie2.actor4 = "";
movie2.actor5 = "";
this.recommendedMovies.push(movie2);

const movie3 = new Movie();
movie3.title = "Movie 3";
movie3.genre = "Drama";
movie3.runtime = 110;
movie3.mpaa_rating = "R";
movie3.release_year = 2018;
movie3.imdb_rating = 8.2;
movie3.critics_score = 90;
movie3.director = "Director 3";
movie3.actor1 = "Actor 7";
movie3.actor2 = "Actor 8";
movie3.actor3 = "Actor 9";
movie3.actor4 = "";
movie3.actor5 = "";
this.recommendedMovies.push(movie3);

const movie4 = new Movie();
movie4.title = "Movie 4";
movie4.genre = "Horror";
movie4.runtime = 85;
movie4.mpaa_rating = "R";
movie4.release_year = 2021;
movie4.imdb_rating = 6.0;
movie4.critics_score = 60;
movie4.director = "Director 4";
movie4.actor1 = "Actor 10";
movie4.actor2 = "Actor 11";
movie4.actor3 = "Actor 12";
movie4.actor4 = "";
movie4.actor5 = "";
this.recommendedMovies.push(movie4);
console.log(of(this.recommendedMovies));
return of(this.recommendedMovies);
  }

  getNewMovieRecommendations(body: string): Observable<any> {
    return of({ body: this.recommendedMovies, status: 200 });
  }

  setMovieRecommendations(movieReqString: string) {
    this.statusCode = 200;
  }

  getMovieRecommendations(): Array<Movie> {
    this.recommendedMovies = new Array<Movie>();
    this.statusCode = -101;

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
    this.recommendedMovies.push(movie1);
    const movie2 = new Movie();
movie2.title = "Movie 2";
movie2.genre = "Comedy";
movie2.runtime = 95;
movie2.mpaa_rating = "PG";
movie2.release_year = 2019;
movie2.imdb_rating = 6.8;
movie2.critics_score = 70;
movie2.director = "Director 2";
movie2.actor1 = "Actor 4";
movie2.actor2 = "Actor 5";
movie2.actor3 = "Actor 6";
movie2.actor4 = "";
movie2.actor5 = "";
this.recommendedMovies.push(movie2);

const movie3 = new Movie();
movie3.title = "Movie 3";
movie3.genre = "Drama";
movie3.runtime = 110;
movie3.mpaa_rating = "R";
movie3.release_year = 2018;
movie3.imdb_rating = 8.2;
movie3.critics_score = 90;
movie3.director = "Director 3";
movie3.actor1 = "Actor 7";
movie3.actor2 = "Actor 8";
movie3.actor3 = "Actor 9";
movie3.actor4 = "";
movie3.actor5 = "";
this.recommendedMovies.push(movie3);

const movie4 = new Movie();
movie4.title = "Movie 4";
movie4.genre = "Horror";
movie4.runtime = 85;
movie4.mpaa_rating = "R";
movie4.release_year = 2021;
movie4.imdb_rating = 6.0;
movie4.critics_score = 60;
movie4.director = "Director 4";
movie4.actor1 = "Actor 10";
movie4.actor2 = "Actor 11";
movie4.actor3 = "Actor 12";
movie4.actor4 = "";
movie4.actor5 = "";
this.recommendedMovies.push(movie4);
this.statusCode = 200;
return this.recommendedMovies;
  }

  getStatusCode(): number {
    return this.statusCode;
  }

  getMoviePosterLink(imgId: string): Observable<any> {
    return of('link');
  }


  updateMovie(body: string): Observable<any> {
    return of({});
  }

  findMovies(body: string): Observable<any> {
    return of(this.recommendedMovies);
  }

}
