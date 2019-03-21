require 'pry'
class Pokemon
  attr_accessor :id, :name, :type, :db, :hp
  @@all = []

  def initialize(data)
    if data.keys.include?(:hp)
      data.each do |k, v|
        self.send("#{k}=", v)
      end
    else
      data.each do |k, v|
        self.send("#{k}=", v)
      end
      @hp = 60
    end
    @@all << self
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
  end

  def self.find(id, db)
    # binding.pry
    new = db.execute("SELECT * FROM pokemon WHERE id = ?",id).flatten
    # binding.pry
    data = {id:new[0], name:new[1], type:new[2], db:db}
    # binding.pry
    self.new(data)
  end

  def alter_hp(hp, db)
    # binding.pry
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, self.id)

    # class.self.save(self.name, self.type, db)

  end

end
