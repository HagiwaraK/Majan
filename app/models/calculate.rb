class Calculate
	def initialize
		@points = [0, 0, 0, 0, 0]
		@chips = [0, 0, 0, 0, 0]

		@oya_person = 0
		@agari_person1 = 0
		@agari_person2 = 0
		@furikomi_person = 0

		@ron_flag = false
		@tumo_flag = false
		@double_ron_flag = false
		@drawn_flag = false
	end


	def total_score game, half_round, result, first_leader_score, second_leader_score, third_leader_score, fourth_leader_score	
		@leaders_id = [-1, half_round.first_leader_user_id, half_round.second_leader_user_id, half_round.third_leader_user_id, half_round.fourth_leader_user_id]
		@leaders_hand = [-1, result.first_leader_hand_id, result.second_leader_hand_id, result.third_leader_hand_id, result.fourth_leader_hand_id]
		@leaders_score = [-1, first_leader_score, second_leader_score, third_leader_score, fourth_leader_score]
		@first_winner_id = result.first_winner_user_id
		@second_winner_id = result.second_winner_user_id
		@loser_id = result.loser_user_id

		@oya_person = game.kyoku

		for num in 1..4 do
			@agari_person1 = num if (@leaders_id[num] == @first_winner_id)
			@agari_person2 = num if (@leaders_id[num] == @second_winner_id)
			@furikomi_person = num if (@leaders_id[num] == @loser_id)

			@tumo_flag = true if (Hand.find(@leaders_hand[num]).self_draw == true)
		end

		@drawn_flag = true if (result.drawn_game == true)	
		@ron_flag = true if (@furikomi_person != 0)
		
		if (@agari_person2 != 0) 
			@ron_flag = false
			@double_ron_flag = true
		end

		get_honba_point game
		get_kyotaku_point game
		get_reach_point
		get_hanhu_point
		get_chip

		game.kyotaku += @points[0]
		for num in 1..4 do
			@leaders_score[num].point += @points[num]
			@leaders_score[num].chip += @chips[num]
		end

	end

	private
		def yakuman_flag agari
			if @drawn_flag
				return false
			else
				if Hand.find(@leaders_hand[agari]).thirteen_orphans or \
					Hand.find(@leaders_hand[agari]).four_concealed_triples or \
					Hand.find(@leaders_hand[agari]).four_continuous_triples or \
					Hand.find(@leaders_hand[agari]).four_quads or \
					Hand.find(@leaders_hand[agari]).small_four_winds or \
					Hand.find(@leaders_hand[agari]).big_dragons or \
					Hand.find(@leaders_hand[agari]).all_honors or \
					Hand.find(@leaders_hand[agari]).all_terminals or \
					Hand.find(@leaders_hand[agari]).all_green or \
					Hand.find(@leaders_hand[agari]).nine_gates or \
					Hand.find(@leaders_hand[agari]).blessing_of_earth or \
					Hand.find(@leaders_hand[agari]).blessing_of_person or \
					Hand.find(@leaders_hand[agari]).blessing_of_heaven or \
					Hand.find(@leaders_hand[agari]).all_waitting_thirteen_orphans or \
					Hand.find(@leaders_hand[agari]).suttan or \
					Hand.find(@leaders_hand[agari]).big_four_winds or \
					Hand.find(@leaders_hand[agari]).pure_nine_gates then
						return true;
				end
			end
		end


		def get_chip
			if @tumo_flag then
				if (yakuman_flag(@agari_person1)) then
					total_chip = 10
					@chips[1] += -total_chip
					@chips[2] += -total_chip
					@chips[3] += -total_chip
					@chips[4] += -total_chip
					@chips[@agari_person1] += 4*total_chip
				else
					red_dora_num1 = Hand.find(@leaders_hand[@agari_person1]).red_dora
					ura_dora_num1 = Hand.find(@leaders_hand[@agari_person1]).ura_dora
					first_turn_win1 = 0
					first_turn_win1 = 1 if (Hand.find(@leaders_hand[@agari_person1]).first_turn_win == true)
					red_dora_num1 = 5 if (red_dora_num1 == 3)
					total_chip = red_dora_num1 + ura_dora_num1 + first_turn_win1
					@chips[1] += -total_chip
					@chips[2] += -total_chip
					@chips[3] += -total_chip
					@chips[4] += -total_chip
					@chips[@agari_person1] += 4*total_chip
				end
			elsif @ron_flag then
				if (yakuman_flag(@agari_person1)) then
					total_chip = 20
					@chips[@furikomi_person] += -total_chip
					@chips[@agari_person1] += total_chip
				else
					red_dora_num1 = Hand.find(@leaders_hand[@agari_person1]).red_dora
					ura_dora_num1 = Hand.find(@leaders_hand[@agari_person1]).ura_dora
					first_turn_win1 = 0
					first_turn_win1 = 1 if (Hand.find(@leaders_hand[@agari_person1]).first_turn_win == true)
					red_dora_num1 = 10 if (red_dora_num1 == 3)
					total_chip = red_dora_num1 + ura_dora_num1 + first_turn_win1
					@chips[@furikomi_person] += -total_chip
					@chips[@agari_person1] += total_chip
				end
			elsif @double_ron_flag then
				if (yakuman_flag(@agari_person1)) then
					total_chip = 20
					@chips[@furikomi_person] += -total_chip
					@chips[@agari_person1] += total_chip
				else
					red_dora_num1 = Hand.find(@leaders_hand[@agari_person1]).red_dora
					ura_dora_num1 = Hand.find(@leaders_hand[@agari_person1]).ura_dora
					first_turn_win1 = 0
					first_turn_win1 = 1 if (Hand.find(@leaders_hand[@agari_person1]).first_turn_win == true)
					red_dora_num1 = 10 if (red_dora_num1 == 3)
					total_chip1 = red_dora_num1 + ura_dora_num1 + first_turn_win1
					@chips[@furikomi_person] += -total_chip1
					@chips[@agari_person1] += total_chip1
				end

				if (yakuman_flag(@agari_person2)) then
					total_chip = 20
					@chips[@furikomi_person] += -total_chip
					@chips[@agari_person2] += total_chip
				else
					red_dora_num2 = Hand.find(@leaders_hand[@agari_person2]).red_dora
					ura_dora_num2 = Hand.find(@leaders_hand[@afari_person2]).ura_dora
					first_turn_win2 = 0
					first_turn_win2 = 1 if (Hand.find(@leaders_hand[@agari_person2]).first_turn_win == true)
					total_chip2 = red_dora_num2 + ura_dora_num2 + first_turn_win2
					@chips[@furikomi_person] += -total_chip2
					@chips[@agari_person2] += total_chip2
				end
			end
		end


		def get_honba_point game
			honba = game.honba
			if @tumo_flag then
				@points[1] += -100*honba
				@points[2] += -100*honba
				@points[3] += -100*honba
				@points[4] += -100*honba
				@points[@agari_person1] += 400*honba
			elsif @ron_flag then
				@points[@agari_person1] += 300*honba
				@points[@furikomi_person] += -300*honba 
			elsif @double_ron_flag then
				@points[@agari_person1] += 300*honba
				@points[@agari_person2] += 300*honba
				@points[@furikomi_person] += -600*honba
			end
		end

		def get_kyotaku_point game
			kyotaku = game.kyotaku
			if @ron_flag or @tumo_flag then
				@points[@agari_person1] += kyotaku
				@points[0] += -kyotaku
			elsif @double_ron_flag then
				@points[@agari_person1] += kyotaku/2
				@points[@agari_person2] += kyotaku/2
				@points[0] += -kyotaku
			elsif @drawn_flag then
				@points[0] += 0
			end
		end

		def get_reach_point
			reach_persons = []
			for num in 1..4 do
				reach_persons.push num if (Hand.find(@leaders_hand[num]).reach == true)
			end
			
			reach_stick = reach_persons.size
			for reach_person in reach_persons do
				@points[reach_person] += -1000
			end
			  
			if @ron_flag or @tumo_flag then
				@points[@agari_person1] += 1000*reach_stick
			elsif @double_ron_flag then
				@points[@agari_person1] += (1000*reach_stick)/2
				@points[@agari_person2] += (1000*reach_stick)/2
			elsif @drawn_flag then
				@points[0] += 1000*reach_stick
			end

		end


		def get_hanhu_point
			if @ron_flag or @tumo_flag then
				han1 = Hand.find(@leaders_hand[@agari_person1]).han
				hu1 = Hand.find(@leaders_hand[@agari_person1]).hu
				if @agari_person1 == @oya_person then
					oya_tumo(han1, hu1, @agari_person1) if @tumo_flag
					oya_ron(han1, hu1, @agari_person1) if @ron_flag
				else
					ko_tumo(han1, hu1, @agari_person1) if @tumo_flag
					ko_ron(han1, hu1, @agari_person1) if @ron_flag
				end
			elsif @double_ron_flag then
				han1 = Hand.find(@leaders_hand[@agari_person1]).han
				hu1 = Hand.find(@leaders_hand[@agari_person1]).hu
				han2 = Hand.find(@leaders_hand[@agari_person2]).han
				hu2 = Hand.find(@leaders_hand[@agari_person2]).hu
				
				if @agari_person1 == @oya_person then
					oya_tumo(han1, hu1, @agari_person1) if @tumo_flag
					oya_ron(han1, hu1, @agari_person1) if @ron_flag
				else
					ko_tumo(han1, hu1, @agari_person1) if @tumo_flag
					ko_ron(han1, hu1, @agari_person1) if @ron_flag
				end
				if @agari_person2 == @oya_person then
					oya_tumo(han2, hu2, @agari_person2) if @tumo_flag
					oya_ron(han2, hu2, @agari_person2) if @ron_flag
				else
					ko_tumo(han2, hu2, @agari_person2) if @tumo_flag
					ko_ron(han2, hu2, @agari_person2) if @ron_flag
				end
			elsif @drawn_flag then
				#break
			end			
		end


		def oya_tumo han, hu, agari
			point = 0
			if han==1 then
				point = 0 if hu==20 or hu==25
				point = 500 if hu==30
				point = 700 if hu==40
				point = 800 if hu==50
				point = 1000 if hu==60
				point = 1200 if hu==70
				point = 1300 if hu==80
				point = 1500 if hu==90
				point = 1600 if hu==100
				point = 1800 if hu==110
			elsif han==2 then
				point = 700 if hu==20
				point = 800 if hu==25
				point = 1000 if hu==30
				point = 1300 if hu==40
				point = 1600 if hu==50
				point = 2000 if hu==60
				point = 2300 if hu==70
				point = 2600 if hu==80
				point = 2900 if hu==90
				point = 3200 if hu==100
				point = 3600 if hu==110
			elsif han==3 then
				point = 1300 if hu==20
				point = 1600 if hu==25
				point = 2000 if hu==30
				point = 2600 if hu==40
				point = 3200 if hu==50
				point = 3900 if hu==60
				point = 4000 if hu>=70
			elsif han==4 then
				point = 2600 if hu==20
				point = 3200 if hu==25
				point = 3900 if hu==30
				point = 4000 if hu>=40
			elsif han==5 then
				point = 4000
			elsif han==6 or han==7
				point = 6000
			elsif han==8 or han==9 or han==10
				point = 8000
			elsif han==11 or han==12
				point = 12000
			elsif han==13
				point = 16000
			elsif han==26
				point = 32000
			elsif han==39
				point = 48000
			end
			
			@points[1] += -point
			@points[2] += -point
			@points[3] += -point
			@points[4] += -point
			@points[agari] += 4*point 
		end


		def oya_ron han, hu, agari
			point = 0
			if han==1 then
				point = 0 if hu==20 or hu==25
				point = 1500 if hu==30
				point = 2000 if hu==40
				point = 2400 if hu==50
				point = 2900 if hu==60
				point = 3400 if hu==70
				point = 3900 if hu==80
				point = 4400 if hu==90
				point = 4800 if hu==100
				point = 5300 if hu==110
			elsif han==2 then
				point = 2000 if hu==20
				point = 2400 if hu==25
				point = 2900 if hu==30
				point = 3900 if hu==40
				point = 4800 if hu==50
				point = 5800 if hu==60
				point = 6800 if hu==70
				point = 7700 if hu==80
				point = 8700 if hu==90
				point = 9600 if hu==100
				point = 10600 if hu==110
			elsif han==3 then
				point = 3900 if hu==20
				point = 4800 if hu==25
				point = 5800 if hu==30
				point = 7700 if hu==40
				point = 9600 if hu==50
				point = 11600 if hu==60
				point = 12000 if hu>=70
			elsif han==4 then
				point = 7700 if hu==20
				point = 9600 if hu==25
				point = 11600 if hu==30
				point = 12000 if hu>=40
			elsif han==5 then
				point = 12000
			elsif han==6 or han==7
				point = 18000
			elsif han==8 or han==9 or han==10
				point = 24000
			elsif han==11 or han==12
				point = 36000
			elsif han==13
				point = 48000
			elsif han==26
				point = 96000
			elsif han==39
				point = 144000
			end

			@points[@furikomi_person] += -point
			@points[agari] += point
		end


		def ko_tumo han, hu, agari
			point = [0, 0]
			if han==1 then
				point = [0, 0] if hu==20 or hu==25
				point = [500, 300] if hu==30
				point = [700, 400] if hu==40
				point = [800, 400] if hu==50
				point = [1000, 500] if hu==60
				point = [1200, 600] if hu==70
				point = [1300, 700] if hu==80
				point = [1500, 800] if hu==90
				point = [1600, 800] if hu==100
				point = [1800, 900] if hu==110
			elsif han==2 then
				point = [700, 400] if hu==20
				point = [800, 400] if hu==25
				point = [1000, 500] if hu==30
				point = [1300, 700] if hu==40
				point = [1600, 800] if hu==50
				point = [2000, 1000] if hu==60
				point = [2300, 1200] if hu==70
				point = [2600, 1300] if hu==80
				point = [2900, 1500] if hu==90
				point = [3200, 1600] if hu==100
				point = [3600, 1800] if hu==110
			elsif han==3 then
				point = [1300, 700] if hu==20
				point = [1600, 800] if hu==25
				point = [2000, 1000] if hu==30
				point = [2600, 1300] if hu==40
				point = [3200, 1600] if hu==50
				point = [3900, 2000] if hu==60
				point = [4000, 2000] if hu>=70
			elsif han==4 then
				point = [2600, 1300] if hu==20
				point = [3200, 1600] if hu==25
				point = [3900, 2000] if hu==30
				point = [4000, 2000] if hu>=40
			elsif han==5 then
				point = [4000, 2000]
			elsif han==6 or han==7
				point = [6000, 3000]
			elsif han==8 or han==9 or han==10
				point = [8000, 4000]
			elsif han==11 or han==12
				point = [12000, 6000]
			elsif han==13
				point = [16000, 8000]
			elsif han==26
				point = [32000, 16000]
			elsif han==39
				point = [48000, 24000]
			end

			@points[1] += -point[1]
			@points[2] += -point[1]
			@points[3] += -point[1]
			@points[4] += -point[1]

			@points[@oya_person] += point[1]-point[0]
			@points[agari] += 3*point[1]+point[0]
		end

		def ko_ron han, hu, agari
			point = 0
			if han==1 then
				point = 0 if hu==20 or hu==25
				point = 1000 if hu==30
				point = 1300 if hu==40
				point = 1600 if hu==50
				point = 2000 if hu==60
				point = 2300 if hu==70
				point = 2600 if hu==80
				point = 2900 if hu==90
				point = 3200 if hu==100
				point = 3600 if hu==110
			elsif han==2 then
				point = 1300 if hu==20
				point = 1600 if hu==25
				point = 2000 if hu==30
				point = 2600 if hu==40
				point = 3200 if hu==50
				point = 3900 if hu==60
				point = 4500 if hu==70
				point = 5200 if hu==80
				point = 5800 if hu==90
				point = 6400 if hu==100
				point = 7100 if hu==110
			elsif han==3 then
				point = 2600 if hu==20
				point = 3200 if hu==25
				point = 3900 if hu==30
				point = 5200 if hu==40
				point = 6400 if hu==50
				point = 7700 if hu==60
				point = 8000 if hu>=70
			elsif han==4 then
				point = 5200 if hu==20
				point = 6400 if hu==25
				point = 7700 if hu==30
				point = 8000 if hu>=40
			elsif han==5 then
				point = 8000
			elsif han==6 or han==7
				point = 12000
			elsif han==8 or han==9 or han==10
				point = 16000
			elsif han==11 or han==12
				point = 24000
			elsif han==13
				point = 32000
			elsif han==26
				point = 64000
			elsif han==39
				point = 96000
			end

			@points[@furikomi_person] += -point
			@points[agari] += point
		end
		

end
