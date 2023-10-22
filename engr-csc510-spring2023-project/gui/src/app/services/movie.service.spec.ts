import { TestBed } from '@angular/core/testing';
import { HttpClientModule } from '@angular/common/http';
import { MovieService } from '../mock_data/mock-movie-service';
import { Movie } from '../../../../common/movie';

describe('MovieService', () => {
  let service: MovieService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientModule],
      providers: [MovieService]
    });
    service = TestBed.inject(MovieService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should get all movies', (done: DoneFn) => {
    service.getAllMovies().subscribe(movies => {
      expect(movies.length).toBeGreaterThan(0);
      done();
    });
  });

  it('should set movie recommendations', (done: DoneFn) => {
    const movieReqString = 'Movie 1';
    service.setMovieRecommendations(movieReqString);
    setTimeout(() => {
      expect(service.getMovieRecommendations().length).toBeGreaterThan(0);
      expect(service.getStatusCode()).toEqual(200);
      done();
    }, 500);
  });

  it('should get movie poster link', (done: DoneFn) => {
    const imgId = 'some image id';
    service.getMoviePosterLink(imgId).subscribe(data => {
      expect(data).toBeTruthy();
      done();
    });
  });
  


  it('should find movies', (done: DoneFn) => {
    const body = 'some movie search body';
    service.findMovies(body).subscribe(response => {
      expect(response).toBeTruthy();
      done();
    });
  });
});

