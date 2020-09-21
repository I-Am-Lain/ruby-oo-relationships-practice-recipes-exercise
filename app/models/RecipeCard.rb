class RecipeCard

    attr_reader :user, :recipe
    attr_accessor :date, :rating

    @@all = []

    def initialize(user, recipe)
        @user = user
        @recipe = recipe
        @@all << self
    end

    def self.all
        @@all
    end

end

