Brief documentation:
--------------------

This code reproduces several figures of Mejias and Wang, Mechanisms of distributed working memory in a large-scale network of macaque neocortex, eLife 2022.

All code, unless specified otherwise, developed by Jorge Mejias. 

Relevant indications before using this code: 

-The code is for personal use only, and it is aimed at providing help in reproducing the results of Mejias and Wang 2022. If something in it is unclear, please go to the original publication and supplementary material, or contact the author at j.f.mejias@uva.nl. 

-Each folder contains the code needed to reproduce part of the indicated figure. 

-The model requires the use of large-scale connectivity data of the 30 cortical areas from the Kennedy lab, as indicated in the manuscript. You can freely obtain the data here: core-nets.org

-Likewise, some figures require the use of a 3D brain model from scalablebrainatlas.incf.org. You can either access the data online (this is the option followed in the code provided here) or download it to your machine.

-Results of figures 5 and 6 require the use high-performance simulations. The code for these figures is therefore specific of the chosen HPC implementation and not included here. However, code from Figure 2 and 4 can be easily adapted to obtain these results.


Any questions may be sent to Jorge Mejias: j.f.mejias@uva.nl.



Usage Instructions:
-------------------

Change directory to one of the figure directories and type 'mainsim' (or mainsin2, mainsim3,... depending on the folder) on the Matlab command prompt. After a few seconds or minutes you should obtain the corresponding figure.