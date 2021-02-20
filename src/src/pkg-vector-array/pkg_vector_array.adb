-- File   : pkg_vector_array.adb
-- Date   : Sat 20 Feb 2021 03:35:09 PM +08
-- Env	   : Linux HPEliteBook8470p-Ub2004-rt38 5.4.66-rt38
-- #1 SMP PREEMPT_RT Sat Sep 26 16:51:59 +08 2020 x86_64 x86_64 x86_64 GNU/Linux
-- Author: WRY wruslandr@gmail.com
-- ========================================================
-- GNAT Studio Community 2020 (20200427) hosted on x86_64-pc-linux-gnu
-- GNAT 9.3.1 targetting x86_64-linux-gnu
-- SPARK Community 2020 (20200818)

with Ada.Text_IO;
with Ada.Calendar;
with Ada.Calendar.Formatting;
with Ada.Calendar.Time_Zones;
with Ada.Real_Time; use Ada.Real_Time;  -- NOTICE THIS use

-- ADA STRING MANIPULATION
-- Ada has three(3) types of strings:
-- fixed length, bounded length, unbounded.
with Ada.Strings;
with Ada.Strings.Fixed;
with Ada.Strings.Bounded;
with Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO;
with Ada.Command_Line;

-- ========================================================
package body pkg_vector_array 
-- with SPARK_Mode => on
is

   -- RENAMING STANDARD PACKAGES FOR CONVENIENCE
   package ATIO   renames Ada.Text_IO;
   package ACal   renames Ada.Calendar;
   package ACalF  renames Ada.Calendar.Formatting;
   package ART    renames Ada.Real_Time;

   -- RENAMING ADA STRING PACKAGES
   package AS     renames Ada.Strings;
   package ASF    renames Ada.Strings.Fixed;
   package ASB    renames Ada.Strings.Bounded;
   package ASU    renames Ada.Strings.Unbounded;
   package ASUTIO renames Ada.Strings.Unbounded.Text_IO;
   package ACL    renames Ada.Command_Line;  
    
    -- ALL REQUIRED FOR INITIALIZATION ONLY
     sec_RTInterval  : ART.Time_Span  := ART.Seconds(1);
    msec_RTInterval  : ART.Time_Span  := ART.Milliseconds(1);
    usec_RTInterval  : ART.Time_Span  := ART.Microseconds(1);
    nsec_RTInterval  : ART.Time_Span  := ART.Nanoseconds (1);
    RTNext	           : ART.Time       := ART.Clock;

    -- ====================================================
    -- Procedure using two(2) tasks
    -- ====================================================
    procedure SumDiff (A, B : Vector_Const;
                       Sum  : Vector_Prt;
                       Diff : Vector_Prt) 
    is 
        task type Minus;
        task type Plus;
        tsk_Minus : Minus;
        tsk_Plus  : Plus;
    
    -- =====================     
        task body Minus is
        
        begin
          for I in Vector'Range loop
              Diff(I) := A(I) - B(I);
          end loop;
        end Minus;
        
    -- =====================     
        task body Plus is
        
        begin
          for I in Vector'Range loop
              Sum(I) := A(I) + B(I);
          end loop;
        end Plus;    
                        
    -- =====================                         
    begin
      null;
    end SumDiff;

   -- ===================================================
   procedure exec_task_01 is
      
      task type Minus1;
      task type Plus1;
      tsk_Minus : Minus1;
      tsk_Plus  : Plus1;
     
     -- =====================     
        task body Minus1 is
        
        begin
         for I in 1..10 loop
              dtstamp; ATIO.Put_Line("Minus1 here ");
              exec_delay_msec (500);
          end loop;
        end Minus1;
        
    -- =====================     
        task body Plus1 is
        
        begin
         for I in 1..10 loop
              dtstamp; ATIO.Put_Line("Plus1 here ");
              exec_delay_msec (500);
          end loop;
        end Plus1;    
                          
      
     
    -- =====================                         
    begin
      null;
   end exec_task_01;
 
  
    -- ====================================================
    -- DEFINE GETTIME FUNCTION 
    -- ====================================================
    function GetTime(RTNow : ART.Time) return String is
	     Seconds  : ART.Seconds_Count;
	     Fraction : ART.Time_Span;
    begin
	     ART.Split(RTNow, Seconds, Fraction);
        declare
          TFraction : constant String := Duration'Image(ART.To_Duration(Fraction));
	    begin
	       return TFraction(4..TFraction'Last);
	    end;
    end GetTime; 

    -- ====================================================
    -- (1) DISPLAY THE DATE-TIME STAMP
    -- ====================================================
    procedure dtstamp is
    begin
      ATIO.Put (ACal.Formatting.Image(ACal.Clock,True, 0));
      ATIO.Put (GetTime(ART.Clock) & " ");
	end dtstamp;

   -- ====================================================
   -- (2) GET THE DATE STAMP
   -- ==================================================== 
    function get_datestamp(RTNow : ART.Time) return ASU.Unbounded_String is
         the_date   : ASU.Unbounded_String; -- "2020-12-19 19:26:22.75";
         datestring : ASU.Unbounded_String; -- "2020-12-19";
    begin
	      -- Slice characters. Take front 1 to 10 characters.
         the_date   := ASU.To_Unbounded_String (ACal.Formatting.Image (ACal.Clock, True, 0));
         datestring := ASU.Unbounded_Slice (the_date, 1, 10);
         return (datestring);
	 end get_dateStamp; -- FUNCTION END

   -- ====================================================
   -- (3) GET THE TIME STAMP
   -- ====================================================
    function get_timestamp(RTNow : ART.Time) return ASU.Unbounded_String is
         the_date  : ASU.Unbounded_String;     -- "2020-12-19 19:26:22.75";
         time_only : ASU.Unbounded_String;     -- "19:26:22.75";
         fraction_only : ASU.Unbounded_String; -- "158130892108";
         timestring : ASU.Unbounded_String;    -- "19:26:22.7558130892108";
    begin
         -- Slice and concatenate unbounded strings
         the_date  := ASU.To_Unbounded_String (ACal.Formatting.Image (ACal.Clock, True, 0));
         time_only := ASU.Unbounded_Slice (the_date, 12, 22);
         fraction_only := ASU.To_Unbounded_String (GetTime(ART.Clock));
         timestring := time_only & fraction_only; -- concatenate
         return (timestring);
	 end get_timestamp; 
  
   -- ====================================================
   -- (4) EXECUTE DELAY UNTIL (SECONDS)
   -- ====================================================
    procedure exec_delay_time (interval : ART.Time_Span) is
  	   -- As with delay, delay until is accurate only in its lower bound. 
      -- The task involved will not be released before the current time has 
      -- reached that specified in the statement, but it may be released later.
            
    begin
      delay until (ART.Clock + interval);
	end exec_delay_time; 
 
 -- =====================================================
 -- (1) ONCE-OFF DELAY SEC
 -- =====================================================
   procedure exec_delay_sec (sec : in Positive) is
   begin
       delay until ART.Clock + ART.Seconds(sec);
   end exec_delay_sec;   
   
 -- =====================================================
 -- (2) ONCE-OFF DELAY MSEC
 -- =====================================================
   procedure exec_delay_msec (msec : in Positive) is
   begin
       delay until ART.Clock + ART.Milliseconds(msec);
   end exec_delay_msec; 
   
 -- =====================================================
 -- (3) ONCE-OFF DELAY USEC
 -- =====================================================
   procedure exec_delay_usec (usec : in Positive) is
   begin
       delay until ART.Clock + ART.Microseconds(usec);
   end exec_delay_usec;   
   
 -- =====================================================
 -- (4) ONCE-OFF DELAY NSEC
 -- =====================================================
   procedure exec_delay_nsec (nsec : in Positive) is
   begin
       delay until ART.Clock + ART.Nanoseconds(nsec);
   end exec_delay_nsec; 
   
 -- =====================================================
 -- (5) PROCEDURE CHECK EXECUTION OVERRUN
 -- =====================================================   
   procedure exec_check_overrun(the_start, the_finish : in AART.Time; the_deadline : in AART.Time_Span) is
      the_overrun : AART.Time_Span;
   begin
      if getif_overrun(the_start, the_finish, the_deadline) then
         
         ATIO.Put_Line ("Raise Execution Overrun +++");      
         ATIO.Put("   Execution duration (sec) = "); 
         ATIO.Put_Line(Duration'Image(To_Duration(the_finish - the_start))); 
         ATIO.Put("   Deadline  duration (sec) = "); 
         ATIO.Put_Line(Duration'Image(To_Duration(the_deadline))); 
         ATIO.Put("   Overrun   time     (sec) = ");
         the_overrun := (the_finish - the_start) - (the_deadline);
         ATIO.Put_Line(Duration'Image(To_Duration(the_overrun)));
         ATIO.New_Line;
      else 
         ATIO.Put_Line ("Raise Execution Underrun ---");      
         ATIO.Put("   Execution duration (sec) = "); 
         ATIO.Put_Line(Duration'Image(To_Duration(the_finish - the_start))); 
         ATIO.Put("   Deadline  duration (sec) = "); 
         ATIO.Put_Line(Duration'Image(To_Duration(the_deadline))); 
         ATIO.Put("   Underrun  time     (sec) = ");
         the_overrun := (the_finish - the_start) - (the_deadline);
         ATIO.Put_Line(Duration'Image(To_Duration(the_overrun))); 
         ATIO.New_Line;
      end if;
   end exec_check_overrun;
   
    -- =====================================================
 -- (6) FUNCTION EXECUTION OVERRUN
 -- =====================================================  
   function getif_overrun(the_start, the_finish : in AART.Time; the_deadline : in AART.Time_Span) return Boolean is
   begin
      if (the_finish - the_start) > the_deadline then
         return True; 
      else 
         return False; 
      end if;
      
   end getif_overrun;   
   
-- ========================================================
begin
    null;

end pkg_vector_array;
-- ========================================================
