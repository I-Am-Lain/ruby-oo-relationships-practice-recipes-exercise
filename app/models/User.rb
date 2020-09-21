require_relative "RecipeCard.rb"
require_relative "Recipe.rb"
require_relative "RecipeIngredient.rb"
require_relative "Ingredient.rb"
require_relative "Allergy.rb"


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
        the_recipe.date = date
        the_recipe.rating = rating
    end

    

end


user1 = User.new("Will")
user2 = User.new("Kyle")

broccoli = Ingredient.new("broccoli")
tomato = Ingredient.new("tomato")
milk = Ingredient.new("milk")

tomato_soup = Recipe.new("Tomato Soup")
broccoli_soup = Recipe.new("Broccoli Soup")

wills_tomato_soup_recipe = RecipeCard.new(user1, tomato_soup)
kyles_tomato_soup_recipe = RecipeCard.new(user2, tomato_soup)
wills_broccoli_soup_recipe = RecipeCard.new(user1, broccoli_soup)

puts user1.name

puts wills_tomato_soup_recipe.recipe.name
puts "---------"
puts Recipe.most_popular
puts "---------"
puts tomato_soup.users
puts "------"
tomato_soup_ingredient_1 = RecipeIngredient.new(tomato_soup, tomato)
tomato_soup_ingredient_2 = RecipeIngredient.new(tomato_soup, milk)

allergy1 = Allergy.new(user1, tomato)
puts allergy1.user
puts allergy1.ingredient
puts "??????????????????"
puts tomato_soup.allergens
puts "---------------------"
butter = Ingredient.new("butter")
flour = Ingredient.new("flour")


tomato_soup.add_ingredient([butter, flour])
puts RecipeIngredient.all
puts "---------"
user2.add_recipe_card(broccoli_soup, "6/6/666", 5)
puts user2.recipes