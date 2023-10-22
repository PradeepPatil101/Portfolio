import * as request from "request";


const base_url = "http://localhost:3000/";

describe("The server's Get Movies endpoint", () => {
  it("Checks that 651 movies are returned by the endpoint", (done) => {
    request.get(base_url + "movies", (error: Error | null, response: request.Response | null, body: string) => {
      expect(response?.statusCode).toBe(200);
      const movies = JSON.parse(body);

      const firstMovie = {
        title: 'Filly Brown',
        genre: 'Drama',
        runtime: '80',
        mpaa_rating: 'R',
        release_year: '2013',
        imdb_rating: '5.5',
        critics_score: '45',
        director: 'Michael D. Olmos',
        actor1: 'Gina Rodriguez',
        actor2: 'Jenni Rivera',
        actor3: 'Lou Diamond Phillips',
        actor4: 'Emilio Rivera',
        actor5: 'Joseph Julian Soria'
      };

      const lastMovie = {

        "actor1": "Miley Cyrus",
        "actor2": "Demi Moore",
        "actor3": "Ashley Greene",
        "actor4": "Douglas Booth",
        "actor5": "Adam G. Sevani",
        "critics_score": "17",
        "director": "Liza Azuelos",
        "genre": "Comedy",
        "imdb_rating": "4.2",
        "mpaa_rating": "PG-13",
        "release_year": "2012",
        "runtime": "97",
        "title": "LOL",

      };

      expect(movies.length).toEqual(651);
      expect(movies[0]).toEqual(firstMovie);
      expect(movies[650]).toEqual(lastMovie);

      done();
    });
  });
});

describe("The server's Post recmovies endpoint", () => {
  it("Returns status code 200 and a list of movies", (done) => {
    const requestData = {
      emotion: "Happy",
      occasion: "Date Night",
      mpaa_rating: "PG",
      start_release_year: 2000,
      last_release_year: 2022
    };

    request.post(
      base_url + "recmovies",
      { json: requestData },
      (error: Error | null, response: request.Response | null, body: string) => {
        expect(response?.statusCode).toBe(200);
        done();
      }
    );
  });

  it("Returns status code 204 if no movies are found", (done) => {
    const requestData = {
      emotion: "Happy",
      occasion: "Date Night",
      mpaa_rating: "PG-13",
      start_release_year: 1700,
      last_release_year: 1710
    };

    request.post(
      base_url + "recmovies",
      { json: requestData },
      (error: Error | null, response: request.Response | null, body: string) => {
        expect(response?.statusCode).toBe(204);
        expect(body).toEqual(undefined);
        done();
      }
    );
  });

  it("Returns status code 206 and a list of movies if none are found in the specified range, but some are found after expanding the range", (done) => {
    const requestData = {
      emotion: "Neutral",
      occasion: "Bored and Alone",
      mpaa_rating: "G",
      start_release_year: 2000,
      last_release_year: 2001
    };

    request.post(
      base_url + "recmovies",
      { json: requestData },
      (error: Error | null, response: request.Response | null, body: string) => {
        expect(response?.statusCode).toBe(206);
        done();
      }
    );
  });







  describe("The server's Post findMovies endpoint", () => {
    it("Returns status code 200 and a movie that was filtered", (done) => {
      const requestData = {
        title: "",
        director: "",
        mpaa_rating: "",
        actor1: "",
        actor2: "",
        actor3: "",
        genre: "Drama",
        runtime: 80,
        release_year: 2013,
        imdb_rating: 5.5,
        critics_score: 45
      };

      request.post(
        base_url + "findMovies",
        { json: requestData },
        (error: Error | null, response: request.Response | null, body: string) => {
          expect(response?.statusCode).toBe(200);
          done();
        }
      );
    });
  });

});


