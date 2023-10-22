const { Movie } = require('../movie');

export {}; // To guarantee that Typescript considers this its own module

describe('Movie', () => {
  let movie: typeof Movie;

  beforeEach(() => {
    movie = new Movie();
  });

  describe('constructor', () => {
    it('should initialize all properties to their default values', () => {
      expect(movie.title).toEqual('');
      expect(movie.genre).toEqual('');
      expect(movie.runtime).toEqual(0);
      expect(movie.mpaa_rating).toEqual('');
      expect(movie.release_year).toEqual(0);
      expect(movie.imdb_rating).toEqual(0);
      expect(movie.critics_score).toEqual(0);
      expect(movie.director).toEqual('');
      expect(movie.actor1).toEqual('');
      expect(movie.actor2).toEqual('');
      expect(movie.actor3).toEqual('');
      expect(movie.actor4).toEqual('');
      expect(movie.actor5).toEqual('');
    });
  });

  describe('clean', () => {
    it('should reset all properties to their default values', () => {
      movie.title = 'The Matrix';
      movie.genre = 'Science Fiction';
      movie.runtime = 136;
      movie.mpaa_rating = 'R';
      movie.release_year = 1999;
      movie.imdb_rating = 8.7;
      movie.critics_score = 87;
      movie.director = 'Lana Wachowski';
      movie.actor1 = 'Keanu Reeves';
      movie.actor2 = 'Laurence Fishburne';
      movie.actor3 = 'Carrie-Anne Moss';
      movie.actor4 = 'Hugo Weaving';
      movie.actor5 = 'Gloria Foster';

      movie.clean();

      expect(movie.title).toEqual('');
      expect(movie.genre).toEqual('');
      expect(movie.runtime).toEqual(0);
      expect(movie.mpaa_rating).toEqual('');
      expect(movie.release_year).toEqual(0);
      expect(movie.imdb_rating).toEqual(0);
      expect(movie.critics_score).toEqual(0);
      expect(movie.director).toEqual('');
      expect(movie.actor1).toEqual('');
      expect(movie.actor2).toEqual('');
      expect(movie.actor3).toEqual('');
      expect(movie.actor4).toEqual('');
      expect(movie.actor5).toEqual('');
    });
  });

  describe('clone', () => {
    it('should return a new movie with the same properties as the original', () => {
      movie.title = 'The Matrix';
      movie.genre = 'Science Fiction';
      movie.runtime = 136;
      movie.mpaa_rating = 'R';
      movie.release_year = 1999;
      movie.imdb_rating = 8.7;
      movie.critics_score = 87;
      movie.director = 'Lana Wachowski';
      movie.actor1 = 'Keanu Reeves';
      movie.actor2 = 'Laurence Fishburne';
      movie.actor3 = 'Carrie-Anne Moss';
      movie.actor4 = 'Hugo Weaving';
      movie.actor5 = 'Gloria Foster';

      const clonedMovie = movie.clone();

      expect(clonedMovie).not.toBe(movie);
      expect(clonedMovie).toEqual(movie);
    });
  });

  describe('testing setters and getters for a few fields', () => {
    it('should set and get title', () => {
      const newTitle = 'The Godfather';
      movie.title = newTitle;
      expect(movie.title).toBe(newTitle);
    });
  });

  describe('copyFrom method', () => {
    it('should copy all properties', () => {
      const fromMovie = new Movie();
      fromMovie.title = 'The Godfather';
      fromMovie.genre = 'Drama';
      fromMovie.runtime = 175;
      fromMovie.mpaa_rating = 'R';
      fromMovie.release_year = 1972;
      fromMovie.imdb_rating = 9.2;
      fromMovie.critics_score = 99;
      fromMovie.director = 'Francis Ford Coppola';
      fromMovie.actor1 = 'Marlon Brando';
      fromMovie.actor2 = 'Al Pacino';
      fromMovie.actor3 = 'James Caan';
      fromMovie.actor4 = 'Richard S. Castellano';
      fromMovie.actor5 = 'Robert Duvall';
      
      const movie = new Movie();
      movie.copyFrom(fromMovie);
      
      expect(movie.title).toEqual(fromMovie.title);
      expect(movie.genre).toEqual(fromMovie.genre);
      expect(movie.runtime).toEqual(fromMovie.runtime);
      expect(movie.mpaa_rating).toEqual(fromMovie.mpaa_rating);
      expect(movie.release_year).toEqual(fromMovie.release_year);
      expect(movie.imdb_rating).toEqual(fromMovie.imdb_rating);
      expect(movie.critics_score).toEqual(fromMovie.critics_score);
      expect(movie.director).toEqual(fromMovie.director);
      expect(movie.actor1).toEqual(fromMovie.actor1);
      expect(movie.actor2).toEqual(fromMovie.actor2);
      expect(movie.actor3).toEqual(fromMovie.actor3);
      expect(movie.actor4).toEqual(fromMovie.actor4);
      expect(movie.actor5).toEqual(fromMovie.actor5);
    });
  });

  describe('testing setters and getters for a few fields', () => {
    it('should set and get title', () => {
      const title = 'The Shawshank Redemption';
      movie.title = title;
      expect(movie.title).toEqual(title);
    });

    it('should set and get genre', () => {
      const genre = 'Drama';
      movie.genre = genre;
      expect(movie.genre).toEqual(genre);
    });

    it('should set and get runtime', () => {
      const runtime = 142;
      movie.runtime = runtime;
      expect(movie.runtime).toEqual(runtime);
    });

    it('should set and get mpaa_rating', () => {
        const rating = 'G';
        movie.mpaa_rating = rating;
        expect(movie.mpaa_rating).toEqual(rating);
    });

      
});

});