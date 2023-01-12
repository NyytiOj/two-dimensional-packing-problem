| File                              | Content                                                                         |
| --------------------------------- | ------------------------------------------------------------------------------- |
| mtfort90.f90                      | RNG module                                                                      |
| check_overlapping_mod.f90         | Module to check wether rectangles are overlapping                               |
| create_rectangles_mod.f90         | Module to create a bunch of random rectangles                                   |
| footprint_mod.f90                 | Module to create the footprint for the layout                                   |
| global_constants_mod.f90          | Global constants used in many files of the program                              |
| move_object_mod.f90               | Module that chooses a random rectangle from an array and moves it randomly      |
| rand_generators_mod.f90           | Module that combines the RNG functions and subroutines usen in program          |
| simulated_annealing_mod.f90       | Module to find the optimal layout for the rectangles using simulated annealing  |
| two_dim_packing_problem.f90       | Main program to run the simulation of two dimensional packing problem           |
| write_layout_mod.f90              | Module to write layout to a chosen file                                         |


!Notice that for the program to run correctly, the compilation should be dode inside the folder finalproject!`

Compilation:
````````````
make
```````````

If the Makefile is not working, you can also compile the program with the next command
´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´´````````````````
gfortran src/mtfort90.f90 src/rand_generators_mod.f90 src/global_constants_mod.f90 src/footprint_mod.f90 \
	    src/write_layout_mod.f90 src/check_overlapping_mod.f90 src/create_rectangles_mod.f90 src/move_object_mod.f90 \
	    src/simulated_annealing_mod -o run/two_dim_packing_problem.out
`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
