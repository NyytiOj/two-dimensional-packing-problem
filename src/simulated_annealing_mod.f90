module simulated_annealing_mod
    use global_constants_mod
    use footprint_mod
    use move_object_mod
    use rand_generators_mod
    implicit none

contains
    subroutine SA(configDim, config)
        implicit none
        integer(kind=ik), intent(in) :: configDim
        type(rectangle), dimension(configDim), intent(inout) :: config
        type(rectangle), dimension(configDim) :: newConfig
        real(kind=rk) :: costf, new_costf, c, Xi, c_min, delta_f, a
        integer(kind=ik) :: i, i_max

        !Open file where the coefficient and constant parameter can be saved
        open(unit = 30, file = 'run/SA.30')

        !parameter a tells us how much do we drop the 'temperature' c in each iteration
        a = temperatureDropper
        !parameter i_max tells the number of trials with each value of c
        i_max = maxIterations

        !parameter c_min tells the smallest value for c that is acceptable
        c_min = minConstantPrmtr

        !Initial values for contorol parameter and i
        i = 1
        c = constatnprmtr

        !run the algorihm until c has reached c_min
        do while(c >= c_min)

            !try new formations i_max times
            do while( i <= i_max)

                !initial costfunction
                costf = footprint_area(configDim, config)

                !changed configuration and footprint
                newConfig = config
                call move_Random_Object(configDim, newConfig)
                new_costf = footprint_area(configDim, newConfig)

                !calculate the change in cost function
                delta_f = new_costf - costf

                !Generate a random number that is evenly distributed in unit interval [0,1]
                call random_uniform(0.0,1.0, Xi)

                !accept the new configuration if xi < delta_f
                if (Xi < exp(-delta_f/c)) then
                    config = newConfig
                end if
                i = i + 1

            end do
            write(30,*) c, costf
            c = a*c
            i = 1

        end do

        write(30,*) c, costf
        close(unit = 30)
    
    end subroutine SA



end module simulated_annealing_mod
