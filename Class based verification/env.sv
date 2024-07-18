class env;
driver drive_instant;
sequencer sequencer_instant;
monitor monitor_instant;

    function new();
        drive_instant = new();
        sequencer_instant = new();
        monitor_instant = new();
    endfunction //new()
    task automatic configure_sequence(int select);
        if(select)begin
        sequencer_instant.sequence_1();
        drive_instant.t1 = sequencer_instant.t1;
        drive_instant.drive_inputs();
        end
        else begin
        sequencer_instant.sequence_2();
        drive_instant.t1 = sequencer_instant.t1;
        drive_instant.drive_inputs();

        end 
    endtask //automatic
    task automatic env_configure(virtual AES_interface env_class_interface);

        drive_instant.drive_interface(env_class_interface);
        monitor_instant.monitor_interface(env_class_interface);
        
    endtask //automatic
endclass //env