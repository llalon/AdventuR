library(imager)
library(grid)
library(png)

TILESIZE <- 10
TILESET <- "./res/Full.png"
TILEMAP <- list(
  '0' = c(0,0), # Blank
  '1' = c(26, 1), # Tree
  '1306' = c(13,5),
  '1902' = c(20,1),
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
      offset.y <- (1 + ((i-1) * tile.size)):(((i-1) * tile.size) + tile.size)
      offset.x <- (1 + ((j-1) * tile.size)):(((j-1) * tile.size) + tile.size)
      
      # Insert the sub image matrix into the screen
      img.screen[offset.y, offset.x, ] <- img[] 
    }
  }
  
  # Return the image to plot
  return(img.screen)
}


# test
df.ex <- read.csv("./res/levels/example.csv", header = FALSE)
img.screen <- create_screen(df.ex)
grid.raster(img.screen)

# Generate a forest
h <- 11
w <- 16
df <- data.frame(replicate(w,sample(0:1,1000,rep=TRUE)))[1:h, 1:w]
img.screen <- create_screen(df)
grid.raster(img.screen)
