# Sparse dictionary learning of butterfly images using locally-competitive neural networks.

William Hahn  
Michael Teti  
Stephanie Lewkowitz  
Bing Ouyang  
Elan Barenholtz  

## Background
This is a novel method of deriving sparse, over-complete
dictionaries for classification, based on simulating the mechanisms of biological
neurons. We utilize a Hopfield model that employs Hebbian learning and local
competition to form distinct dictionaries for unique, related image classes as
well as for selecting among them for a given test image. The model is based
on locally competitive algorithms (LCA), a class of nonlinear dynamic neu-
ral networks that achieve sparse modeling via leaky integrators interacting
through local, nonlinear competition between units. LCA can be implemented
in analog hardware and offer an ultra-low power physical solution to achieving
L1-constrained least squares optimization. Here, we employ simulated LCA
networks for both tasks: first, deriving class-specific sparse dictionaries and
second, classification based on the 1 norm of class-specific activation coef-
ficients. This approach is applied to the recognition of butteries in natural
imagery. The class-specific dictionary learning approach described here is
conducive to learning contextual properties of images (i.e., background proper-
ties that probabilistically co-occur with objects) that can improve classification
performance.


## Dictionary Learning Results
Black swallowtail butterfly  
![alt tag](https://github.com/MichaelTeti/Sparse-Coding-Butterflies/blob/master/Screen%20Shot%202015-08-22%20at%2010.38.49%20PM.png)
Monarch Butterfly  
![alt tag](https://github.com/MichaelTeti/Sparse-Coding-Butterflies/blob/master/Screen%20Shot%202015-08-22%20at%2010.39.07%20PM.png)
Peacock Butterfly  
![alt tag](https://github.com/MichaelTeti/Sparse-Coding-Butterflies/blob/master/Screen%20Shot%202015-08-22%20at%2010.39.21%20PM.png)
Zebra Butterfly  
![alt tag](https://github.com/MichaelTeti/Sparse-Coding-Butterflies/blob/master/Screen%20Shot%202015-08-22%20at%2010.39.30%20PM.png)
