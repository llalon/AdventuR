library(imager)
library(grid)
library(png)
library(rlist)

TILESIZE <- 10
TILEMAP <- list.load("./res/tile_map.yaml")

get_tile <- function(pos.x, pos.y, tile.set = TILESET, tile.size = TILESIZE) {
  # Creates a sub image from the tileset based on the given coords.
  # Returns a PNG (as matrix 4d).

  set <- paste("./res", tile.set, sep = "/")
  img <- readPNG(set)

  crop.x <- ((pos.x * tile.size) + 1):((pos.x * tile.size) + tile.size)
  crop.y <- ((pos.y * tile.size) + 1):((pos.y * tile.size) + tile.size)

  img.crop <- img[crop.y, crop.x, ]

  return(img.crop)
}

create_screen <- function(df.screen, tile.map = TILEMAP, tile.size = TILESIZE) {
  # Generates a PNG represented by a matrix.
  # Takes a data frame of characters which map to coordinates in the tile set.
  # df.screen represents only the current view not the entire map df
  # Returns a PNG (as 4d matrix)
  # Can be displayed by grid.raster()

  # The empty image
  srow <- nrow(df.screen) * tile.size
  scol <- ncol(df.screen) * tile.size

  # Create an empty Screen
  img.screen <- array(rep(0, srow * scol * 4), dim = c(srow, scol, 4))
  k <- 1
  for (i in 1:nrow(df.screen)) {
    for (j in 1:ncol(df.screen)) {

      # Find the value of the image in the pos
      id <- as.character(df.screen[i, j])

      # Look up ids position in master list
      x <- tile.map[[id]]$x
      y <- tile.map[[id]]$y

      set <- tile.map[[id]]$set

      # Create sub image from these coords
      img <- get_tile(x, y, set)


      # Find bounds
      offset.y <- (1 + ((i - 1) * tile.size)):(((i - 1) * tile.size) + tile.size)
      offset.x <- (1 + ((j - 1) * tile.size)):(((j - 1) * tile.size) + tile.size)

      # Insert the sub image matrix into the screen
      img.screen[offset.y, offset.x, ] <- img[]
    }
  }

  # Return the image to plot
  return(img.screen)
}