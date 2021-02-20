with Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

with pkg_ada_dtstamp;
with pkg_embedded_car;
with pkg_vector_array;

-- ========================================================
procedure main_ada_tasks_04
with SPARK_Mode => on
is 

  -- RENAMING STANDARD PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package ART     renames Ada.Real_Time;
   
   package PADTS   renames pkg_ada_dtstamp;
   package PEC     renames pkg_embedded_car;
   package PVA     renames pkg_vector_array;
   
   the_start, the_finish : ART.Time; 
   the_deadline  : ART.Time_Span;
   
   -- PVA.SumDiff(A, B, Sum, Diff);
   -- A    : PVA.Vector;
   -- B    : PVA.Vector;
   -- Sum  : PVA.Vector_Prt;
   -- Diff : PVA.Vector_Prt;
   
begin
   PADTS.dtstamp;
   ATIO.Put_Line ("Bismillah 3 times WRY");
   ATIO.Put_Line ("Running inside GNAT Studio Community");

   -- =====================================================
   -- Procedure test timing for overrun
   the_deadline := ART.To_Time_Span(0.075);
   the_start    := ART.Clock;
   for idx in 1..10 loop 
      PADTS.exec_delay_time (ART.To_Time_Span(0.0025));      
   end loop;   
   the_finish := ART.Clock;
   PADTS.exec_check_overrun(the_start, the_finish, the_deadline);
   
   -- =====================================================   
   -- Introduce Ada tasks
   -- =====================================================
   -- Example of a processor embedded into a car, which is composed of the following tasks:
   -- 1. A task displays every 100 milliseconds the current speed of the car.
   -- 2. A task reads a speed sensor every 250 milliseconds.
   -- 3. A task runs an engine monitoring program every 500 milliseconds.
   -- tsk_display_speed
   -- tsk_read_speed
   -- tsk_monitor_engine
   
   PEC.dtstamp; ATIO.Put_Line("Testing PEC only");
   ATIO.New_Line;
   
   PVA.dtstamp; ATIO.Put_Line("Testing PVA only");
   ATIO.New_Line;
   
   -- A := (1..10_000);
   -- B := (100..10_100);
   -- Sum :=
   -- Diff :=           
   -- PVA.SumDiff(A, B, Sum, Diff);
   
   PVA.exec_task_01;
   
   PADTS.dtstamp;
   ATIO.Put_Line ("Alhamdulillah 3 times WRY");
   
-- ========================================================   
end main_ada_tasks_04;

-- EXECUTION ==============================================
