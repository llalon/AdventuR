library(magick)
library(imager)
library(rlist)

# SETTINGS
FILE.SAVE <- "./save.yaml"


TILE.SIZE <- 10

# The game world. TODO: generate this dynamically
WORD <- lapply(list.files("res/levels/", pattern="*.csv", full.names = TRUE), read.delim)


main_game <- function()
{
  
  # The main game
  
  
  player <- list(stat.hp = 100, current.level = 1, pos.x = 0, pos.y = 0)
  
  game <- list(player = player, world = LEVELS[[player$current_level]])
  
  world <- 

  running <- TRUE
  
  # Main game loop
  while (running)
  {
    
    # Find which world the player is in
    world <- 
    
    display_world(world)
    
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


# Loads an image
file.img <- "./res/Full-no-bg.png"
screen <-  load.image(file.img)
plot(screen)



build_screen <- function(df.screen)
{
  # Takes the data frame of the world and generates an image that will be the screen
  for (i in df.world)
}


