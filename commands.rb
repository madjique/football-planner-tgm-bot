def hello_command(ctx) 
    # loading context
    reply = ctx[:reply]

    reply.text = "Hello ⚽"
end

def admin_log(ctx)
    reply, logger = ctx[:reply] , ctx[:logger]

    reply.text = "logs displayed in console ✅"
    logger.info(gamectl.inspect)
    logger.info(gamectl.get_game.inspect)
    logger.info(message.inspect)
end

def begin_match_command(ctx)
    gamectl, reply, logger = ctx[:gamectl], ctx[:reply], ctx[:logger]
    gamectl.startgame
    logger.info(gamectl.inspect)
    logger.info(gamectl.get_game.inspect)
    reply.text = "Game initilialized ⚽"
end

def show_list_command(ctx)
    gamectl, reply, logger = ctx[:gamectl], ctx[:reply], ctx[:logger]

    logger.info(gamectl.get_main_list)

    reply.text = "\n Liste des titulaires ***** \n"
    reply.text += gamectl.get_main_list
    reply.text += "\n Liste d'attente **********\n"
    reply.text += gamectl.get_waiting_list
end

def add_player_to_game_command(ctx)
    gamectl, message, reply, logger = ctx[:gamectl], ctx[:message], ctx[:reply], ctx[:logger]

    new_player_fullname = "#{message.from.first_name} #{message.from.last_name}"
    if gamectl.in_list_or_waiting_list?(new_player_fullname)
        logger.info(gamectl.inspect)
        reply.text = "#{new_player_fullname} already in game list! ❌"
    else
        player = Player.new(new_player_fullname)
        gamectl.add_player(player)
        reply.text = "#{player.fullname} added to the game ✅ ⚽"
        logger.info(player.inspect)
    end
end

def cancel_player_from_game_command(ctx)
    gamectl, message, reply, logger = ctx[:gamectl], ctx[:message], ctx[:reply], ctx[:logger]

    player_fullname = "#{message.from.first_name} #{message.from.last_name}"
    if gamectl.in_list_or_waiting_list?(player_fullname)
        player = gamectl.get_player_by_fullname(player_fullname)
        gamectl.cancel_player(player)
        logger.info(gamectl.inspect)
        reply.text = "#{player_fullname} canceled sucessfully ! ✅"
    else
        reply.text = "#{player_fullname} in not in the game list! ❌"
        logger.info(player.inspect)
    end
end