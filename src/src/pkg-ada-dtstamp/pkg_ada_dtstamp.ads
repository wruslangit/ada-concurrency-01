-- File: pkg_ada_dtstamp.ads
-- Date: Sun 20 Dec 2020 10:34:19 AM +08
-- Author: WRY
-- Version: 1.2 Fri 30 Oct 2020 10:17:22 AM +08

with Ada.Real_Time;         use Ada.Real_Time;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

-- ========================================================
package pkg_ada_dtstamp 
with SPARK_Mode => on
is
   
   package AART renames Ada.Real_Time;
   package AASU renames Ada.Strings.Unbounded;

   procedure dtstamp;
   function  get_datestamp (RTNow : in AART.Time) return AASU.Unbounded_String;
   function  get_timestamp (RTNow : in AART.Time) return AASU.Unbounded_String;
   
   procedure execute_delay_until(Interval : AART.Time_Span);
     
-- ======================================================== 
end pkg_ada_dtstamp;

