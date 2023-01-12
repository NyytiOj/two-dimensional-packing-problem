!------------------------------------------------------------------------------------------------------------------------!
!I've initialised the program to create 5 random rectangles and run them trought the SA algorithm.                       !
!In the SA the temperature is set to start from 10 and drop with the factor 0.98 to temperature 0.01. I_max is set to 15 !
! With these initializet parameters running the program should only take a little over a minute                          !
!------------------------------------------------------------------------------------------------------------------------!
!You can change any of these parameters in module global constants. Notice that the computation time might grow extreamly!
!if you change the parameters in a way that increases the number of iterations                                           !
! (increase the initial temperature, increase i_max, create a huge number of rectagnles etc.)                            !
!------------------------------------------------------------------------------------------------------------------------!
program two_dim_packing_problem
    use create_rectangles_mod
    use global_constants_mod
    use simulated_annealing_mod
    use write_layout_mod
    implicit none
    type(rectangle), allocatable :: layout(:), footprint(:)
    real (kind = rk):: beginning, ending


    call cpu_time(beginning)
    print*, 'This might take a while'

    layout = create_rectangles(nRectancles) !create the initial layout of random rectangles
    
    ! print'(4(f10.2))', layout
    call write_layout(nRectancles, layout, 'run/beginning_layout.10', 10) !write the initial layout to file beginning_layout.10

    call SA(nRectancles,layout) !call the SA subroutine to find a new order for the rectangles where the area of the footprint around the rectangles is the smallest
    call write_layout(nRectancles,layout,'run/end_layout.20', 20) !write the new layout in file end_layout.20

    deallocate(layout)

    call cpu_time(ending)
    print"('CPU-time burned',f10.2, 's')", ending - beginning !calculate the CPU-time
    call execute_command_line('python3 run/plot_simulation.py') !execute python file for plotting

end program two_dim_packing_problem
