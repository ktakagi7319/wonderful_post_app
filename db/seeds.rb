# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

tags = ["タグ1","タグ2","タグ3"]
for tag in tags do
  Tag.find_or_create_by!(name: tag)
end

3.times do |num|
  num += 1
  set_user = sprintf("user%03d@gmail.com", num)
  set_pwd = "test123"
  user = User.find_or_create_by!(email: set_user) do |_user|
    _user.password = set_pwd
  end

  50.times do |num2|
    num2 += 1
    number_3 = sprintf("%03d",num2)
    set_title = "No.#{num2}: user#{number_3}の記事"
    set_content = "No.#{num2}: user#{number_3}の記事の本文"
    user.articles.find_or_create_by!(title:set_title) do |article|
      article.content = set_content
    end

    article_number = user.articles.find_by!(title: set_title,user_id: num).id
    for tag_num in 1..tags.size do
      ArticleTag.create!(article_id: article_number, tag_id: tag_num)
    end

  end

end
