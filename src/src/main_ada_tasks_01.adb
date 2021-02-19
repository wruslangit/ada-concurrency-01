with Ada.Text_IO;
with pkg_ada_dtstamp;
with Ada.Real_Time;

-- ========================================================
procedure main_ada_tasks_01 
with SPARK_Mode => on
is 

  -- RENAMING STANDARD PACKAGES FOR CONVENIENCE
   package ATIO    renames Ada.Text_IO;
   package PADTS   renames pkg_ada_dtstamp;
   package ART     renames Ada.Real_Time;
   
   the_delay : ART.Time_Span := ART.To_Time_Span(10.0);
   
begin
   PADTS.dtstamp;
   ATIO.Put_Line ("Bismillah 3 times WRY");
   ATIO.Put_Line ("Running inside GNAT Studio Community");

   PADTS.execute_delay_until (the_delay);
        
   PADTS.dtstamp;
   ATIO.Put_Line ("Alhamdulillah 3 times WRY");
   
-- ========================================================   
end main_ada_tasks_01;

-- COMPILATION ============================================
-- gprbuild -d -P/home/wruslan/github/spark-studio-01/spark_studio_01.gpr -s -k
-- Compile
--   [Ada]          spkmain_studio_01.adb
--   [Ada]          pkg_ada_dtstamp.adb
--   [Ada]          pkg_math_functions.adb
-- Bind
--   [gprbind]      spkmain_studio_01.bexch
--   [Ada]          spkmain_studio_01.ali
-- Link
--   [link]         spkmain_studio_01.adb
-- [2021-02-17 19:15:06] process terminated successfully, elapsed time: 01.24s

-- EXECUTION ==============================================
-- /home/wruslan/github/spark-studio-01/exec/spkmain_studio_01.adx
-- 2021-02-17 11:16:20.40496735828 Bismillah 3 times WRY
-- Running inside GNAT Studio Community
-- result1 =  1.24000E+01
-- result2 =  1.00000E+00
-- result3 =  3
-- 2021-02-17 11:16:20.40496777131 Alhamdulillah 3 times WRY
-- [2021-02-17 19:16:20] process terminated successfully, elapsed time: 00.20s

-- SPARK EXAMINE ALL ======================================
-- gnatprove -P/home/wruslan/github/spark-studio-01/spark_studio_01.gpr -j0 --mode=flow --ide-progress-bar --report=all
-- Phase 1 of 2: generation of Global contracts ...
-- Phase 2 of 2: analysis of data and information flow ...
-- warning: no bodies have been analyzed by GNATprove
-- enable analysis of a non-generic body using SPARK_Mode
-- [2021-02-17 19:17:59] process terminated successfully, elapsed time: 02.08s


