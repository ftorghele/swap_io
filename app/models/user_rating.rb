class UserRating < ActiveRecord::Base

  attr_accessible :user_id, :evaluator_id, :rating, :body

  validates_presence_of :user_id, :evaluator_id, :rating, :body
  validates :user_id, :numericality => { :only_integer => true }
  validates :evaluator_id, :numericality => { :only_integer => true }

  default_scope :order => "created_at DESC"

  belongs_to :user

  after_save :update_user

  private

  def update_user
    user = self.user
    user.rating_neg_count =  user.rating_neg_count + 1 if self.rating == "negativ"
    user.rating_neut_count =  user.rating_neut_count + 1 if self.rating == "neutral"
    user.rating_pos_count =  user.rating_pos_count + 1 if self.rating == "positiv"
    user.save!
  end
end
