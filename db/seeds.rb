# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Creating Users'
[
  %w[Squirrelly Potato],
  %w[Galactic Plastic]
].each do |first, last|
  User.create(first_name: first, last_name: last)
end

puts 'Creating Authors'
[
  ['Joss', 'Whedon', 'Serenity', 'quotes/18015.Joss_Whedon', %w[Sci-Fi Fantasy]],
  ['Glen', 'Larson', 'Starbuck', 'show/272641.Glen_A_Larson', %w[Sci-Fi]],
  ['Rockne S.', 'O\'Bannon', 'Zhaan', 'show/293734.Rockne_S_O_Bannon', %w[Sci-Fi]]
].each do |first, last, blurb, web, genres|
  Author.create(first_name: first,
                last_name: last,
                description: blurb,
                website: "https://www.goodreads.com/author/#{web}",
                genres: genres)
end

puts 'Creating Books'
[
  ['Firefly: Legacy Edition: Book One', 'Dark Horse Comics', DateTime.strptime('07/12/2021 8:00', '%m/%d/%Y %H:%M'), 1],
  ['The Tombs of Kobol', 'BSG', DateTime.strptime('07/12/2021 8:00', '%m/%d/%Y %H:%M'), 2],
  ['Farscape Omnibus Vol. 1', 'Scorpius', DateTime.strptime('07/12/2021 8:00', '%m/%d/%Y %H:%M'), 3]
].each do |title, blurb, date, author|
  Book.create(title: title,
              description: blurb,
              publish_date: date,
              author_id: author)
end
