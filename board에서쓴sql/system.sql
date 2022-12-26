update board set views = (views +1) where board_no = 1;

select * from board where board_no in(1,2);