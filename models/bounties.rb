require('pg')

class Bounties
  attr_accessor :id, :name, :species, :bounty_value, :favourite_weapon

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @species = options["species"]
    @bounty_value = options["bounty_value"].to_i
    @favourite_weapon = options["favourite_weapon"]
  end

  def save()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
    })

    sql = "INSERT INTO bounties (name, species, bounty_value, favourite_weapon)
           VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@name, @species, @bounty_value, @favourite_weapon]

    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"]

    db.close()
  end
end