# Пример простого Rails приложения с webpacker и Vue.js
![Rails worked with vue](https://github.com/multpix/rails-wp-vue/raw/master/rails-wp-vue.png)
Инициализация приложения
```bash
rails new rails-wp-vue --webpack=vue
```

В приложении присутствует пример конструктора vue и однофайловый компонент

Для удобства компонент перенесен в каталог `javascript/components`

Имя точки входа изенено на `packs/vue.js`

Для примера созданна главная страница `rails g controller front index`

В корневой шаблон `layouts/application.erb` добавленны вызовы:
```erb
<%= javascript_pack_tag 'vue' %>
<%= stylesheet_pack_tag 'vue' %>
```
убран turbolinks (который так-же удален из `Gemfile`,
и из `app/assets/javascript/application.js`)

В `Gemfile` добавлен `gem 'foreman'`

Создан `Procfile`
```ruby
web: bundle exec rails s
webpacker: ./bin/webpack-dev-server
```

Запуск приложения:
```bash
foreman start
```

Теперь работающее приложение доступно по адресу `http://localhost:5000`

При изменении и сохранении js происходит перезагрузка соответсвующей вкладки браузера

Для добавления js пакетов `./bin/yarn add stylus stylus-loader pug pug-loader`

Соответсвующие загрузчики в `config/webpacker/loaders`:
```javascript
# config/webpack/loaders/pug.js

module.exports = {
  test: /\.(pug|jade)$/,
  loader: 'pug-loader'
}
const ExtractTextPlugin = require('extract-text-webpack-plugin')

# config/webpack/loaders/stylus.js
module.exports = {
  test: /\.styl$/i,
  use: ExtractTextPlugin.extract({
    fallback: 'style-loader',
    use: ['css-loader', 'postcss-loader', 'stylus-loader']
  })
}
```

Использование в однофайловом компоненте:
```vue
# app/javascript/components/app.vue

<template lang="pug">
  #sample_vue_app
    p
      |{{ message }}
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style lang="stylus" scoped>
p
  font-size: 2em
  text-align: center
</style>
```

Дополнение для удобства разработки и отладки:
[Vue.js devtools](https://chrome.google.com/webstore/detail/vuejs-devtools/nhdogjmejiglipccpnnnanhbledajbpd)

Выгрузка на Heroku
```
heroku create rails-wp-vue
heroku buildpacks:add --index 1 heroku/nodejs --app rails-wp-vue
heroku buildpacks:add --index 2 heroku/ruby --app rails-wp-vue
heroku addons:create heroku-postgresql:hobby-dev --app rails-wp-vue
git add -A && git commit -m "deploy" && git push heroku master
heroku open && heroku logs --tail
```
