import { ComponentFixture, TestBed, fakeAsync, tick } from '@angular/core/testing';
import { HttpClientModule } from '@angular/common/http';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { HomepageComponent } from './homepage.component';
import { MovieService } from 'src/app/services/movie.service';
import { of } from 'rxjs';

describe('HomepageComponent', () => {
  let component: HomepageComponent;
  let fixture: ComponentFixture<HomepageComponent>;
  let formBuilder: FormBuilder;
  let router: Router;
  let movieService: MovieService;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HttpClientModule],
      declarations: [ HomepageComponent ],
      providers: [
        FormBuilder,
        {
          provide: Router,
          useValue: {
            navigate: jasmine.createSpy('navigate')
          }
        },
        {
          provide: MovieService,
          useValue: {
            setMovieRecommendations: jasmine.createSpy('setMovieRecommendations').and.returnValue(of(null))
          }
        }
      ]
    })
    .compileComponents();

    formBuilder = TestBed.inject(FormBuilder);
    router = TestBed.inject(Router);
    movieService = TestBed.inject(MovieService);

    fixture = TestBed.createComponent(HomepageComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should initialize formPage to 0', () => {
    expect(component.formPage).toEqual(0);
  });

  describe('showNextFormPage', () => {
    it('should increment formPage by 1', () => {
      const initialFormPage = component.formPage;
      component.showNextFormPage();
      expect(component.formPage).toEqual(initialFormPage + 1);
    });
  });

  describe('showLastFormPage', () => {
    it('should decrement formPage by 1', () => {
      component.formPage = 1;
      const initialFormPage = component.formPage;
      component.showLastFormPage();
      expect(component.formPage).toEqual(initialFormPage - 1);
    });
  });

  describe('onSubmit', () => {
    it('should increment formPage by 1', fakeAsync(() => {
      const initialFormPage = component.formPage;
      component.onSubmit();
      tick(1500);
      expect(component.formPage).toEqual(initialFormPage + 1);
    }));

    it('should call setMovieRecommendations on movieService with form value', fakeAsync(() => {
      const formValue = { occasion: 'birthday', emotion: 'happy', start_release_year: null, last_release_year: null, mpaa_rating: 'PG' };
      component.movieRecForm.setValue(formValue);
      component.onSubmit();
      tick(1500);
      expect(movieService.setMovieRecommendations).toHaveBeenCalledWith(JSON.stringify(formValue));
    }));
    

    it('should navigate to recommendation page after 1.5 seconds', fakeAsync(() => {
      component.onSubmit();
      tick(1500);
      expect(router.navigate).toHaveBeenCalledWith(['/recommendation']);
    }));
  });
});
