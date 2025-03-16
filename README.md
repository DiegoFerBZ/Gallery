# 📱 Gallery App

Aplicación Flutter para gestión de productos con autenticación y almacenamiento en Firebase.

## 🚀 Características

- Autenticación con Firebase (Google, Email/Contraseña, etc.).
- Subida y almacenamiento de imágenes en Firebase Storage.
- Gestión de productos con Firestore.
- Interfaz moderna y responsiva.

## 🛠 Requisitos

- Flutter 3.0+
- Dispositivo/Emulador Android/iOS
- Cuenta Firebase (para funciones en la nube)

## 🔧 Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/gallery-app.git
   cd gallery-app
   ```
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Configura Firebase:
   - Crea un nuevo proyecto en [Firebase Console](https://console.firebase.google.com/).
   - Agrega la configuración para Android/iOS.
   - Descarga y coloca los archivos `google-services.json` (Android) y `GoogleService-Info.plist` (iOS) en las rutas adecuadas.
4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## 📂 Estructura del Proyecto

```
/gallery-app
│-- lib/
│   │-- main.dart  # Punto de entrada de la aplicación
│   │-- screens/   # Pantallas de la aplicación
│   │-- widgets/   # Componentes reutilizables
│   │-- services/  # Servicios para Firebase y otros
│-- pubspec.yaml  # Dependencias del proyecto
│-- android/      # Configuración Android
│-- ios/          # Configuración iOS
```

## 📝 Tecnologías Utilizadas

- [Flutter](https://flutter.dev/)
- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Firebase Firestore](https://firebase.google.com/docs/firestore)
- [Firebase Storage](https://firebase.google.com/docs/storage)

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para contribuir:

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature-nueva-funcionalidad`).
3. Realiza tus cambios y haz commit (`git commit -m 'Agregar nueva funcionalidad'`).
4. Sube tus cambios (`git push origin feature-nueva-funcionalidad`).
5. Abre un Pull Request.

---

*Hecho con ❤️ usando Flutter.*

