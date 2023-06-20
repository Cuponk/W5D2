# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# A note on subqueries: you can refer to values in the outer SELECT within the
# inner SELECT. You can name the tables so that you can tell the difference
# between the inner and outer versions.

def example_select_with_subquery
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      population > (
        SELECT
          population
        FROM
          countries
        WHERE
          name='Romania'
      );
  SQL
end

def larger_than_russia
  # List each country name where the population is larger than 'Russia'.
  execute(<<-SQL)
    select name from countries
    where population > (
      SELECT
        population
      FROM
        countries
      WHERE
        name='Russia');
  SQL
end

def richer_than_england
  # Show the countries in Europe with a per capita GDP greater than
  # 'United Kingdom'.
  execute(<<-SQL)
  select name from countries
  where continent = 'Europe' and gdp/population > (
    SELECT
      gdp/population
    FROM
      countries
    WHERE
      name='United Kingdom');
  SQL
end

def neighbors_of_certain_b_countries
  # List the name and continent of countries in the continents containing
  # 'Belize', 'Belgium'.
  execute(<<-SQL)
    select name, continent from countries
    where continent in (
      SELECT
        continent
      FROM
        countries
      WHERE
        name in ('Belize' , 'Belgium')
    );
  SQL
end

def population_constraint
  # Which country has a population that is more than Canada but less than
  # Poland? Show the name and the population.
  execute(<<-SQL)
  select name, population from countries
  where population > (
    SELECT
      population
    FROM
      countries
    WHERE
      name = 'Canada') and population < (
        SELECT
        population
      FROM
        countries
      WHERE
        name = 'Poland');
  SQL
end

def sparse_continents
  # Find every country that belongs to a continent where each country's
  # population is less than 25,000,000. Show name, continent, and
  # population.
  # Hint: Sometimes rewording the problem can help you see the solution.
  execute(<<-SQL)
  select name, continent, population from countries where continent =
  (select continent from countries
  group by continent having max(population) < 25000000);
  SQL
end