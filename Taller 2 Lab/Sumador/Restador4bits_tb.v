module testbech;

  reg [7:0] inputs;
  /* inputs[0] inputs[1] inputs[2] */
   
   /* Me pone todas las interacciones */
  
  integer i; //entera
  initial
  begin
    for (i=0; i<256; i=i+1)
    begin
      inputs = i;
      #1; //se toma un tic, control de tiempo
    end
  end

  /* // RESULT FOR DEVICE/DESIGN UNDER TEST */
  wire [4:0] outs;
  
  
  // DEVICE/DESIGN UNDER TEST dut
  Restador4bits dut (
      .A3(inputs[7]), .A2(inputs[6]), .A1(inputs[5]), .A0(inputs[4]), .B3(inputs[3]), .B2(inputs[2]), .B1(inputs[1]), .B0(inputs[0]),
    .C_0ut(outs[4]), .S3(outs[3]), .S2(outs[2]), .S1(outs[1]), .S0(outs[0])
  );

// input A0,
  // input B0,
  // input A1,
  // input B1,
  // input A2,
  // input B2,
  // input A3,
  // input B3,
  // output S0,
  // output S3,
  // output C_0ut,
  // output S1,
  // output S2
// );


  // WAVES IN VCD TO OPEN IN GTKWAVE
  initial
  begin
    $dumpfile("top.vcd");
    $dumpvars(0, testbech);
  end


endmodule
