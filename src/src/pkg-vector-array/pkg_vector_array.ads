-- File: pkg_vector_array.ads
-- Date: Sat 20 Feb 2021 03:35:09 PM +08
-- Author: WRY
-- Version: 1.2 Fri 30 Oct 2020 10:17:22 AM +08

with Ada.Real_Time;         use Ada.Real_Time;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- ========================================================
package pkg_vector_array 
with SPARK_Mode => on
is
  
   package AART renames Ada.Real_Time;
   package AASU renames Ada.Strings.Unbounded;
  
  -- ======================================================
   type Vector is array (1..10_000) of Integer;
   type Vector_Prt is access all Vector;
   type Vector_Const is access constant Vector; 
   
   procedure SumDiff (A, B : Vector_Const;
                      Sum  : Vector_Prt;
                      Diff : Vector_Prt);
   
   procedure exec_task_01;
   -- procedure exec_task_02;
   -- procedure exec_task_03;
                      
  -- ======================================================

   procedure dtstamp;
   function  get_datestamp (RTNow : in AART.Time) return AASU.Unbounded_String;
   function  get_timestamp (RTNow : in AART.Time) return AASU.Unbounded_String;
   
   procedure exec_delay_time (interval : AART.Time_Span); -- REAL SECONDS
   procedure exec_delay_sec  (sec  : in Positive);  -- INTEGER
   procedure exec_delay_msec (msec : in Positive);
   procedure exec_delay_usec (usec : in Positive);
   procedure exec_delay_nsec (nsec : in Positive);
   
   procedure exec_check_overrun(the_start, the_finish : in AART.Time; the_deadline : in AART.Time_Span);
   function  getif_overrun(the_start, the_finish : in AART.Time; the_deadline : in AART.Time_Span) return Boolean;
   
-- ======================================================== 
end pkg_vector_array;

