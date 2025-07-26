import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Router } from '@angular/router'; // yönlendirme için ekle
import { environment } from '@env/environment';

@Injectable({ providedIn: 'root' })
export class AuthService {
  constructor(private http: HttpClient, private router: Router) {}

  login(username: string, password: string) {
    return this.http.post<any>(`${environment.apiUrl}/login`, { username, password });
  }

  logout() {
    localStorage.removeItem('token');
    this.router.navigate(['/login']); // giriş ekranına yönlendir
  }
}
