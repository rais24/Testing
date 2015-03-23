# == Schema Information
#
# Table name: recipes
#
#  id                 :integer          not null, primary key
#  name               :string(255)      default("0"), not null
#  preparation        :text
#  description        :text
#  prep_time          :integer          default(0), not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  nutrition          :text
#  slug               :string(255)
#  cook_time          :integer          default(0), not null
#  published          :boolean          default(FALSE), not null
#  source             :string(255)      default(""), not null
#  meal               :string(255)      default("dinner"), not null
#  published_at       :datetime
#  is_new             :boolean          default(FALSE), not null
#

class Recipe < ActiveRecord::Base
  acts_as_taggable_on :main_dish, :prep, :diet_type, :dietary_need
  include Slugged

  MEALS = %w(dinner lunch dessert)
  FILTERS = [:main_dish, :prep, :diet_type, :dietary_need]
  
  has_many :ingredients, through: :portions
  has_many :products, through: :ingredients

  has_many :portions, class_name: RecipePortion, dependent: :destroy

  has_many :order_servings, dependent: :destroy

  validates_presence_of :name, :preparation

  validates_numericality_of :prep_time, :cook_time, greater_than_or_equal_to: 0

  validates_inclusion_of :meal, in: MEALS

  before_validation do
    if description.nil?
      self.description = ""
    end
    true
  end

  has_attached_file :photo, default_url: "/assets/defaults/recipe.jpg",
                    styles: { extra_large: "1680x800#", large: "1170x450#",
                              medium_thumb: "600x600#",
                              medium: "300x300#", thumb: "100x100#",
                              small_low_dpi: "320x320",
                              small_hi_dpi: "480x480",
                              medium_hi_dpi: "640x640",
                              large_hi_dpi: "960x960",
                              xlarge_hi_dpi: "1440x1440" }

  validates_attachment_content_type :photo, :content_type => /\Aimage/
  validates_attachment_file_name :photo, :matches => [/png\Z/, /jpe?g\Z/]

  default_scope ->{ order('recipes.created_at desc') }

  scope :last_week, ->{ where(created_at: Delivery.range(2.weeks.ago)) }

  scope :current_week, ->{ where(created_at: Delivery.range(1.week.ago)) }

  scope :next_week, ->{ where(created_at: Delivery.range(Time.now)) }

  MEALS.each do |meal|
    scope meal.pluralize.to_sym, ->{ where(meal: meal) }
  end

  scope :published, ->{ where(published: true) }
  scope :unpublished, ->{ where(published: false) }
  scope :is_new, -> { where(is_new: true) }
  scope :verified, -> { published.reject{ |x| x.products.empty? }}
  scope :sorted, ->{ order('name desc')}

  def self.load_replicant(type, id, attrs)
    id, object = super
    object.save_attached_files
    [id, object]
  end

  def steps
    preparation.split("\n").map(&:strip).reject(&:blank?)
  end

  def calories
    return 0 if facts.empty?
    cals = facts.first.split(" ").first
  end
  
  def fat
    return 0 if facts.empty?
    fat_facts = facts.grep(/fat|Fat/).first
    return 0 if fat_facts.blank?
    fat_facts.split(" ").first
  end
  
  def carbs
    return 0 if facts.empty?
    carb_facts = facts.grep(/carbs|Carbs|carbohydrates|Carbohydrates/).first
    return 0 if carb_facts.blank?
    carb_facts.split(" ").first
  end

  def facts
    nutrition.split("\n").map(&:strip).reject(&:blank?)
  end

  def self.uniq_tags(name='tags')
    # lazy not escaping - but this isn't taken from a user param
    ActsAsTaggableOn::Tag.includes(:taggings).where("taggings.context = '#{name}'").select("DISTINCT tags.*").references(:taggings)
  end

  def total_time
    prep_time + cook_time
  end

  # this gets all tags in the contexts in an array
  def all_tags
    Recipe.joins(:taggings => [:tag]).where(:taggings => {:taggable_id => id}).select("tags.name").map(&:name).flatten
  end

  def assign_medical_nutrition_category category="diabetes friendly"
    case category
    when "diabetes friendly"
      super_category = "manage type 2 diabetes or prediabetes"
      if self.nutrition.blank?
        self.diet_type_list.delete(category) if self.diet_type_list.include?(category)
        self.dietary_need_list.delete(super_category) if self.dietary_need_list.include?(super_category)
      else
        carb_nutrients = self.nutrition.split(/\r\n/).select{ |x| x.downcase.ends_with?("carbohydrates") } 
        if carb_nutrients.blank? 
          self.diet_type_list.delete(category) if self.diet_type_list.include?(category)
          self.dietary_need_list.delete(super_category) if self.dietary_need_list.include?(super_category)
        else
          carb_calories = carb_nutrients.first.split(/\s+/).first.to_i if carb_nutrients.first
          if carb_calories <= 60
            self.dietary_need_list << super_category unless self.dietary_need_list.include?(super_category)
            self.diet_type_list.delete(category) if self.diet_type_list.include?(category)
          else
            self.diet_type_list.delete(category) if self.diet_type_list.include?(category)
            self.dietary_need_list.delete(super_category) if self.dietary_need_list.include?(super_category)
          end
        end
      end
    when "fish"
      if self.main_dish_list.include?("Fish")
        self.main_dish_list << "seafood" unless self.main_dish_list.include?("seafood")  
        self.main_dish_list.delete("Fish")
      end
    when "low carb", "low cal", "Weight loss", "weight loss"
      super_category = "lose weight"
      if self.diet_type_list.include?(category)
        self.dietary_need_list << super_category unless self.dietary_need_list.include?(super_category)  
        self.diet_type_list.delete(category)
      end
    when "vegan"
      if self.diet_type_list.include?("Vegan")
        self.main_dish_list << category unless self.main_dish_list.include?(category)  
        self.diet_type_list.delete("Vegan")
      end
    end    
  end

end
