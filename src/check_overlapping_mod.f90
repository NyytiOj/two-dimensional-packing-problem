module check_overlapping_mod
    use global_constants_mod
    implicit none
    public :: check_overlapping
    private :: does_any_rects_overlap, does_rects_overlap
    
contains

!see if the rectangles overlap with any of the rectangles already made
logical function does_rects_overlap(rect1, rect2) result(bool)
    implicit none
    type(rectangle), intent(in) :: rect1, rect2
    real(kind=rk) :: xMin1, yMin1, xMax1, yMax1
    real(kind=rk) :: xMin2, yMin2, xMax2, yMax2

    bool = .True.

    !Count the points where the corners of the rectangle1 are
    xMin1 = rect1%x
    yMin1 = rect1%y

    xMax1 = rect1%x + rect1%width
    yMax1 = rect1%y + rect1%length

    !Count the points where the corners of the rectangle2 are
    xMin2 = rect2%x
    yMin2 = rect2%y

    xMax2 = rect2%x + rect2%width
    yMax2 = rect2%y + rect2%length

    !Check if the two rectangles overlap
    if (xMax2 <= xMin1 .or. xMin2 >= xMax1 .or. yMax2 <= yMin1 .or. yMin2 >= yMax1) then
        bool = .False. 
    end if        

end function does_rects_overlap

!Check wether any of the rectangles in an array overlap with the new rectangle
logical function does_any_rects_overlap(dim,rectArray,rect) result(bool)
    implicit none
    integer(kind=ik), intent(in) :: dim
    type(rectangle), intent(in) :: rect
    type(rectangle), dimension(dim), intent(in) :: rectArray
    integer(kind=ik) :: i

    do i = 1,dim
        bool = does_rects_overlap(rectArray(i), rect)
        if (bool) exit
    end do


end function does_any_rects_overlap

    

!Function to check wether given rectangle overlaps with any of the existing ones in the array
logical function check_overlapping(r,rect, dim, rectArray) result(bool)
    integer(kind=ik), intent(in) :: r, dim
    type(rectangle), dimension(dim), intent(in):: rectArray(:)
    type(rectangle), allocatable :: partArray1(:), partArray2(:)
    type(rectangle), intent(in):: rect
    
    bool = .False. !Return False, if rectangles don't overlap

    allocate(partArray1(r-1),partArray2(dim-r))

    !If the chosen rectangle is the first element of the array
    if (r == 1) then
        
        partArray1 = rectArray(2:)
        !separate the first element of the array
        if (does_any_rects_overlap(dim-1,partArray1, rect)) then
            bool = .True.
        end if

    !or the last element of the array
    else if (r == dim) then

        !separate the last element of the array
        partArray1 = rectArray(1:dim-1)
        if (does_any_rects_overlap(dim-1,partArray1, rect)) then
            bool = .True.
        end if
    !otherwise
    else
        !Divide the array to two partArrays
        partArray1 = rectArray(1:r-1) !The array from first element to r-1 element
        partArray2 = rectArray(r+1:size(rectArray)) !The array from r+1 element to the end of the array

        !Chech if there is any overlap
        if (does_any_rects_overlap(r-1, partArray1, Rect) .or. does_any_rects_overlap(size(rectArray)-r, partArray2, Rect)) then
            bool = .True. !If rectangles don't overlap then return false
        end if

    end if

end function check_overlapping
    
end module check_overlapping_mod