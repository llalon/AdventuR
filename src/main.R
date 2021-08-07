library(imager)
library(grid)
library(png)
library(rlist)

source("./src/graphics.R")

# SETTINGS
CHUNKSIZE <- 100
TILESIZE <- 10
TILEMAP <- list.load("./res/tile_map.yaml")
FILE.SAVE <- "./savestate.yaml"


main_game <- function() {
  player <- list(stat.hp = 100, current.level = 1, pos.x = 50, pos.y = 50, sprite.id = 2)

  # Generate the world - For now this is just random trees and nothing.
  world <- data.frame(replicate(CHUNKSIZE, sample(0:1, 1000, rep = TRUE)))[1:CHUNKSIZE, 1:CHUNKSIZE]

  running <- TRUE
  while (running) {

    # Get the current View
    view <- get_view(world, player)
    screen <- create_screen(view)

    # Display screen in rstudio viewer
    grid.raster(screen)

    prompt <- readline("What would you like to do? (Type ? for help): ")
    if (prompt == "?") {
      print(get_help_message())
    } else if (prompt == "q") {
      if (readline("Save game? (y/n): ") == "y") {
        list.save(player, FILE.SAVE)
      }
      running <- FALSE
    }

    #######################
    ### Player movement ###
    #######################

    else if (prompt == "w") {
      # Player goes up
      player$pos.y <- player$pos.y - 1
    } else if (prompt == "a") {
      player$pos.x <- player$pos.x - 1
    } else if (prompt == "s") {
      player$pos.y <- player$pos.y + 1
    } else if (prompt == "d") {
      player$pos.x <- player$pos.x + 1
    }
  }

  print("Thanks for playing!")
}

get_help_message <- function() {
  c(
    "Welcome to the help Screen",
    "Use (wasd) for movement",
    "(q) to quit"
  )
}

get_view <- function(df.world, player, view.x = 16, view.y = 11) {
  # Returns a 11x16 df around the player
  # Returns a smaller subset of the world to be printed

  offset.y <- (player$pos.y - floor(view.y / 2)):(player$pos.y + ceiling(view.y / 2) - 1)
  offset.x <- (player$pos.x - floor(view.x / 2)):(player$pos.x + ceiling(view.x / 2) - 1)

  df.world[player$pos.y, player$pos.x] <- player$sprite.id

  df.view <- df.world[offset.y, offset.x]

  return(df.view)
}