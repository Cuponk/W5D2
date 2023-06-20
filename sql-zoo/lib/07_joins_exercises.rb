# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery';
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
  select m.title
  from  movies as m 
  join castings  on castings.movie_id = m.id
  join actors as act on act.id = castings.actor_id
  where act.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the starring
  # role. [Note: The ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role.]
  execute(<<-SQL)
  select m.title
  from  movies as m 
  join castings  on castings.movie_id = m.id
  join actors as act on act.id = castings.actor_id
  where act.name = 'Harrison Ford' and castings.ord > 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
  select m.title, act.name
  from  movies as m 
  join castings  on castings.movie_id = m.id
  join actors as act on act.id = castings.actor_id
  where yr = 1962 and castings.ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
  select m.yr, count(*)
  from  movies as m 
  join castings  on castings.movie_id = m.id
  join actors as act on act.id = castings.actor_id
  where act.name = 'John Travolta' 
  group by m.yr
  having count(*) >= 2
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
  select m2.title, act2.name
  from  movies as m2 
  join castings as ca on ca.movie_id = m2.id
  join actors as act2 on act2.id = ca.actor_id
 where ca.ord = 1 and m2.id in
  (select m.id
--  select m.title, act.name
  from  movies as m 
  join castings  on castings.movie_id = m.id
  join actors as act on act.id = castings.actor_id
  where act.name = 'Julie Andrews' )
  
 --and castings.ord > 1
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
  select act.name
  from  movies as m 
  join castings  on castings.movie_id = m.id
  join actors as act on act.id = castings.actor_id
  where castings.ord = 1
  group by act.name
  having count(*) >= 15
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
  SQL
end