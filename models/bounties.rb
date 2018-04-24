require('pg')

class Bounty
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

  def update()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
    })

    sql = "UPDATE bounties SET (name, species, bounty_value, favourite_weapon)
           = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@name, @species, @bounty_value, @favourite_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
    })

    sql = "DELETE FROM bounties WHERE id = $1"
    db.prepare("delete", sql)
    db.exec_prepared("delete", [@id])
    db.close()
  end

  # class methods
  def Bounty.find_by_name(name)
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
    })

    sql = "SELECT * FROM bounties WHERE name = $1"
    db.prepare("find_by_name", sql)
    result = db.exec_prepared("find_by_name", [name])[0]
    db.close()

    return Bounty.new(result)
  end

end