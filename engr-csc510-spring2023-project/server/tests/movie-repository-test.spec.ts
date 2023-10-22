import { MovieSearchForm } from "../../common/movieSearchForm";

const { MovieRepository } = require('../movierepository');

export { }; // To guarantee that Typescript considers this its own module

const { Movie } = require('../../common/movie');

describe('MovieRepository', () => {
  let movieRepository: typeof MovieRepository;
  let movies: typeof Movie[] = [{
    title: 'Movie 1',
    genre: 'Action',
    runtime: 120,
    mpaa_rating: 'PG-13',
    release_year: 2010,
    imdb_rating: 7.5,
    critics_score: 80,
    director: 'Director 1',
    actor1: 'Actor 1',
    actor2: 'Actor 2',
    actor3: 'Actor 3',
    actor4: 'Actor 4',
    actor5: 'Actor 5',
  }];


  beforeEach(() => {
    movieRepository = new MovieRepository();
  });

  describe('populateMoviesRepositoryFromCSV', () => {
    it('should populate the movies repository from the CSV file', async () => {
      jest.spyOn(movieRepository, 'add');

      await movieRepository.populateMoviesRepositoryFromCSV();

      expect(movieRepository.add).toHaveBeenCalledTimes(651);
      expect(movieRepository.getAllMovies().length).toBe(651);
    });

  });


  describe('getGenre', () => {
    it('should return the correct genre for a "Date Night" occasion and "Happy" emotion', () => {
      // Arrange
      const occasion = 'Date Night';
      const emotion = 'Happy';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Comedy']);
    });

    it('should return the correct genre for a "Date Night" occasion and "Neutral" emotion', () => {
      // Arrange
      const occasion = 'Date Night';
      const emotion = 'Neutral';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Drama']);
    });

    it('should return the correct genre for a "Date Night" occasion and "Sad" emotion', () => {
      // Arrange
      const occasion = 'Date Night';
      const emotion = 'Sad';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Animation']);
    });

    it('should return the correct genre for a "Family Movie Night" occasion and "Happy" emotion', () => {
      // Arrange
      const occasion = 'Family Movie Night';
      const emotion = 'Happy';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Animation']);
    });

    it('should return the correct genre for a "Family Movie Night" occasion and "Neutral" emotion', () => {
      // Arrange
      const occasion = 'Family Movie Night';
      const emotion = 'Neutral';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Comedy']);
    });

    it('should return the correct genre for a "Family Movie Night" occasion and "Sad" emotion', () => {
      // Arrange
      const occasion = 'Family Movie Night';
      const emotion = 'Sad';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Comedy']);
    });

    it('should return the correct genre for a "Movie With Friends" occasion and "Happy" emotion', () => {
      // Arrange
      const occasion = 'Movie With Friends';
      const emotion = 'Happy';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Action & Adventure', 'Science Fiction & Fantasy']);
    });

    it('should return the correct genre for a "Movie With Friends" occasion and "Neutral" emotion', () => {
      // Arrange
      const occasion = 'Movie With Friends';
      const emotion = 'Neutral';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Mystery & Suspense']);
    });

    it('should return the correct genre for a "Movie With Friends" occasion and "Sad" emotion', () => {
      // Arrange
      const occasion = 'Movie With Friends';
      const emotion = 'Sad';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Horror']);
    });

    it('should return the correct genre for a "Bored and Alone" occasion and "Happy" emotion', () => {
      // Arrange
      const occasion = 'Bored and Alone';
      const emotion = 'Happy';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Action & Adventure', 'Science Fiction & Fantasy']);
    });

    it('should return the correct genre for a "Bored and Alone" occasion and "Neutral" emotion', () => {
      // Arrange
      const occasion = 'Bored and Alone';
      const emotion = 'Neutral';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Documentary', 'Drama']);
    });

    it('should return the correct genre for a "Bored and Alone" occasion and "Sad" emotion', () => {
      // Arrange
      const occasion = 'Bored and Alone';
      const emotion = 'Sad';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Animation', 'Comedy']);
    });

    it('should return the correct genre for a "other" occasion and "Happy" emotion', () => {
      // Arrange
      const occasion = 'other';
      const emotion = 'Happy';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Animation', 'Comedy', 'Science Fiction & Fantasy', 'Action & Adventure']);
    });

    it('should return the correct genre for a "other" occasion and "Neutral" emotion', () => {
      // Arrange
      const occasion = 'other';
      const emotion = 'Neutral';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Documentary', 'Drama', 'Comedy', 'Mystery & Suspense']);
    });

    it('should return the correct genre for a "other" occasion and "Sad" emotion', () => {
      // Arrange
      const occasion = 'other';
      const emotion = 'Sad';

      // Act
      const result = movieRepository.getGenre(occasion, emotion);

      // Assert
      expect(result).toEqual(['Drama', 'Animation', 'Comedy', 'Horror']);
    });


  });

  describe('add', () => {
    it('should add a new movie to the repository', () => {
      // Arrange
      const movie = new Movie();
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

      // Act
      const result = movieRepository.add(movie);

      // Assert
      expect(movieRepository.movies.length).toBe(1);
      expect(result.title).toBe('The Matrix');
      expect(result.genre).toBe('Science Fiction');
    });
  });

  describe('getFilteredMovies', () => {
    it('should return movies that match the filter criteria', () => {
      movies.forEach(movie => movieRepository.add(movie));
      const genres = ['Action', 'Drama'];
      const mpaa_rating = 'PG-13';
      const start_release_year = 2005;
      const last_release_year = 2015;

      const filteredMovies = movieRepository.getFilteredMovies(genres, mpaa_rating, start_release_year, last_release_year);

      expect(filteredMovies).toHaveLength(1);
      expect(filteredMovies[0].title).toBe('Movie 1');
    });

    it('should return an empty array if no movies match the filter criteria', () => {
      movies.forEach(movie => movieRepository.add(movie));
      const genres = ['Comedy', 'Drama'];
      const mpaa_rating = 'R';
      const start_release_year = 2000;
      const last_release_year = 2010;

      const filteredMovies = movieRepository.getFilteredMovies(genres, mpaa_rating, start_release_year, last_release_year);

      expect(filteredMovies).toHaveLength(0);
    });
  });

  describe('findMovies', () => {
    it('should return movies that match the search criteria', async () => {
      await movieRepository.populateMoviesRepositoryFromCSV();
      expect(movieRepository.getAllMovies().length).toBe(651);
      const form = new MovieSearchForm();
      form.title = "";
      form.director = "";
      form.mpaa_rating = "";
      form.actor1 = "";
      form.actor2 = "";
      form.actor3 = "";
      form.genre = "Drama";
      form.approximate_runtime = false;
      form.runtime = 80;
      form.release_year_start = 2013;
      form.release_year_end = 2013;
      form.imdb_rating = 5.5;
      form.critics_score = 45;
      form.approximate_release_year = false;
      const searchMovies = movieRepository.findMovies(form);

      expect(searchMovies).toHaveLength(1);
      expect(searchMovies[0].title).toBe('Filly Brown');
    });

  });

});
