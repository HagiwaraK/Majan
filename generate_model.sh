bundle install

# たぶんここら辺でエラー出る
createuser -P

createdb Majan_development
createdb Majan_test
createdb Majan_production

# database.yml編集してね
# defaultの欄のusername, password変更すればいい

# ここまで終わったら下のコマンド叩いてね
# bundle exec rake db:migrate
# bundle exec rake db:seed