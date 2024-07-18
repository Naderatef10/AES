class monitor;

    transaction t1;

    function new();
        t1 = new();
    endfunction //new()
    task automatic monitor_interface(virtual AES_interface monitor_class_interface);
        t1.output_valid = monitor_class_interface.output_valid;
        t1.cipher_text = monitor_class_interface.cipher_text;


    endtask //automatic


endclass //monitor