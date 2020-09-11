
-- Prueba basica de dos tareas utilizando una region critica para
-- acceder a la pantalla

with Ada.Real_Time, Kernel.Serial_Output;
use Ada.Real_Time, Kernel.Serial_Output;

package body Tareas_RC is

   protected RC is
      pragma priority(2);

      procedure salir;
      entry entrar;

   private
      libre : boolean := true;
   end RC;

   protected body RC is

      procedure Salir is
      begin
         libre := true;
      end;

      entry Entrar when libre is
      begin
         libre := false;
      end;
   end RC;

   task tarea1 is
      pragma priority(2);
   end tarea1;

   task body tarea1 is
      Hora : Time;
      Incremento : Time_Span := Milliseconds(100);
   begin
      Hora := Clock;
      loop
         RC.Entrar;
         Put_Line("Tarea 1 en RC");
         RC.Salir;
         Hora := Hora + Incremento;
         delay until Hora;
      end loop;
   end Tarea1;

   task Tarea2 is
      pragma Priority(1);
   end Tarea2;

   task body Tarea2 is
      Hora : Time;
      Incremento : Time_Span := Milliseconds(1000);
   begin
      Hora := Clock;
      loop
         RC.Entrar;
         Put_Line("Tarea 2 en RC");
         RC.Salir;
         Hora := Hora + Incremento;
         delay until Hora;
      end loop;
   end Tarea2;

   procedure Ocioso is
   begin
      loop
         null;
      end loop;
   end Ocioso;

end Tareas_RC;
