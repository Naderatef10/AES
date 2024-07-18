class driver;
    transaction t1;
    virtual AES_interface driver_class_interface;
    function new();
        t1 = new();
    endfunction //new()

    task automatic drive_interface(virtual AES_interface vif);
        
        driver_class_interface = vif;
       

    endtask //automatic

    task automatic drive_inputs();

        driver_class_interface.plain_text = t1.plain_text;
        driver_class_interface.key = t1.key;
        driver_class_interface.input_valid = t1.input_valid;
        
    endtask //automatic

endclass //driver
