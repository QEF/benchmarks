# Large Quartz test 

* 144 atoms orthorombic super-cell of quartz SiO_2. 

* The benchmark  computes the linear response to an atomic translation at Gamma   point  using: 
	* norm conserving  and ultrasoft pseudopotentials. 
	* ecutrho=320 in both cases.
	* ecutwfc=40 Ry  for USpp and 80 Ry for NCpp
 
 


## To run the test:

1. NC pseudopotentials:
	* Compute the system ground state density with a self consistency run 
```
	pw.x < input_scf_nc > out_scf_nc
```

	* phonon run
```
	ph.x <  input_ph-G10_nc > out_ph_nc
```


2. USPP pseudopotentials 

	* Compute the system ground state density with a self consistency run 
```
pw.x < input_scf_us > out_scf_us
```

	* start the phonon run
```
ph.x <  input_ph-G10_us > out_ph_us
```



