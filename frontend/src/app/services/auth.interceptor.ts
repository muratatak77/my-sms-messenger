// src/app/services/auth.interceptor.ts
import { HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { catchError } from 'rxjs/operators';
import { throwError } from 'rxjs';

export const AuthInterceptor: HttpInterceptorFn = (req, next) => {
  const token = localStorage.getItem('token');
  const router = inject(Router);

  const authReq = token
    ? req.clone({
        headers: req.headers.set('Authorization', `Bearer ${token}`)
      })
    : req;

  return next(authReq).pipe(
    catchError((error) => {
      if (error.status === 401) {
        localStorage.removeItem('token');     // Token'ı temizle
        router.navigate(['/login']);          // Login sayfasına yönlendir
      }
      return throwError(() => error);
    })
  );
};
