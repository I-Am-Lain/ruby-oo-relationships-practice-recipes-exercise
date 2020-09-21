class Recipe

    attr_reader :name

    @@all = []

    def initialize(name)
        @name = name
        @@all << self
    end

    def self.all
        @@all
    end

    def find_ingredients
        RecipeIngredient.all.select do |ri|
            ri.recipe == self
        end
    end

    def find_all_recipes      ##helper
        RecipeCard.all.select do |rc|
            rc.recipe == self
        end
    end

    def all_recipes_count     ##helper
        find_all_recipes.count
    end

    def ingredients
        find_ingredients.map do |i|
            i.ingredient
        end
    end

    def self.most_popular
        all.max_by {|recipe| recipe.all_recipes_count}.name
    end

    def users
        find_all_recipes.map do |rc|
            rc.user
        end
    end

    def allergens
        Allergy.all.map do |a|
            if ingredients.include?(a.ingredient)
                a.ingredient
            end
        end
    end

    def add_ingredient(ing)
        ing.each do |i|
            RecipeIngredient.new(self, i)
        end
    end
end
