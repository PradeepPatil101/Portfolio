import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomepageComponent } from './components/homepage/homepage.component';
import { MovieUpdateComponent } from './components/movie-update/movie-update.component';
import { RecommendationComponent } from './components/recommendation/recommendation.component';
import { MovieSearchComponent } from './components/movie-search/movie-search.component';

const routes: Routes = [
  { path: '', redirectTo: '/homepage', pathMatch: 'full'},
  { path: 'homepage', component: HomepageComponent },
  { path: 'recommendation', component: RecommendationComponent },
  { path: 'update-movies', component: MovieUpdateComponent},
  { path: 'search-movies', component: MovieSearchComponent},
  { path: '**', redirectTo: '/homepage', pathMatch: 'full' } // catch-all for erroneous links
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
