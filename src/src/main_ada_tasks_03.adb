with Ada.Text_IO;
with pkg_ada_dtstamp;
with Ada.Real_Time; use Ada.Real_Time;

-- ========================================================
procedure main_ada_tasks_03
with SPARK_Mode => on
is 

  -- RENAMING STANDARD PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package PADTS   renames pkg_ada_dtstamp;
   package ART     renames Ada.Real_Time;

   the_start, the_finish : ART.Time; 
   the_deadline  : ART.Time_Span;
   
begin
   PADTS.dtstamp;
   ATIO.Put_Line ("Bismillah 3 times WRY");
   ATIO.Put_Line ("Running inside GNAT Studio Community");

   -- Procedure test timing overrun
   the_deadline := ART.To_Time_Span(0.00005);
   the_start    := ART.Clock;
       PADTS.exec_delay_time (ART.To_Time_Span(0.000025));
       PADTS.exec_delay_time (ART.To_Time_Span(0.000014));
   the_finish := ART.Clock;
   PADTS.exec_check_overrun(the_start, the_finish, the_deadline);
   
   -- Procedure test timing no overrun
   the_deadline := ART.To_Time_Span(0.00075);
   the_start    := ART.Clock;
       PADTS.exec_delay_time (ART.To_Time_Span(0.00025));
       PADTS.exec_delay_time (ART.To_Time_Span(0.00014));
   the_finish := ART.Clock;
   PADTS.exec_check_overrun(the_start, the_finish, the_deadline);
   
   PADTS.dtstamp;
   ATIO.Put_Line ("Alhamdulillah 3 times WRY");
   
-- ========================================================   
end main_ada_tasks_03;

-- EXECUTION ==============================================
-- /home/wruslan/github/ada-concurrent-01/exec/main_ada_tasks_03.adx
-- 2021-02-20 03:55:00.34431024481 Bismillah 3 times WRY
-- Running inside GNAT Studio Community
-- Raise Execution Overrun ...
--   Execution duration (sec) =  0.000586245
--   Deadline  duration (sec) =  0.000500000
--   Overrun   time     (sec) =  0.000086245
--
-- Raise Execution Underrun ...
--   Execution duration (sec) =  0.000668480
--   Deadline  duration (sec) =  0.000700000
--   Underrun  time     (sec) = -0.000031520
--
-- 2021-02-20 03:55:00.35432441375 Alhamdulillah 3 times WRY
-- [2021-02-20 11:55:00] process terminated successfully, elapsed time: 00.19s

-- ========================================================
-- /home/wruslan/github/ada-concurrent-01/exec/main_ada_tasks_03.adx
-- 2021-02-20 04:07:07.83916729105 Bismillah 3 times WRY
-- Running inside GNAT Studio Community
-- Raise Execution Overrun ...
--   Execution duration (sec) =  0.000340603
--   Deadline  duration (sec) =  0.000050000
--   Overrun   time     (sec) =  0.000290603
--
-- Raise Execution Overrun ...
--   Execution duration (sec) =  0.000700807
--   Deadline  duration (sec) =  0.000700000
--   Overrun   time     (sec) =  0.000000807
--
-- 2021-02-20 04:07:07.83917941988 Alhamdulillah 3 times WRY
-- [2021-02-20 12:07:07] process terminated successfully, elapsed time: 00.19s

-- ========================================================
-- /home/wruslan/github/ada-concurrent-01/exec/main_ada_tasks_03.adx
-- 2021-02-20 04:13:10.04125138790 Bismillah 3 times WRY
-- Running inside GNAT Studio Community
-- Raise Execution Overrun +++
--   Execution duration (sec) =  0.000311553
--   Deadline  duration (sec) =  0.000050000
--   Overrun   time     (sec) =  0.000261553
--
-- Raise Execution Underrun ---
--   Execution duration (sec) =  0.000737314
--   Deadline  duration (sec) =  0.000750000
--   Underrun  time     (sec) = -0.000012686

-- 2021-02-20 04:13:10.04126248916 Alhamdulillah 3 times WRY
-- [2021-02-20 12:13:10] process terminated successfully, elapsed time: 00.19s

