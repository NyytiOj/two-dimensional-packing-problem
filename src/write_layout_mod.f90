module write_layout_mod
    use global_constants_mod
    use footprint_mod
    implicit none

contains
    !Function that writes the layout of rectangles in file
    !the fist row is the footprint and the rows after are the rectangles
    subroutine write_layout(ArrayDim, array, filename, fileUnit)
        implicit none
        integer(kind=ik), intent(in) :: fileUnit, ArrayDim
        type(rectangle), dimension(ArrayDim), intent(in) :: array
        type(rectangle) :: footprintRectangle
        integer(kind=ik) :: i, ios
        character (len = *), intent(in) :: filename

        !create footprint
        footprintRectangle = create_footprint(ArrayDim, array)

        open(unit = fileUnit, file = filename)

        write(fileUnit,*) footprintRectangle

        do i = 1, ArrayDim
            
            write(fileUnit,*, iostat = ios) array(i)

            if (ios /= 0) exit

        end do

        close(unit = fileUnit)

    end subroutine write_layout

end module write_layout_mod