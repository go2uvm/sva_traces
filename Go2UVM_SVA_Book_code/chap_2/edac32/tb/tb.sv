// This functional block provides the EDAC logic to correct
// one bit error and to detect up to two bit errors in an
// 32-bit input data word. The codewords are 39-bit long.
// Check bit 7 is not used.
//
// Two parity bits have been inversed to avoid an all-zero code word.
// This code was translated directed from the VHDL package EDAC,
// as defined by the reference below.  

/* -----\/----- EXCLUDED -----\/-----
-- Authors      : Sandi Habinc
--                European Space Agency (ESA)
--                P.O. Box 299
--                NL-2200 AG Noordwijk ZH
--                The Netherlands
--
--                M. S. Hodgart,  H. A. B. Tiggeler,
--                Surrey Satellite Technology Limited (SSTL)
--                Centre for Satellite Engineering Research
--                University of Surrey
--                Guildford
--                Surrey, United Kingdom
--                GU2 5XH
--
-- Contact      : mailto:microelectronics@estec.esa.int
--                http://www.estec.esa.int/microelectronics
--
-- Reference    : W. W. Petersen and E. J. Weldon, Error-correcting Codes,
--                MIT Press, Second Edition, 1972, pp 256-261
--
-- Reference    : T.A. Gulliver and V.K. Bhargava, A Systematic (16,8) Code for
--                Correcting Double Errors and Detecting Triple-Adjacent Errors,
--                IEEE Trans. Computers, Vol. 42, No. 1, pp. 109-112, 1993
--
-- Reference    : M. S. Hodgart,  H. A. B. Tiggeler, A (16,8) Error Correcting
--                Code (t=2) for Critical Memory Applications, Proceedings of
--                DASIA 2000 - DAta Systems In Aerospace, 2000
--
--                The cyclic 8 bit EDAC codec has been developed by SSTL, with
--                explicit permission given to ESA for its VHDL source code
--                distribution.
--
-- Reference    : R. Johansson, Two Error-Detecting and Correcting Circuits for
--                Space Applications, Proceedings of the 26:th Annual
--                International Symposium on Fault-Tolerant Computing, 1996
--                {used for the EDAC16Strong and EDAC32Strong codecs}
--
-- Copyright (C): European Space Agency (ESA) 2000.
--                This source code is free software; you can redistribute it
--                and/or modify it under the terms of the GNU Lesser General
--                Public License as published by the Free Software Foundation;
--                either version 2 of the License, or (at your option) any
--                later version. For full details of the license see file
--                http://www.estec.esa.int/microelectronics/copying.lgpl
--
 -----/\----- EXCLUDED -----/\----- */



module top1; 
           logic clk;
    logic  [0:31] dataout;     // output data bits
    logic  [0:7] checkout;    // output check bits
    logic  [0:31]  datain;      // input data bits
    logic  [0:7]   checkin;     // input check bits
    logic  [0:31] datacorr;    // corrected data bits
    logic         singleerr;   // single error
    logic        doubleerr;   // double error
    logic         multipleerr; // uncorrectable error

      default clocking cb @(posedge clk);
endclocking 
edac32hamming dut(.*);
endmodule:top1 



