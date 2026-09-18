# 📚 Bookshelf

iOS-приложение для ведения личной библиотеки: хранение информации о прочитанных книгах, планируемых к прочтению, а также заметок к ним.

---

## 📱 О приложении

**Bookshelf** — это нативное iOS-приложение, написанное на Swift, которое позволяет:

- 📖 Добавлять книги в свою библиотеку с обложкой и описанием
- 🔍 Искать книги через Open Library API по названию
- 🤖 Автоматически генерировать описание книги с помощью AI (GPT-4o через BotHub)
- 🏷️ Отслеживать статус чтения: **Читаю**, **Прочитать**, **Прочитал**
- 📝 Вести заметки к каждой книге (с возможностью свайпа для удаления)
- 🎨 Выбирать обложку из фото-галереи или использовать обложку из Open Library
- 🗑️ Удалять книги вместе со всеми заметками и файлами обложек

---

## 🏗️ Архитектура

Проект построен на **MVP (Model-View-Presenter)** с разделением на модули. Для UI используется **SwiftUI**, обёрнутый в `UIHostingController` и встроенный в UIKit-навигацию.

### Ключевые слои

```
bookshelf/
├── Builder/                    # Фабрика для сборки модулей
├── DataBaseManager/            # Core Data + работа с файловой системой
│   ├── Manager/                # DataBaseManager (синглтон)
│   └── Model/                  # Book, Note (NSManagedObject)
├── Fonts/                      # Шрифты Jost + FontManager
├── Helper/                     # Утилиты
│   ├── BookStatus/             # Enum статусов книги
│   ├── Button/                 # Кастомные кнопки
│   ├── Extension/              # Расширения (Image, View, String, Notification)
│   ├── ImagePicker/            # UIImagePickerController wrapper
│   ├── Modifiers/              # Custom Font modifier
│   └── View/                   # Базовые UI-компоненты
├── Lottie/                     # Анимация загрузки
├── Module/                     # Экраны приложения (MVP-модули)
│   ├── AddBookView/            # Поиск книг
│   ├── AddDetailsView/         # Добавление деталей книги
│   ├── BookListView/           # Список найденных книг
│   ├── DetailsView/            # Детали книги + заметки
│   ├── MainView/               # Главный экран
│   ├── Onboarding/             # Онбординг
│   ├── PreviewView/            # Заставка с Lottie
│   └── RegistView/             # Ввод имени пользователя
├── StorageManager/             # Сохранение обложек в файловую систему
├── AppDelegate.swift
└── SceneDelegate.swift
```

### Каждый модуль содержит

- **View** — `UIViewController` + SwiftUI `Content`
- **Presenter** — бизнес-логика, протокол + реализация
- **Model** — (при необходимости) DTO-модели
- **NetworkManager** — (при необходимости) сетевой слой

---

## 🛠️ Технологии

| Технология | Назначение |
|------------|------------|
| **Swift** | Язык разработки |
| **UIKit + SwiftUI** | Гибридный UI |
| **Core Data** | Локальное хранение книг и заметок |
| **FileManager** | Сохранение обложек в Documents |
| **URLSession** | Сетевые запросы |
| **Lottie** | Анимация на заставке |
| **SDWebImage / SDWebImageSwiftUI** | Загрузка обложек из сети |
| **Open Library API** | Поиск книг |
| **BotHub Chat API (GPT-4o)** | Генерация описаний книг |

---

## 📦 Зависимости (SPM)

- [Lottie](https://github.com/airbnb/lottie-ios) `4.6.0`
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) `5.21.7`
- [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) `3.1.4`

---

## 🚀 Запуск проекта

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/<your-username>/bookshelf.git
   cd bookshelf
   ```
2. Откройте `bookshelf.xcodeproj` в Xcode (рекомендуется Xcode 15+).
3. Дождитесь загрузки пакетов через Swift Package Manager.
4. Укажите свой токен **BotHub Chat API** в файле `NetworkManager.swift`:
   ```swift
   let token = "<YOUR_TOKEN>"
   ```
5. Запустите проект на симуляторе или устройстве (iOS 16+).

---

## 🔄 Флоу пользователя

```
PreviewView (Lottie-анимация)
        │
        ▼
   ┌─────────────┐
   │ Первый вход?│
   └──────┬──────┘
    Да    │    Нет
    ▼     │     ▼
RegistView     OnboardingView
    │               │
    └───────┬───────┘
            ▼
         MainView
            │
      ┌─────┼─────┐
      ▼     ▼     ▼
   AddBook  Details  AddDetails
   (поиск)  (книга)  (сохранение)
      │
      ▼
  BookListView
```

---

## 💾 Хранение данных

- **Core Data** (`db.xcdatamodeld`):
  - `Book` — `id`, `name`, `author`, `status` (Int16), `bookDescription`, `coverURL`, `date`, relationship `notes`
  - `Note` — `id`, `text`, `date`, relationship `book`
- **Файловая система** (`Documents/<bookId>/cover.jpeg`) — обложки книг
- **UserDefaults** — имя пользователя и текущее состояние окна (`state`)

---

## 📡 Используемые API

### Open Library (поиск книг)

```
GET https://openlibrary.org/search.json
    ?q=<название>
    &fields=title,author_name,cover_i,...
    &lang=ru
```

### Open Library (обложки)

```
https://covers.openlibrary.org/b/id/<cover_i>-M.jpg
```

### BotHub Chat (описание книги)

```
POST https://bothub.chat/api/v2/openai/v1/chat/completions
Body: { "model": "gpt-4o", "messages": [...] }
```

---

## 📌 Возможные улучшения

- [ ] Синхронизация между устройствами (CloudKit)
- [ ] Экспорт/импорт библиотеки
- [ ] Сортировка и фильтрация книг
- [ ] Напоминания о чтении
- [ ] Статистика прочитанного
- [ ] Локализация (EN)
- [ ] Написание тестов (Unit + UI)

---

## 👤 Автор

**Егор Халиков**

---

## 📄 Лицензия

Проект распространяется под лицензией MIT. См. файл `LICENSE`.
