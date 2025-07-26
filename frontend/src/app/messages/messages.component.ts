import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, NgForm } from '@angular/forms';
import { MessageService } from '../services/message.service';
import { AuthService } from '../services/auth.service';

@Component({
  selector: 'app-messages',
  standalone: true,
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.scss'],
  imports: [CommonModule, FormsModule]
})
export class MessagesComponent implements OnInit, OnDestroy {
  phoneNumber: string = '18777804236';
  message: string = '';
  messages: any[] = [];
  pollInterval: any = null;
  pollCount: number = 0;
  readonly MAX_POLLS = 10;

  constructor(
    private messageService: MessageService,
    private authService: AuthService
  ) { }

  ngOnInit(): void {
    this.loadMessages();
  }

  ngOnDestroy(): void {
    this.stopPolling();
  }

  logout(): void {
    this.authService.logout();
  }

  loadMessages(): void {
    this.messageService.getMessages().subscribe({
      next: (data: any) => this.messages = data,
      error: (err: any) => console.error('Failed to load messages', err)
    });
  }

  messageError: boolean = false;

  submitMessage(): void {
    if (!this.message || !this.message.trim()) {
      this.messageError = true;
      return;
    } else {
      this.messageError = false;
    }

    const body = { phoneNumber: this.phoneNumber, content: this.message };
    this.messageService.sendMessage(body).subscribe({
      next: () => {
        this.clear();
        this.loadMessages();
        this.startPolling();
      },
      error: (err: any) => console.error('Failed to send message', err)
    });
  }

  clear(): void {
    this.message = '';
    this.messageError = false;
  }

  startPolling(): void {
    if (this.pollInterval) return;

    this.pollCount = 0;

    this.pollInterval = setInterval(() => {
      const pending = this.messages.filter(
        m => m.status !== 'delivered' && m.status !== 'failed'
      );

      this.pollCount++;
      console.log(`Polling #${this.pollCount}`, { pending });

      if (pending.length > 0) {
        this.loadMessages();
      }

      if (pending.length === 0 || this.pollCount >= this.MAX_POLLS) {
        this.stopPolling();
      }
    }, 5000);
  }

  stopPolling(): void {
    if (this.pollInterval) {
      clearInterval(this.pollInterval);
      this.pollInterval = null;
      this.pollCount = 0;
    }
  }
}
