module create_rectangles_mod
    use global_constants_mod
    use rand_generators_mod
    use check_overlapping_mod
    implicit none
    private :: create_rectangle
    public :: create_rectangles

contains

    !Function to create a random rectangle
    type(rectangle) function create_rectangle() result(newRect)
        implicit none
        real(kind=rk) :: r1,r2,r3,r4

        !Create a random sized rectangle and assig it a random position
        call random_uniform(minRectangleDim, maxRectangleDim, r1) !Call a random value for rectangles width
        newRect%width = r1

        call random_uniform(minRectangleDim, maxRectangleDim, r2) !Call a random value for rectangles length
        newRect%length = r2

        call random_uniform(minGrid ,maxGrid - maxRectangleDim, r3) !Call a random number for rectangles x position
        newRect%x = r3

        call random_uniform(minGrid ,maxGrid- maxRectangleDim, r4) !Call a random number for rectangles y position
        newRect%y = r4

    end function create_rectangle


    !Function to create a wanted number of rectangles
    function create_rectangles(n) result(rectangleArray)
        implicit none
        integer(kind=ik), intent(in) :: n
        type(rectangle), dimension(n) :: rectangleArray
        type(rectangle) :: newRect
        integer(kind=ik) :: i = 1
        
        rectangleArray(i) = create_rectangle() !Fill the first rectangle to the array

        do
            newRect = create_rectangle() !create random rectangle

            if ( i == n) exit

            !Chech if rectangle overlaps with any of the rectangles in array
            if ( .not. check_overlapping(i+1,newRect,i+1,rectangleArray)) then
                i = i + 1
                rectangleArray(i) = newRect !if not fill the array element with rectangle

            end if

        end do

    end function create_rectangles


end module create_rectangles_mod