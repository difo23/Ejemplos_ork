with Ada.Real_Time, Kernel.Serial_Output;
use Ada.Real_Time, Kernel.Serial_Output;

procedure Prueba_0 is
   Hora : Time;
   Incremento : Time_Span := Milliseconds(1000);
begin
   Hora := Clock;
   loop
      Put_Line( "Hola" );
      Hora := Hora + Incremento;
      delay until Hora;
   end loop;
end Prueba_0;
