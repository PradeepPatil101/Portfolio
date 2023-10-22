import { Component } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { MovieService } from 'src/app/services/movie.service';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.css']
})
export class HomepageComponent {
    formPage: number;

    movieRecForm = this.formBuilder.group({
        occasion: '',
        emotion: '',
        start_release_year: null, 
        last_release_year: null,
        mpaa_rating: ''
    })

    constructor(private formBuilder: FormBuilder,
                private router: Router,
                private movieService: MovieService) {
        this.formPage = 0; // indicates no form page should be shown
    }

    /** Hides the currently visible form page (if there is one) and shows the next */
    showNextFormPage(): void {
        this.formPage++;
    }

    /** Hides the currently visible form page (if there is one) and shows the next */
    showLastFormPage(): void {
        this.formPage--;
    }

    /** Submits the form info */
    onSubmit(): void {
        this.formPage++;

        // Make a request to the movie service using the form input
        this.movieService.setMovieRecommendations(JSON.stringify(this.movieRecForm.value));

        // Sleep then navigate to the recommendation page
        setTimeout(() => 
        {
            this.router.navigate(['/recommendation']);
        },
        1500);
    }
}
