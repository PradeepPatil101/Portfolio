export class MovieSearchForm {
    title: string = "";
    genre: string = "";
    runtime: number | null = 0;
    mpaa_rating: string = "";
    release_year_start: number | null = 0;
    release_year_end: number | null = 0;
    imdb_rating: number | null = 0;
    critics_score: number | null = 0;
    director: string = "";
    actor1: string = "";
    actor2: string = "";
    actor3: string = "";
    approximate_runtime: boolean = false;
    approximate_release_year: boolean = false;
  }