require_relative "RecipeCard.rb"
require_relative "Recipe.rb"
require_relative "RecipeIngredient.rb"
require_relative "Ingredient.rb"
require_relative "Allergy.rb"

require 'date'
require 'pry'

class User

    attr_reader :name

    @@all = []

    def initialize(name)
        @name = name
        @@all << name

    end

    def self.all
        @@all
    end

    def find_all_my_recipes
        RecipeCard.all.select do |rc|
            rc.user == self
        end
    end

    def recipes
        find_all_my_recipes.map do |rc|
            rc.recipe
        end
    end

    def add_recipe_card(recipe, date, rating)
        the_recipe = RecipeCard.new(self, recipe)
        month, day, year = date.split("/")
        new_date = Date.new(year.to_i, month.to_i, day.to_i)
        the_recipe.date = new_date
        the_recipe.rating = rating
    end

    def declare_allergy(ingredient)
        Allergy.new(self, ingredient)
    end
    
    def allergens
        Allergy.all.select do |a|
            a.user == self
        end.map {|all| all.ingredient}
    end

    def top_three_recipes
        find_all_my_recipes.sort_by {|rc| -rc.rating}   ##### negative number
    end

    def most_recent_recipe
        find_all_my_recipes.sort_by {|rc| rc.date.to_s}.first
    end

    def safe_recipes
        unsafe = []
        safe = []  # <--- rp.recipes
        Recipe.all.each do |rp|
            rp.ingredients.each do |ing|
                unless allergens.include? (ing)
                    safe << rp
                else
                    unsafe << rp
                end
            end
        end
        safe.uniq - unsafe
    end

end


# user1 = User.new("Will")
# user2 = User.new("Kyle")


# broccoli = Ingredient.new("broccoli")
# tomato = Ingredient.new("tomato")
# milk = Ingredient.new("milk")
# butter = Ingredient.new("butter")
# flour = Ingredient.new("flour")
# chips = Ingredient.new("chips")

# tomato_soup = Recipe.new("Tomato Soup")
# broccoli_soup = Recipe.new("Broccoli Soup")
# butter_flour_soup = Recipe.new("Butter Flour Soup")
# donkey_chips = Recipe.new("Donkey Chips")

# wills_tomato_soup_recipe = RecipeCard.new(user1, tomato_soup)
# wills_tomato_soup_recipe.date = "1/2/12"
# kyles_tomato_soup_recipe = RecipeCard.new(user2, tomato_soup)
# kyles_tomato_soup_recipe.date = "12/28/2008"
# wills_broccoli_soup_recipe = RecipeCard.new(user1, broccoli_soup)
# wills_thing = RecipeCard.new(user1, butter_flour_soup)
# wills_thing.date = "9/14/1997"
# wills_a_donkey = RecipeCard.new(user1, donkey_chips)
# wills_a_donkey.date = "1/1/12"

# puts user1.name

# puts wills_tomato_soup_recipe.recipe.name
# puts "---------"
# puts Recipe.most_popular
# puts "---------"
# puts tomato_soup.users
# puts "------"
# tomato_soup_ingredient_1 = RecipeIngredient.new(tomato_soup, tomato)
# tomato_soup_ingredient_2 = RecipeIngredient.new(tomato_soup, milk)
# butter_flour_soup_ing = RecipeIngredient.new(butter_flour_soup, butter)
# butter_flour_soup_ing2 = RecipeIngredient.new(butter_flour_soup, flour)
# donkey_chips_ing = RecipeIngredient.new(donkey_chips, chips)
# brocco_soup_ing = RecipeIngredient.new(broccoli_soup, broccoli)
# brocco_soup_ing2 = RecipeIngredient.new(broccoli_soup, milk)

# wills_tomato_soup_recipe.rating = 3
# wills_broccoli_soup_recipe.rating = 99
# wills_thing.rating = 12
# wills_a_donkey.rating = 100


# allergy1 = Allergy.new(user1, tomato)
# user1.declare_allergy(broccoli)
# user1.declare_allergy(chips)
# puts allergy1.user
# puts allergy1.ingredient
# puts "??????????????????"
# puts tomato_soup.allergens
# puts "---------------------"
# puts RecipeIngredient.all
# puts "---------"
# user2.add_recipe_card(broccoli_soup, "6/6/666", 5)

# puts user2.recipes
# puts user1.allergens
# puts user1.top_three_recipes
# puts wills_broccoli_soup_recipe
# puts "==================="
# puts "===================="
# puts kyles_tomato_soup_recipe.date
# wills_broccoli_soup_recipe.date = "6/6/666"
# puts "=========="
# puts wills_tomato_soup_recipe.date
# puts wills_broccoli_soup_recipe.date
# user1.find_all_my_recipes.each do |rc|
#     puts rc.recipe.name
#     puts rc.date
# end
# puts "=================="
# puts user1.most_recent_recipe.date
# puts "THE FINAL TEST"
# puts "VVVVVVVVVVVVVV"
# puts user1.safe_recipes
# puts "---"

# Recipe.all.each do |r|
#     puts "-----"
#     puts r.name
#     puts r
# end