# Стартер кит для фронтенд разработчика

Базовый набор инструментов для быстрого старта.
Завязан на Ruby + Node.js + Gulp

Включает в себя:
* [Bower] (http://bower.io/)
* [Sass] (https://ru.wikipedia.org/wiki/Sass)
* [CoffeeScript] (http://coffeescript.org/)
* [Jade] (http://jade-lang.com/)
* [Live Reload] (https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=ru)
* Servers (web + api)


## Подготовка окружения

Устанавливаем ruby пакеты
~~~bash
bundle install
~~~

Устанавливаем node.js  пакеты

~~~bash
npm install
~~~

Устанавливаем bower библиотеки

~~~bash
bower install
~~~

Запускаем build + watch

~~~bash
gulp
~~~

## Задача по умолчанию
Запускает:
* Компиляцию исходного кода
* Запуск серверов
* Запуск Live Reload
* Запуск мониторинга кода

~~~bash
	gulp
~~~

## Серверы и Live Reload
Сборка включает в себя два сервера для комфортной разработки.
Запуск серверов:

~~~bash
gulp servers
~~~


###  API сервер
Для иммитации ответов от реального сервера можно использовать апи-заглушку.
API сервер будет достапен на 3000 порту.
Пример запроса:

~~~bash
http://localhost:3000/accounts/all
~~~

Настроить маршруты и данные ответов можно в файле
~~~bash
/api-stub/routes.js
~~~


###  Web сервер
Для удобного просмотра результатов разработки + Live Reload странички после перекомпиляции кода следует использовать веб-сервер (8000 порт).
Пример запроса:

~~~bash
http://localhost:8000
~~~



## Билд проекта

~~~bash
	gulp build
~~~


## Запуск мониторинга исходного кода

~~~bash
	gulp watch
~~~

