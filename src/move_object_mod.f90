module move_object_mod
    use global_constants_mod
    use rand_generators_mod
    use check_overlapping_mod
    implicit none
    private :: move, rotate, swap_places, move_randomly
    public :: move_random_object

    
contains
    subroutine move_random_object(arraySize, constArray)
        integer(kind=ik), intent(in) :: arraySize
        type(rectangle), dimension(arraySize), intent(inout):: constArray(:) ! the original array
        type(rectangle) :: randObject1, randObject2
        integer(kind=ik) :: r1, r2
        do
            !Call two random integers that are not equal with each other and are in the range of the array
            call two_random_int(2,size(constArray), r1,r2)         

            randObject1 = constArray(r1) !Assign r1:th rectangle of the constArray to a helper variable
            randObject2 = constArray(r2) !Assign r2:th rectangle of the constArray to a helper variable

            call move_randomly(randObject1, randObject2) !move randomly the helper variable(s)
            
            !Now we want to check wether there is any overlap after the random move
            if (.not. check_overlapping(r1,randObject1, arraySize, constArray) &
            .and. .not. check_overlapping(r2,randObject2, arraySize, constArray)) then
            
                !If there is no overlapping, we assign the new places for the rectangles in the array
                constArray(r1) = randObject1
                constArray(r2) = randObject2
                exit
            end if

        end do
    end subroutine move_random_object


    !move object randomly
    !there is an even change for rectangle to move, rotate or swap places with an other rectangle
    subroutine move_randomly(object1, object2)
        implicit none
        type(rectangle), intent(inout) :: object1, object2
        integer(kind=ik) :: r
        real(kind=rk) :: x,y


        call random_integer(1,3,r) !assign radomly integer 1, 2 or 3 to variable r

        if (r == 1) then
            
            call random_uniform(0.0,maxGrid-maxRectangleDim, x) !call for a new random x position
            call random_uniform(0.0,maxGrid-maxRectangleDim, y) !call for a new random y position
            call move(object1, x,y) !move object to new location

        else if (r==2) then
    
            call swap_places(object1, object2) !swap places of two rectangles

        else if (r==3) then
        
            call rotate(object1) ! rotate the rectangle

        end if

    end subroutine move_randomly


    !Function that moves object to a new position 
    subroutine move(object, x, y)
        implicit none
        type(rectangle), intent(inout) :: object
        real(kind=rk) :: x,y

        object%x = x
        object%y = y

    end subroutine move

    !Swap places of two objects
    subroutine swap_places(object1, object2)
        implicit none
        type(rectangle), intent(inout) :: object1, object2
        real(kind=rk) :: x1, y1, centerX1, centerY1, centerX2, centerY2

        !the center position of object1
        centerX1 = object1%x + 0.5*object1%width
        centerY1 = object1%y + 0.5*object1%length

        !the center position of object2
        centerX2 = object2%x + 0.5*object2%width
        centerY2 = object2%y + 0.5*object2%length

        x1 = centerX1 !hepler variable
        y1 = centerY1 !helper variable

        !swap the position coordinates of the rectangles
        centerX1 = centerX2
        centerY1 = centerY2

        centerX2 = x1
        centerY2 = y1

    end subroutine

    !Rotate object 90 degrees on its center axis
    subroutine rotate(object)
        implicit none
        type(rectangle), intent(inout) :: object
        real(kind=rk) :: width, CenterX, CenterY

        width = object%width

        !make sure the center of the rectangle stays put
        centerX = object%x + 0.5*object%width
        CenterY = object%y + 0.5*object%length

        !flip the width and length
        object%width = object%length
        object%length = width

        !calculate the new place for the left corner of the rectangle
        object%x = CenterX - 0.5*object%width
        object%y = CenterY - 0.5*object%length
    end subroutine rotate

end module move_object_mod