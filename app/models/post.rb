class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction),
    message: "%{value} is not a valid category"}
  validate :clickbait?

  def clickbait?
    # https://apidock.com/ruby/String/match
    clickbait_titles = [
      /Won't Believe/i,
      /Secret/i,
      /Top [0-9]*/i,
      /Guess/i
    ]
    if clickbait_titles.none? { |pat| pat.match title }
        errors.add(:title, "Title is not sufficiently clickbaity-y")
    end
  end
  
end
