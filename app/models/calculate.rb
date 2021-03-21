class Calculate
	def initialize
		@points = [0, 0, 0, 0, 0]
		@oya_person = 0
		@agari_person1 = 0
		@agari_person2 = 0
		@furikomi_person = 0

		@ron_flag = false
		@tumo_flag = false
		@double_ron_flag = false
		@drawn_flag = false

		@agari_hand = []
	end

	def total_score result, round, game, user1, user2, user3, user4
		@oya_person = game.kyoku

		@agari_person1 = 1 if (round.first_leader_user_id == result.first_winner_user_id)
		@agari_person1 = 2 if (round.second_leader_user_id == result.first_winner_user_id)
		@agari_person1 = 3 if (round.third_leader_user_id == result.first_winner_user_id)
		@agari_person1 = 4 if (round.fourth_leader_user_id == result.first_winner_user_id)

		@agari_person2 = 1 if (round.first_leader_user_id == result.second_winner_user_id)
		@agari_person2 = 2 if (round.second_leader_user_id == result.second_winner_user_id)
		@agari_person2 = 3 if (round.third_leader_user_id == result.second_winner_user_id)
		@agari_person2 = 4 if (round.fourth_leader_user_id == result.second_winner_user_id)

		@agari_hand_id = [-1, result.first_leader_hand_id, result.second_leader_hand_id, result.third_leader_hand_id, result.fourth_leader_hand_id]

		@furikomi_person = 1 if (round.first_leader_user_id == result.loser_user_id)
		@furikomi_person = 2 if (round.second_leader_user_id == result.loser_user_id)
		@furikomi_person = 3 if (round.third_leader_user_id == result.loser_user_id)
		@furikomi_person = 4 if (round.fourth_leader_user_id == result.loser_user_id)

		@drawn_flag = true if (result.drawn_game == true)
		
		@tumo_flag = true if (Hand.find(result.first_leader_hand_id).self_draw == true)
		@tumo_flag = true if (Hand.find(result.second_leader_hand_id).self_draw == true)
		@tumo_flag = true if (Hand.find(result.third_leader_hand_id).self_draw == true)
		@tumo_flag = true if (Hand.find(result.fourth_leader_hand_id).self_draw == true)
		
		@ron_flag = true if (@furikomi_person != 0)
		
		if (@agari_person2 != 0) 
			@ron_flag = false
			@double_ron_flag = true
		end
		print('-----flag--->')
		print(@tumo_flag, @ron_flag, @double_ron_flag)

		game.kyotaku = 0 if (game.kyotaku==nil)
		get_honba_point game
		get_kyotaku_point game
		get_reach_point result
		get_hanhu_point result


		game.kyotaku += @points[0]
		user1.point += @points[1]
		user2.point += @points[2]
		user3.point += @points[3]
		user4.point += @points[4]


	end

	private
		def get_honba_point game
			honba = game.honba-1
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
			print('----get_honbba_point---->')
			print(@points)
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
				@points[0] += kyotaku
			end
			print('---get_kyotaku_point--->')
			print(@points)
		end

		def get_reach_point result
			reach_persons = []
			reach_persons.push 1 if (Hand.find(result.first_leader_hand_id).reach == true)
			reach_persons.push 2 if (Hand.find(result.second_leader_hand_id).reach == true)
			reach_persons.push 3 if (Hand.find(result.third_leader_hand_id).reach == true)
			reach_persons.push 4 if (Hand.find(result.fourth_leader_hand_id).reach == true)

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

			print('---get_reach_point-->')
			print(@points)
		end


		def get_hanhu_point result
			if @ron_flag or @tumo_flag then
				han1 = Hand.find(@agari_hand_id[@agari_person1]).han
				hu1 = Hand.find(@agari_hand_id[@agari_person1]).hu
				print('---get_hahu11------>')
				print(@agari_person, @oya_person)
				if @agari_person1 == @oya_person then
					oya_tumo(han1, hu1, @agari_person1) if @tumo_flag
					oya_ron(han1, hu1, @agari_person1) if @ron_flag
				else
					ko_tumo(han1, hu1, @agari_person1) if @tumo_flag
					ko_ron(han1, hu1, @agari_person1) if @ron_flag
				end
			elsif @double_ron_flag then
				han1 = Hand.find(@agari_hand_id[@agari_person1]).han
				hu1 = Hand.find(@agari_hand_id[@agari_person1]).hu
				han2 = Hand.find(@agari_hand_id[@agari_person2]).han
				hu2 = Hand.find(@agari_hand_id[@agari_person2]).hu
				
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
			print('--get_hanhu-->')
			print(@points)
			
		end


		def oya_tumo han, hu, agari
			print('----------oya-tumo-----------')
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
			print('--oya_tumo-->')
			print(@points)
		end


		def oya_ron han, hu, agari
			print('----------oya-ron-----------')
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

			@points[1] += -point[0]
			@points[2] += -point[0]
			@points[3] += -point[0]
			@points[4] += -point[0]

			@points[@oya_person] += point[0]-point[1]
			@points[agari] += 3*point[0]+point[1]
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
