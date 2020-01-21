
import numpy as np

def calcstainresult(imageDecon, Imax, funContrast=[]):
        
    # reverse deconvolution
    imageDecon = Imax * np.exp(-imageDecon)
    imageDecon = np.clip(imageDecon, 0, 255)
    imageDecon = Imax - np.uint8(imageDecon)
    
    # apply constrast stretching
#    if funContrast == []:
        
    return imageDecon