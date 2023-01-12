OUTPUT_DIR = run/
FC = gfortran
SRC = src/mtfort90.f90 src/global_constants_mod.f90 src/rand_generators_mod.f90 src/footprint_mod.f90 \
	  src/write_layout_mod.f90 src/check_overlapping_mod.f90 src/create_rectangles_mod.f90 src/move_object_mod.f90 \
	  src/simulated_annealing_mod.f90 src/two_dim_packing_problem.f90

OBJ = ${SRC: .f90 = .o}

%.o: %.f90
	$(FC) -o $@ -c $<

two_dim_packing_problem.out: $(OBJ)
	$(FC) -o $(OUTPUT_DIR)$@ $(OBJ)

clean:
	@rm -f *.mod *.o $(OUTPUT_DIR)two_dim_packing_problem.out