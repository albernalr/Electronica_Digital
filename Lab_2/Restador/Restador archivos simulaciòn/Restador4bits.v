/*
 * Generated by Digital. Don't modify this file!
 * Any changes will be lost if this file is regenerated.
 */

module MedioRestador (
  input A,
  input B,
  output S,
  output C_out
);
  assign S = (A ^ B);
  assign C_out = (B & ~ A);
endmodule

module RestadorCompleto (
  input A,
  input B,
  input C_in,
  output S,
  output C_out
);
  assign C_out = (((B | C_in) & ~ A) | (C_in & B));
  assign S = (A ^ B ^ C_in);
endmodule

module Restador4bits (
  input A0,
  input B0,
  input A1,
  input B1,
  input A2,
  input B2,
  input A3,
  input B3,
  output S0,
  output S3,
  output C_0ut,
  output S1,
  output S2
);
  wire s4;
  wire s5;
  wire s6;
  MedioRestador MedioRestador_i0 (
    .A( A0 ),
    .B( B0 ),
    .S( S0 ),
    .C_out( s4 )
  );
  RestadorCompleto RestadorCompleto_i1 (
    .A( A1 ),
    .B( B1 ),
    .C_in( s4 ),
    .S( S1 ),
    .C_out( s5 )
  );
  RestadorCompleto RestadorCompleto_i2 (
    .A( A2 ),
    .B( B2 ),
    .C_in( s5 ),
    .S( S2 ),
    .C_out( s6 )
  );
  RestadorCompleto RestadorCompleto_i3 (
    .A( A3 ),
    .B( B3 ),
    .C_in( s6 ),
    .S( S3 ),
    .C_out( C_0ut )
  );
endmodule
