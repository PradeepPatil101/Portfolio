export class Movie {
  title: string = "";
  genre: string = "";
  runtime: number = 0;
  mpaa_rating: string = "";
  release_year: number = 0;
  imdb_rating: number = 0;
  critics_score: number = 0;
  director: string = "";
  actor1: string = "";
  actor2: string = "";
  actor3: string = "";
  actor4: string = "";
  actor5: string = "";

  constructor() {
    this.clean();
  }

  clean(): void {
    this.title = "";
    this.genre = "";
    this.runtime = 0;
    this.mpaa_rating = "";
    this.release_year = 0;
    this.imdb_rating = 0;
    this.critics_score = 0;
    this.director = "";
    this.actor1 = "";
    this.actor2 = "";
    this.actor3 = "";
    this.actor4 = "";
    this.actor5 = "";
  }

  clone(): Movie {
     var movie: Movie = new Movie();
     movie.copyFrom(this);
     return movie;
  }

  copyFrom(from: Movie): void {
    this.title = from.title;
    this.genre = from.genre;
    this.runtime = from.runtime;
    this.mpaa_rating = from.mpaa_rating;
    this.release_year = from.release_year;
    this.imdb_rating = from.imdb_rating;
    this.critics_score = from.critics_score;
    this.director = from.director;
    this.actor1 = from.actor1;
    this.actor2 = from.actor2;
    this.actor3 = from.actor3;
    this.actor4 = from.actor4;
    this.actor5 = from.actor5;
  }

}