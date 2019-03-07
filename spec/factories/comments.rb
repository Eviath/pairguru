FactoryBot.define do

  factory :comment do
    content { Faker::Lorem.sentence(3, true) }
    user_id User.last.id
    movie_id Movie.last.id
    movie
    factory :invalid_comment do
      content nil
      user_id User.last.id
      movie_id Movie.last.id
      movie
    end
  end
end
