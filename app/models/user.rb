class User < ActiveRecord::Base
  
  
    
    before_create :create_remember_token
    
    before_save { self.email = email.downcase }
    before_create :create_remember_token
    
    validates_presence_of :name, :email
    validates_uniqueness_of :email
    has_secure_password
    validates :password, length: {minimum: 6}
    
    
    has_many :microposts, dependent: :destroy
    
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
    
    has_many :reverse_relationships, class_name: 'Relationship', foreign_key: "followed_id", dependent: :destroy
    has_many :followers, through: :reverse_relationships, source: :follower
    
    
    def User.new_remember_token
    SecureRandom.urlsafe_base64
    end

    def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
    end
    
    def admin?
      admin
    end

  def feed
    Micropost.from_users_followed_by(self)
  end

        def follow!(other_user)
        relationships.create!(followed_id: other_user.id)
        end
        
        def following?(other_user)
        relationships.find_by(followed_id: other_user.id)
        end
    
        def unfollow!(other_user)
        relationships.find_by(followed_id: other_user.id).destroy!
        end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

end