class User
  attr_accessor :id, :name, :nickname, :image

  def self.from_auth(auth)
    new.tap do |user|
      user.id = auth[:uid]
      user.name = auth[:info][:name]
      user.nickname = auth[:info][:nickname]
      user.image = auth[:info][:image]
    end
  end
end
