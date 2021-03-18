class StartController < ApplicationController
  protect_from_forgery

  def master
  	@first_leader = User.find(params[:east].to_i)
  	@second_leader = User.find(params[:south].to_i)
  	@third_leader = User.find(params[:west].to_i)
  	@fourth_leader = User.find(params[:north].to_i)
    @current_leader = @first_leader
  	@half_round = HalfRound.new(
      first_leader_user_id: @first_leader.id, second_leader_user_id: @second_leader.id, third_leader_user_id: @third_leader.id, fourth_leader_user_id: @fourth_leader.id
    )
  	@half_round.save!
  	init_score = 25000
  	init_chip = 0
  	@first_leader_score = UserScore.new(
  		user_id:@first_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
    @first_leader_score.save!
  	@second_leader_score = UserScore.new(
  		user_id:@second_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
    @second_leader_score.save!
  	@third_leader_score = UserScore.new(
  		user_id:@third_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
    @third_leader_score.save!
  	@fourth_leader_score = UserScore.new(
  		user_id:@fourth_leader.id, point:init_score, chip:init_chip, half_round_id:@half_round.id
  	)
    @fourth_leader_score.save!
  	@game = Game.new(
  		honba:0, round:"east", half_round_id: @half_round.id, kyoku:1
  		)
    @game.save!
  end

  def next_game
    @half_round = HalfRound.find(params[:half_round_id].to_i)
    get_players
    previous_game = Game.find(params[:game_id].to_i)
    process_results previous_game
    round, kyoku, honba = get_current_r_k_h(previous_game)
    @game = Game.new(
      honba:honba, round:round, half_round_id: @half_round.id, kyoku: kyoku
      )
    @game.save!
    @first_leader_score = UserScore.find_by(user_id:@first_leader.id, half_round_id: @half_round.id)
    @second_leader_score = UserScore.find_by(user_id:@second_leader.id, half_round_id: @half_round.id)
    @third_leader_score = UserScore.find_by(user_id:@third_leader.id, half_round_id: @half_round.id)
    @fourth_leader_score = UserScore.find_by(user_id:@fourth_leader.id, half_round_id: @half_round.id)
    load_current_leader @game.kyoku

    calc = Calculate.new()
    print('####################')
    print(calc.total_score(@game, Hand, @first_leader_score, @second_leader_score, @third_leader_score, @fourth_leader_score))
    print('####################')

    render "master"
  end

  private
    def get_players
      @first_leader = User.find(@half_round.first_leader_user_id)
      @second_leader = User.find(@half_round.second_leader_user_id)
      @third_leader = User.find(@half_round.third_leader_user_id)
      @fourth_leader = User.find(@half_round.fourth_leader_user_id)
    end

    def load_current_leader kyoku
      leaders = [@first_leader, @second_leader, @third_leader, @fourth_leader]
      @current_leader = leaders[kyoku-1]
    end

    def get_current_r_k_h prev_game
      prev_round = prev_game.round
      prev_kyoku = prev_game.kyoku
      prev_honba = prev_game.honba
      round = prev_round
      kyoku = prev_kyoku
      honba = prev_honba
      # 連荘判定
      is_able_to_move_to_next_kyoku = true

      if is_able_to_move_to_next_kyoku # 連荘でないとき
        if "east" == prev_round 
          if 4 == prev_kyoku
            round = "south"
            kyoku = 1
          else
            kyoku += 1
          end
        elsif "south" == prev_round 
          if 4 == prev_kyoku
            round = "west"
            kyoku = 1
          else
            kyoku += 1
          end
        end
        honba = 0
      else # 連荘のとき
        honba += 1
      end
      return round, kyoku, honba
    end

    def process_results prev_game
      first_leader_hand, second_leader_hand, third_leader_hand, fourth_leader_hand = save_hands
      result = Result.new()
      result.first_winner_user_id = params["first_winner"]
      result.second_winner_user_id = params["second_winner"]
      result.loser_user_id = params["loser"]
      result.drawn_game = params["drawn_game"]
      result.first_leader_hand_id = first_leader_hand.id
      result.second_leader_hand_id = second_leader_hand.id
      result.third_leader_hand_id = third_leader_hand.id
      result.fourth_leader_hand_id = fourth_leader_hand.id
      result.save!
      prev_game.result_id = result.id
      prev_game.save!
    end

    def save_hands
      leaders_id_list = [@first_leader.id, @second_leader.id, @third_leader.id, @fourth_leader.id]
      first_leader_hand = Hand.new()
      second_leader_hand = Hand.new()
      third_leader_hand = Hand.new()
      fourth_leader_hand = Hand.new()
      hand_column_names = Hand.column_names_()
      leaders_id_list.zip([first_leader_hand, second_leader_hand, third_leader_hand, fourth_leader_hand]) do |leader_id, hand|
        hand_column_names.each do |hand_column_name|
          hand[hand_column_name] = params[leader_id.to_s + "-" + hand_column_name]
          hand.save!
        end
      end
      return first_leader_hand, second_leader_hand, third_leader_hand, fourth_leader_hand
    end
end

