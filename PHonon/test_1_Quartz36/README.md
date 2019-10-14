# Small test with Quartz 36 atom cell 

The system is 36 atoms orthorombic super-cell of quartz SiO_2. 
linear response to homogeneous electric field using 
norm conserving pseudopotentials, ultrasoft pseudopotentials and the PAW method.Tests response to electric field and 1 atomic displacements mode.   
 


##To run the test:

* NC pseudopotentials:

	1. first compute the system ground state density with a self consistency run 
```
pw.x < input_scf_nc > out_scf_nc
```


	2.  then start the phonon run
```
ph.x <  input_ph_nc > out_ph_nc
```



* US pseudopotentials:
	1. first compute the system ground state density with a self consistency run 
```
pw.x < input_scf_us > out_scf_us
```

	2. then start the phonon run
```
ph.x <  input_ph_us > out_ph_us
```




* PAW method:
	1. first compute the system ground state density with a self consistency run 
```
pw.x < input_scf_paw > out_scf_paw
```

	2. then start the phonon run
```
ph.x <  input_ph_paw > out_ph_paw
```

