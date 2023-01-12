module footprint_mod
    use global_constants_mod
    implicit none
    
contains
    !Crate the footprint for the rectangles
    type(rectangle) function create_footprint(dim,rectArray) result(footprint)
    implicit none
    integer(kind=ik), intent(in) :: dim
    type(rectangle), dimension(dim):: rectArray
    real(kind=rk) :: minX, maxX, minY, maxY

    !Find the corners for the footprint
    minX = minval(rectArray%x)
    maxX = maxval(rectArray%x + rectArray%width)

    minY = minval(rectArray%y)
    maxY = maxval(rectArray%y + rectArray%length)

    !create footprint of rectangles shape that can fit all of the rectangles inside it
    footprint%length = maxY-minY
    footprint%width = maxX-minX
    footprint%x = minX
    footprint%y = minY

    end function create_footprint

    !Fucntion takes in the rectangle layout and calculates the area of footprint
    real function footprint_area(dim,rectArray) result(area)
    implicit none
    integer(kind=ik), intent(in) :: dim
    type(rectangle), dimension(dim), intent(in) :: rectarray
    type(rectangle) :: footprint

    footprint = create_footprint(dim, rectarray) !create a footprint

    area = footprint%length*footprint%width !calculate the area

    end function footprint_area
    
end module footprint_mod