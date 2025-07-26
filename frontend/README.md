# Frontend

This project was generated using [Angular CLI](https://github.com/angular/angular-cli) version 20.1.3.

## Development server

To start a local development server, run:

```bash
ng serve
```

Once the server is running, open your browser and navigate to `http://localhost:4200/`. The application will automatically reload whenever you modify any of the source files.

## Code scaffolding

Angular CLI includes powerful code scaffolding tools. To generate a new component, run:

```bash
ng generate component component-name
```

For a complete list of available schematics (such as `components`, `directives`, or `pipes`), run:

```bash
ng generate --help
```

## Building

To build the project run:

```bash
ng build
```

This will compile your project and store the build artifacts in the `dist/` directory. By default, the production build optimizes your application for performance and speed.

## Running unit tests

To execute unit tests with the [Karma](https://karma-runner.github.io) test runner, use the following command:

```bash
ng test
```

## Running end-to-end tests

For end-to-end (e2e) testing, run:

```bash
ng e2e
```

Angular CLI does not come with an end-to-end testing framework by default. You can choose one that suits your needs.

## Additional Resources

For more information on using the Angular CLI, including detailed command references, visit the [Angular CLI Overview and Command Reference](https://angular.dev/tools/cli) page.



Aşağıya, projeyi **production ortamına nasıl deploy edeceğinizi** genel ve sade şekilde anlatan İngilizce bir bölüm ekliyorum. Bu açıklama Heroku’ya özel değil, herhangi bir platformda production deploy yapmak isteyenler için uygundur:

---

## Deploying to Production

To deploy this Angular application to a production environment, follow the steps below:

### 1. Build the Project for Production

Run the following command to generate an optimized build:

```bash
ng build --configuration=production
```

This will compile and bundle your application into static HTML, CSS, and JavaScript files. The output will be stored in the `dist/` directory, typically at:

```
dist/frontend/browser/
```

> Ensure the `outputPath` in `angular.json` matches the actual folder if you’ve changed the project name or structure.

---

### 2. Serve the Build with a Static Web Server

The contents of the `dist/frontend/browser/` directory can be hosted on any static file server. You can use platforms or services such as:

* **Netlify**
* **Vercel**
* **GitHub Pages**
* **Firebase Hosting**
* **Amazon S3 + CloudFront**
* **Apache/Nginx**
* **Docker containers**
* **Custom Node.js/Express server**

Upload the files or point your server to this directory depending on your hosting solution.

---

### 3. Configure Route Handling (for Angular Routing)

If your app uses Angular’s client-side routing (e.g., `path: '**'`), make sure your production server is configured to redirect all non-file routes to `index.html`. This is necessary so Angular can handle routing correctly.

For example, in an Nginx server:

```nginx
location / {
  try_files $uri $uri/ /index.html;
}
```

---

### 4. Environment Configuration

Before deploying, make sure your app uses the correct environment variables and API URLs by setting them in `src/environments/environment.prod.ts`. Then rebuild the app with the production config:

```bash
ng build --configuration=production
```

---

With these steps completed, your Angular app will be ready to run efficiently in a production environment.

---

İstersen bu açıklamanın Türkçe versiyonunu da sağlayabilirim.
