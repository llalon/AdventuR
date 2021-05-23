library(imager)
library(grid)
library(png)

TILESET <- "./res/Full.png"

img <- readPNG(TILESET)
grid.raster(img)
grid.raster(img[10:19, 80:89,])
grid.raster(img[10:20, 80:90,])
grid.raster(img[11:20, 81:90,]) # This is the one



get_tile <- function(pos.x, pos.y, tile.set = TILESET, tile.size = 10)
{
  img <- readPNG(tile.set)
  
  crop.x <- ((pos.x * tile.size)+1):((pos.x * tile.size)+tile.size)
  crop.y <- ((pos.y * tile.size)+1):((pos.y * tile.size)+tile.size)
  
  img.crop <- img[crop.y, crop.x, ]
  
  return(img.crop)
}

t0 <- (img[11:30, 71:90,])

# Test
t0 <- (get_tile(7, 1))
t1 <- (get_tile(7, 2))
t2 <- (get_tile(7, 3))
t3 <- (get_tile(7, 4))
t4 <- (get_tile(7, 5))


grid.raster(example)
