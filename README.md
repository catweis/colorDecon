# Color Deconvolution of Histopathological Images
This project implements the algorithm to deconvolve the color information of a histopathological RGB image by calculating the contribution of each of the applied stains (e.g. Hematoxylin, Eosin, DAB) given. The algorithm is based on the publications by Ruifrok et al. (2001)[1] and Hidalgo-Gavira et al. (2018)[2] 

## Usage
_deconcolour_:<br>
applies the color deconvolution algorithm on a given histological image _imageIn_ of size _MxNxK_ where _M_ and _N_ are the number of rows and columns respectively and _K=3_ refers to the Red, Green, Blue (RGB) channels. If no image specified an example image _testImage.jpg_ is used. A stain filter matrix **M** might be profided of size _LxK_ where _L_ refers to the combination of stains to be extracted from the original image. As default **M** is chosen from Ruifrok et al. (2001) [1] for the stains hematoxylin, eosin and diaminobenzidine (DAB). The function returns the deconvolution image of size _MxNxL_.

_removeBlack_:<br>
This provides an optional removal of black image parts (<5) from the original image. _replaceValue_ is the _uint8_ scalar to replace black pixels. As default _replaceValue=255_ (white). 

## Authors
Dr. med. Cleo-Aron Weis, M.Sc. (<Cleo-Aron.Weis@medma.uni-heidelberg.de>)<br>
Marlen Runz, M.Sc (<Marlen.Runz@medma.uni-heidelberg.de>)

## References
[1]: Ruifrok, A. C., & Johnston, D. A. (2001). Quantification of histochemical staining by color deconvolution. Analytical and Quantitative Cytology and Histology, 23(4), 291–299. Retrieved from http://www.ncbi.nlm.nih.gov/pubmed/11531144<br>
[2]: Hidalgo-Gavira, N., Mateos, J., Vega, M., Molina, R., & Katsaggelos, A. K. (2018). Fully automated blind color deconvolution of histopathological images. Lecture Notes in Computer Science (Including Subseries Lecture Notes in Artificial Intelligence and Lecture Notes in Bioinformatics), 11071 LNCS, 183–191. https://doi.org/10.1007/978-3-030-00934-2_21
