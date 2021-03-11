class Hand < ApplicationRecord
	enum column_name_and_ja: {"reach": "立直", "value_tiles": "役牌", "all_simples": "断ヤオ九",
								"all_runs": "平和", "self_draw": "門前自摸", "first_turn_win": "一発", "double_run": "一盃口",
								"haitei": "河底撈魚", "houtei": "海底摸月", "kings_tile_draw": "嶺上開花", "double_reach": "二重立直",
								"add_a_quad": "搶槓", "dora": "ドラ", "red_dora": "赤ドラ", "ura_dora": "裏ドラ", "all_triples": "対々和",
								"three_color_runs": "三色同順", "seven_pairs": "七対子", "full_straight": "一気通貫", "mixed_outside_hand": "混全帯",
								"three_concealed_triples": "三暗刻", "little_dragons": "小三元", "all_terminals_and_honors": "混老頭",
								"three_color_triples": "三色同刻", "three_quads": "三槓子", "hand_flush": "混一色", "pure_outside_hand": "清全帯",
								"two_double_runs": "ニ盃口", "full_flush": "清一色", "four_concealed_triples": "四暗刻", "thirteen_orphans": "国士無双",
								"big_dragons": "大三元", "all_honors": "字一色", "all_terminals": "清老頭", "blessing_of_earth": "地和",
								"all_green": "緑一色", "nine_gates": "九蓮宝燈", "four_quads": "四槓子", "blessing_of_heaven": "天和",
								"open": "鳴き", "han": "翻", "hu": "符", "pure_nine_gates": "純正九蓮宝燈", "suttan": "四暗刻単騎",
								"all_waitting_thirteen_orphans": "国士無双十三門待ち", "blessing_of_person": "人和", "big_four_winds": "大四喜",
								"small_four_winds": "小四喜", "three_continuous_triples": "三連刻", "four_continuous_triples": "四連刻",
								"pon": "ポン", "chi": "チー", "ankan": "暗槓", "kakan": "加槓", "minkan": "明槓"}

	def self.to_ja(column_name)
		return column_name_and_jas[column_name]
	end
end
