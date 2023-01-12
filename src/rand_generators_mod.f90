module rand_generators_mod
    use mtmod
    use global_constants_mod
    implicit none
    
contains

    subroutine random_stduniform(u)
        implicit none
        real(kind=rk),intent(out) :: u
        real(kind=rk) :: rndm
        call random_number(rndm)
        u = 1 - rndm
    end subroutine random_stduniform

      ! assuming a<b
    subroutine random_uniform(a,b,rndm)
        implicit none
        real(kind=rk),intent(in) :: a,b
        real(kind=rk),intent(out) :: rndm
        real(kind=rk) :: u
        call random_stduniform(u)
        rndm = (b-a)*u + a
    end subroutine random_uniform

    subroutine random_integer(a,b,rndm)
        implicit none
        integer(kind=ik), intent(in) :: a,b
        integer(kind=ik), intent(out) :: rndm
        integer(kind=ik) :: seed
        seed = getseed()
        call sgrnd(seed)
        rndm = igrnd(a,b)
    end subroutine random_integer

    
    ! subroutine that gives always two different integers in range [a,b]
    subroutine two_random_int(a,b,rndm1,rndm2)
        implicit none
        integer(kind=ik), intent(inout) :: rndm1, rndm2
        integer(kind=ik), intent(in) :: a,b

        do
            call random_integer(a,b, rndm1)
            call random_integer(a,b, rndm2)
            if (rndm1 /= rndm2) exit
        end do
            
    end subroutine two_Random_Int
    
end module rand_generators_mod