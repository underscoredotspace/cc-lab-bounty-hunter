require_relative('models/bounties')

bounty1 = Bounties.new({
  "name" => "Jimmy Bond",
  "species" => "Klingon",
  "bounty_value" => "5000",
  "favourite_weapon" => "Walther PPK"
})

bounty1.save()