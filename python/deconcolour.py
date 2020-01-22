
import removeblack as rb
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image


def deconcolour(imageIn=[], M=[], removeBlack=True, funContrast=[], vis=True):
      
#%% input layer
    # input image
    numb_channels = 3

    if imageIn == []:
        imageIn = Image.open("testImage.jpg")
        imageIn = np.array(imageIn)

    if imageIn.shape[2] > numb_channels:
        imageIn = imageIn[:,:,:numb_channels]

    Imax = np.max(imageIn)     
    
    sz = imageIn.shape
    
    # define the color values
    if (M == [] or not(np.ndim(M) == 2 and np.shape(M)[1] == numb_channels)): 
                    #    R      G     B 
        M = np.array([ [0.18, 0.20, 0.08],   # Hematoxylin
                       [0.01, 0.13, 0.01],   # Eosin
                       [0.10, 0.21, 0.29] ]) # DAB
    
    numb_stains = M.shape[0]
    
#%% remove black image-parts
    if removeBlack:
        imageIn = rb.removeBlack(imageIn, Imax)

#%% normalize filter
    for i in range(M.shape[0]):
        M[i, :] = M[i, :] / np.linalg.norm(M[i, :])
        
#%% convert RGB intensity to optical density (absorbance)  
    # +1 in order to avoid ln(0)
    imageOD = -np.log10((imageIn+1.) / Imax)

#%% convert the image to matrix with values per pixel
    imageOD = np.reshape(imageOD, (-1, numb_channels))
    
#%% calculate the color deconvolution OD = CM -> C = OD M^-1
    imageDecon = np.dot(imageOD, np.linalg.pinv(M)) 

#%% convert the color-deconvolution results to a staining result  
    # reverse deconvolution
    imageDecon = Imax * np.exp(-imageDecon)
    imageDecon = np.clip(imageDecon, 0, 255)
    imageDecon = Imax - np.uint8(imageDecon)
    
    # apply constrast stretching

    # reshape to images    
    imageDecon = np.reshape(imageDecon, (sz[0], sz[1], numb_stains))


#%% output layer  
    if vis:
        ax1 = plt.subplot(211)
        ax1.imshow(imageIn)
        ax1.set_title('input image')
        
        for i in range(numb_stains):
            ax2 = plt.subplot(2, numb_stains, i+1+numb_stains)
            ax2.imshow(imageDecon[:, :, i], cmap='plasma')
            ax2.set_title('staining'+str(i+1))
            
        plt.show()
        
#%% return
        return imageDecon
        
        