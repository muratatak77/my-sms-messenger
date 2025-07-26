import { Routes } from '@angular/router';
import { LoginComponent } from './auth/login.component';
import { MessagesComponent } from './messages/messages.component';

export const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'messages', component: MessagesComponent }
];
