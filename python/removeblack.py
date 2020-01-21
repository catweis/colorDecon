
import numpy as np
from skimage.color import rgb2gray

def removeBlack(imageIn, replaceValue=255):
    
    # detect black areas
    imageGray = rgb2gray(imageIn)
    imageGray = np.uint8(rgb2gray(imageIn)*255)
    maskBlack = imageGray < 5

    # remove it
    imageIn[maskBlack] = replaceValue
    
    return imageIn