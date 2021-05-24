library(imager)
library(grid)
library(png)

TILESIZE <- 10
TILESET <- "./res/Full.png"
TILEMAP <- list(
  '0' = c(7,1),
  '1' = c(7,2),
  '2' = c(7,3),
  '3' = c(7,4)
)

get_tile <- function(pos.x, pos.y, tile.set = TILESET, tile.size = TILESIZE)
{
  # Creates a sub image from the tileset based on the given coords.
  # Returns a PNG (as matrix 4d).
  
  
  img <- readPNG(tile.set)
  
  crop.x <- ((pos.x * tile.size)+1):((pos.x * tile.size)+tile.size)
  crop.y <- ((pos.y * tile.size)+1):((pos.y * tile.size)+tile.size)
  
  img.crop <- img[crop.y, crop.x, ]
  
  return(img.crop)
}

create_screen <- function(df.screen, tile.set = TILESET, tile.size = TILESIZE, tile.map = TILEMAP)
{
  # Generates a PNG represented by a matrix. 
  # Takes a data frame of characters which map to coordinates in the tile set.
  # Returns a PNG (as 4d matrix)
  # Can be displayed by grid.raster()
  
  # The empty image
  srow = nrow(df.screen) * tile.size 
  scol = ncol(df.screen) * tile.size
  
  # Create an empty Screen
  img.screen <- array(rep(0, srow*scol*4), dim=c(srow, scol, 4))
  
  for (i in 1:nrow(df.screen)) {
    for (j in 1:ncol(df.screen)) {
      
      # Find the value of the image in the pos
      id <- as.character(df.screen[i, j])
      
      # Look up ids position in master list
      x <- tile.map[[id]][1]
      y <- tile.map[[id]][2]
      
      # Create sub image from these coords
      img <- get_tile(x, y)
      
      # Find bounds
      offset.x <- (1 + ((i-1) * tile.size)):(((i-1) * tile.size) + tile.size)
      offset.y <- (1 + ((j-1) * tile.size)):(((j-1) * tile.size) + tile.size)
      
      # Insert the sub image matrix into the screen
      img.screen[offset.y, offset.x, ] <- img[] 
    }
  }
  
  # Return the image to plot
  return(img.screen)
}


# test
img <- readPNG(TILESET)
grid.raster(img.screen)
grid.raster(img[11:20, 81:90,]) # This is the one

# Test
t0 <- (img[11:30, 71:90,])
t0 <- (get_tile(7, 1))
t1 <- (get_tile(7, 2))
t2 <- (get_tile(7, 3))
t3 <- (get_tile(7, 4))
t4 <- (get_tile(7, 5))
grid.raster(t0)
