class Game < ApplicationRecord
	def get_ja_round
		ja_round = ""
		if self.round == "east"
			ja_round = "東"
		elsif self.round == "south"
			ja_round = "南"
		elsif self.round == "west"
			ja_round = "西"
		end
		return ja_round
	end
end
