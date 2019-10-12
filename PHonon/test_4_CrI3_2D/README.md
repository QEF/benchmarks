#Phonons of magnetic 2D material  

Spin polarized benchmark small many q points, possible testing the image 
parallelization.  
 

1. compute the system ground state density with a self consistency run 
```
pw.x < input_scf > out_scf
```

2. run  phonon
```
ph.x <  input_ph  > out_ph
```

