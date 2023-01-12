module global_constants_mod
    implicit none
    !Kind values
    integer, parameter :: ik = selected_int_kind(8) ! kind = 4 
    integer, parameter :: rk = selected_real_kind(5,10) ! kind = 4


    !here you can change the parameters for the rectangles
    integer(kind = ik), parameter :: nRectancles =  5!How many rectangles do we want to generate
    real(kind=rk), parameter :: maxRectangleDim = 50, minRectangleDim = 10 !The largerst and smallest values for the width and hight of a rectangle
    real(kind = rk), parameter :: maxGrid = 200, minGrid = 0 !The area where the rectangles should fit
   
    !The SA parameters [how much we drop the temperature at a time, how many iterations with one temperature and minimun value for the temperature]
    !now temperature is the same thing as constant parameter
    real(kind=rk), parameter :: temperatureDropper = 0.98, maxIterations = 15, minConstantPrmtr = 0.01, constatnprmtr = 10


    !Do not change this!
    !Type rectangle that has its 2 dimensional position, width and length
    type :: rectangle
        real(kind=rk) :: x,y, width, length
    end type rectangle


end module global_constants_mod