library(rlist)

source("./src/graphics.R")

# SETTINGS
FILESAVE <- "./save.yaml"
TILESIZE <- 10
TILEMAP <- list.load("./res/tile_map.yaml")
CHUNKSIZE <- 100

#h <- 11
#w <- 16
#df <- data.frame(replicate(w,sample(0:1,1000,rep=TRUE)))[1:h, 1:w]
#df[5,5] = 2
#img.screen <- create_screen(df)
#grid.raster(img.screen)


main_game <- function()
{
  
  # The main game
  
  # The player
  player <- list(stat.hp = 100, current.level = 1, pos.x = 0, pos.y = 0, sprite.id = 3)
  
  # Generate the world - For now this is just random trees and nothing. 
  world <- data.frame(replicate(CHUNKSIZE,sample(0:1,1000,rep=TRUE)))[1:CHUNKSIZE, 1:CHUNKSIZE]
  
  # Plops the player in the middle
  player$pos.x <- 50
  player$pos.y <- 50
  world[player$pos.x, player$pos.y] <- player$sprite.id
  
  running <- TRUE
  
  # Main game loop
  while (running)
  {
    
    # Get the current View
    view <- get_view(world, player$pos.x, player$pos.y)
    screen <- create_screen(view)
    
    prompt <- readline("What would you like to do? (Type ? for help): ")
    
    if (prompt == '?')
    {
      print(get_help_message())
    }
    else if (prompt == 'q')
    {
      if (readline("Save game? (y/n)") == 'y') 
      {
        list.save(player, FILE.SAVE)
      }
      running = FALSE
    }
  }
    
}

get_help_message <- function()
{
  "Welcome to the help Screen"
}

get_view <- function(df.world, player.x, player.y, view.x = 11, view.y = 16)
{
  # Returns a 11x16 df around the player
  # TODO: Edge cases (might not be an edge?)
  # Returns a smaller subset of the world to be printed
  
  offset.y <- (player.y - floor(view.y/2)):(player.y + ceiling(view.y/2) - 1)
  offset.x <- (player.x - floor(view.x/2)):(player.x + ceiling(view.x/2) - 1)
    
  df.view <- df.world[offset.y, offset.x]
  
  return(df.view)
}

