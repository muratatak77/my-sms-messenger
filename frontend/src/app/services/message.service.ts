// src/app/services/message.service.ts
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../environments/environment';

@Injectable({ providedIn: 'root' })
export class MessageService {
  private apiUrl = `${environment.apiUrl}/messages`;

  constructor(private http: HttpClient) {}

  getMessages() {
    return this.http.get(this.apiUrl);
  }

  sendMessage(body: any) {
    return this.http.post(this.apiUrl, { body: body.content });
  }
}
