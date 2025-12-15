# Very Simple Chat

Простой общий чат на Flutter с использованием Firebase.

## Функциональность
- Авторизация через Firebase Auth
- Общий чат в реальном времени
- Мультипользовательский режим
- Хранение истории сообщений
- Чистый интерфейс с Material Design

## Архитектура
```
BLoC Pattern + Clean Architecture
├── Presentation Layer (UI Widgets)
├── Business Logic Layer (BLoC)
├── Domain Layer (Contracts/Interfaces)
└── Data Layer (Services, Firebase)
```

## Технологии
- Flutter 3.x
- Firebase (Auth, Firestore)
- BLoC для state management
- Provider для dependency injection

## Структура проекта
```
lib/
├── main.dart
├── contracts/
│   └── contracts.dart
├── bloc/
│   ├── chat_bloc.dart
│   ├── chat_event.dart
│   └── chat_state.dart
├── models/
│   └── message.dart
├── services/
│   └── chat_services.dart
└── ui/
    ├── auth_page.dart
    └── chat_page.dart
```

## Важная информация
**Для безопасности проект не содержит конфигурационных файлов Firebase:**
- `android/app/google-services.json` - **ОТСУТСТВУЕТ** в репозитории
- Ключи API хранятся в переменных окружения
- Настройте свой Firebase проект для запуска

## Запуск проекта
1. **Клонируйте репозиторий:**
```bash
git clone https://github.com/FedorPRG/very_simple_chat.git
cd very_simple_chat
```

2. **Настройте Firebase:**

- Создайте проект в Firebase Console

- Добавьте Android приложение

- Скачайте google-services.json

- Поместите его в android/app/

3. **Включите сервисы в Firebase Console:**

- Authentication → Email/Password

- Firestore Database → создать базу в режиме тестирования

4. **Установите зависимости:**

```bash
flutter pub get
```
5. **Запустите приложение:**

```bash
flutter run
```
## Сборка APK
Для тестирования можно собрать релизную версию:

```bash
flutter build apk --release
```
APK файл будет создан в: build/app/outputs/flutter-apk/app-release.apk

## Безопасность
- API ключи не коммитятся в репозиторий

- Используется .gitignore для защиты чувствительных данных

- Рекомендуется использовать переменные окружения в production

**Примечание: Если хотите посмотреть рабочее приложение, могу предоставить APK файл. Конфигурационные данные Firebase не включены в репозиторий по соображениям безопасности.**