#Biixbiite dielectric tensonr 

The system is 80 atom super-cell of byxbiite LaO. 
The test computes the linear response to homogeneous electric field. 
 
Inputs for Norm Conservig (\_nc ones) and UltraSoft (\_us ones). 

1. compute the system ground state density with a self consistency run 
```
pw.x < input_LaO_80-scf > out_scf
```

2. run  phonon
```
ph.x <  input_ph-epsil > out_ph
```

