require 'pry'

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :is_clickbait?

  def is_clickbait?
    if self.title
      cb_titles = ["Won't Believe", "Secret", "Top", "Guess"]
      cb_titles.each do |cbt| 
        if title.include? cbt
          return true
        end
      end
      errors.add(:title, "must be clickbait")
    end
  end
end
