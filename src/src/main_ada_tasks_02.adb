with Ada.Text_IO;
with pkg_ada_dtstamp;
with Ada.Real_Time; use Ada.Real_Time;

-- ========================================================
procedure main_ada_tasks_02
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
   the_deadline := ART.To_Time_Span(6.0);
   the_start    := ART.Clock;
       PADTS.exec_delay_time (ART.To_Time_Span(2.5));
       PADTS.exec_delay_time (ART.To_Time_Span(4.0));
   the_finish := ART.Clock;
     
   if PADTS.exec_overrun(the_start, the_finish, the_deadline) then
      ATIO.Put_Line ("Execution overrun 1"); 
      PADTS.exec_check_overrun(the_start, the_finish, the_deadline);
   else 
      ATIO.Put_Line ("No overrun 1"); 
      PADTS.exec_check_overrun(the_start, the_finish, the_deadline);
   end if;
   
    -- Boolean Function test timing overrun
   the_deadline := ART.To_Time_Span(5.5);
   the_start    := ART.Clock;
        PADTS.exec_delay_msec (1_500);
        PADTS.exec_delay_usec (3_000_000);
   the_finish := ART.Clock;

   if PADTS.exec_overrun(the_start, the_finish, the_deadline) then
      ATIO.Put_Line ("Execution overrun 2"); 
      PADTS.exec_check_overrun(the_start, the_finish, the_deadline);
   else 
      ATIO.Put_Line ("No overrun 2"); 
      PADTS.exec_check_overrun(the_start, the_finish, the_deadline);
   end if;
   
   
   PADTS.dtstamp;
   ATIO.Put_Line ("Alhamdulillah 3 times WRY");
   
-- ========================================================   
end main_ada_tasks_02;

-- EXECUTION ==============================================


