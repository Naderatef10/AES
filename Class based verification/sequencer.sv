class sequencer;

    transaction t1;

    function new();
    
    t1 = new();
        
    endfunction //new

    function sequence_1();
        
       t1.randomize();
       t1.input_valid = 1'b1;
        
    endfunction

    function sequence_2();
        
       
       t1.input_valid = 1'b0;
        
    endfunction

        
   
endclass //sequencer