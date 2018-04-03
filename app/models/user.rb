class User < ApplicationRecord
  has_many :microposts, dependent: :destroy

  # denotes user A is a follower of user B
  has_many :active_relationships, class_name:  "Relationship",
                                foreign_key: "follower_id",
                                dependent:   :destroy
  # denotes user B is followed by User A
  has_many :passive_relationships, class_name:  "Relationship",
                                foreign_key: "followed_id",
                                dependent:   :destroy 

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :micropost
  # has_many :post_likes, through: :microposts, source: :likes 

  default_scope -> { order(:name) }
                                                            
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 20 },
    uniqueness: { case_sensitive: false }, 
    format: { with: /\A[a-zA-Z0-9]+\Z/ }
    
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } 
  has_secure_password                 
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})", user_id: id)  
  end

  # def liked_posts
  #   post_ids = "SELECT micropost_id FROM likes
  #                    WHERE  user_id = #{id}"
  #   Micropost.where("id IN (#{post_ids})")
  # end  

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user - deletes relationship entry
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end  

  def liked?(post)
    liked_posts.include?(post)
  end  
end
