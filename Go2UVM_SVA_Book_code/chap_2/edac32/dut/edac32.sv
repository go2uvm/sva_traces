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



module edac32hamming (input clk,
 input  [0:31] dataout,     // output data bits
    output [0:7] checkout,    // output check bits
    input [0:31]  datain,      // input data bits
    input [0:7]   checkin,     // input check bits
    output [0:31] datacorr,    // corrected data bits
   output        singleerr,   // single error
   output        doubleerr,   // double error
   output        multipleerr, // uncorrectable error
    ) ;

   // input  [0:31] dataout;     // output data bits
 //   output [0:7] checkout;    // output check bits
  //  input [0:31]  datain;      // input data bits
  //  input [0:7]   checkin;     // input check bits
 //   output [0:31] datacorr;    // corrected data bits
 //   output        singleerr;   // single error
  //  output        doubleerr;   // double error
 //   output        multipleerr; // uncorrectable error

    reg [0:7]             checkout;
    reg [0:31]            datacorr;
    reg                   doubleerr;
    reg                   multipleerr;
    reg                   singleerr;

    task edac32h;
        input  [0:31] dataout;     // output data bits
        output [0:7] checkout;    // output check bits
        input  [0:31] datain;      // input data bits
        input  [0:7]  checkin;     // input check bits
        output [0:31] datacorr;    // corrected data bits
        output        singleerr;   // single error
        output        doubleerr;   // double error
        output        multipleerr; // uncorrectable error

        reg [0:6] parity;   //  parity
        reg [0:6] syndrome; // syndrome
        begin
            // check bit generator
            parity[0] =      datain[31] ^ datain[30] ^ datain[29] ^
            datain[28] ^ datain[24] ^ datain[21] ^
            datain[20] ^ datain[19] ^ datain[15] ^
            datain[11] ^ datain[10] ^ datain[9]  ^
            datain[8]  ^ datain[5]  ^ datain[4]  ^
            datain[1];
            parity[1] =      datain[30] ^ datain[28] ^ datain[25] ^
            datain[24] ^ datain[20] ^ datain[17] ^
            datain[16] ^ datain[15] ^ datain[13] ^
            datain[12] ^ datain[9]  ^ datain[8]  ^
            datain[7]  ^ datain[6]  ^ datain[4]  ^
            datain[3];
            parity[2] = ~ (datain[31] ^ datain[26] ^ datain[22] ^
                     datain[19] ^ datain[18] ^ datain[16] ^
                     datain[15] ^ datain[14] ^ datain[10] ^
                     datain[8]  ^ datain[6]  ^ datain[5]  ^
                     datain[4]  ^ datain[3]  ^ datain[2]  ^
                     datain[1]);
            parity[3] = ~ (datain[31] ^ datain[30] ^ datain[27] ^
                     datain[23] ^ datain[22] ^ datain[19] ^
                     datain[15] ^ datain[14] ^ datain[13] ^
                     datain[12] ^ datain[10] ^ datain[9]  ^
                     datain[8]  ^ datain[7]  ^ datain[4]  ^
                     datain[0]);
            parity[4] =      datain[30] ^ datain[29] ^ datain[27] ^
            datain[26] ^ datain[25] ^ datain[24] ^
            datain[21] ^ datain[19] ^ datain[17] ^
            datain[12] ^ datain[10] ^ datain[9]  ^
            datain[4]  ^ datain[3]  ^ datain[2]  ^
            datain[0];
            parity[5] =      datain[31] ^ datain[26] ^ datain[25] ^
            datain[23] ^ datain[21] ^ datain[20] ^
            datain[18] ^ datain[14] ^ datain[13] ^
            datain[11] ^ datain[10] ^ datain[9]  ^
            datain[8]  ^ datain[6]  ^ datain[5]  ^
            datain[0];
            parity[6] =      datain[31] ^ datain[30] ^ datain[29] ^
            datain[28] ^ datain[27] ^ datain[23] ^
            datain[22] ^ datain[19] ^ datain[18] ^
            datain[17] ^ datain[16] ^ datain[15] ^
            datain[11] ^ datain[7]  ^ datain[2]  ^
            datain[1];

            // syndrome bit generator
            syndrome[0] =    parity[0] ^ checkin[0];
            syndrome[1] =    parity[1] ^ checkin[1];
            syndrome[2] =    parity[2] ^ checkin[2];
            syndrome[3] =    parity[3] ^ checkin[3];
            syndrome[4] =    parity[4] ^ checkin[4];
            syndrome[5] =    parity[5] ^ checkin[5];
            syndrome[6] =    parity[6] ^ checkin[6];

            // bit corrector

            datacorr             = datain;                    // uncorrected default

            case (syndrome)                                    // bit error correction
                7'b0001110: begin                              // single data error
                    datacorr[0]    = ~ datain[0];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end
                7'b1010001: begin                              // single data error
                    datacorr[1]    = ~ datain[1];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end
                7'b0010101: begin                              // single data error
                    datacorr[2]    = ~ datain[2];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0110100: begin                              // single data error
                    datacorr[3]    = ~ datain[3];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1111100: begin                              // single data error
                    datacorr[4]    = ~ datain[4];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1010010: begin                              // single data error
                    datacorr[5]    = ~ datain[5];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0110010: begin                              // single data error
                    datacorr[6]    = ~ datain[6];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0101001: begin                              // single data error
                    datacorr[7]    = ~ datain[7];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1111010: begin                              // single data error
                    datacorr[8]    = ~ datain[8];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1101110: begin                              // single data error
                    datacorr[9]    = ~ datain[9];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1011110: begin                              // single data error
                    datacorr[10]   = ~ datain[10];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1000011: begin                              // single data error
                    datacorr[11]   = ~ datain[11];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0101100: begin                              // single data error
                    datacorr[12]   = ~ datain[12];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0101010: begin                              // single data error
                    datacorr[13]   = ~ datain[13];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0011010: begin                              // single data error
                    datacorr[14]   = ~ datain[14];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1111001: begin                              // single data error
                    datacorr[15]   = ~ datain[15];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0110001: begin                              // single data error
                    datacorr[16]   = ~ datain[16];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0100101: begin                              // single data error
                    datacorr[17]   = ~ datain[17];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0010011: begin                              // single data error
                    datacorr[18]   = ~ datain[18];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1011101: begin                              // single data error
                    datacorr[19]   = ~ datain[19];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1100010: begin                              // single data error
                    datacorr[20]   = ~ datain[20];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1000110: begin                              // single data error
                    datacorr[21]   = ~ datain[21];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0011001: begin                              // single data error
                    datacorr[22]   = ~ datain[22];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0001011: begin                              // single data error
                    datacorr[23]    = ~ datain[23];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1100100: begin                              // single data error
                    datacorr[24]    = ~ datain[24];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0100110: begin                              // single data error
                    datacorr[25]   = ~ datain[25];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0010110: begin                              // single data error
                    datacorr[26]   = ~ datain[26];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b0001101: begin                              // single data error
                    datacorr[27]   = ~ datain[27];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1100001: begin                              // single data error
                    datacorr[28]   = ~ datain[28];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1000101: begin                              // single data error
                    datacorr[29]   = ~ datain[29];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1101101: begin                              // single data error
                    datacorr[30]   = ~ datain[30];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        
                7'b1011011: begin                              // single data error
                    datacorr[31]   = ~ datain[31];
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end        

                7'b1000000: begin                              // single parity error
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end

                7'b0100000:  begin                              // single parity error
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end

                7'b0010000: begin                              // single parity error
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end

                7'b0001000: begin                              // single parity error
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end

                7'b0000100: begin                              // single parity error
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end

                7'b0000010: begin                              // single parity error
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end

                7'b0000001: begin                              // single parity error
                    singleerr      = 1'b1;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end

                7'b0000000: begin                              // no errors
                    singleerr      = 1'b0;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b0;                       // uncorrectable error
                end

                default: begin                                // multiple errors
                    singleerr      = 1'b0;                       // single correctable
                    doubleerr      = 1'b0;                       // double correctable
                    multipleerr    = 1'b1;                       // uncorrectable error
                end         
            endcase // 


                // check bit generator output
            checkout[0] =      dataout[31] ^ dataout[30] ^ dataout[29] ^
            dataout[28] ^ dataout[24] ^ dataout[21] ^
            dataout[20] ^ dataout[19] ^ dataout[15] ^
            dataout[11] ^ dataout[10] ^ dataout[9]  ^
            dataout[8]  ^ dataout[5]  ^ dataout[4]  ^
            dataout[1];
            checkout[1] =      dataout[30] ^ dataout[28] ^ dataout[25] ^
            dataout[24] ^ dataout[20] ^ dataout[17] ^
            dataout[16] ^ dataout[15] ^ dataout[13] ^
            dataout[12] ^ dataout[9]  ^ dataout[8]  ^
            dataout[7]  ^ dataout[6]  ^ dataout[4]  ^
            dataout[3];
            checkout[2] = ~ (dataout[31] ^ dataout[26] ^ dataout[22] ^
                       dataout[19] ^ dataout[18] ^ dataout[16] ^
                       dataout[15] ^ dataout[14] ^ dataout[10] ^
                       dataout[8]  ^ dataout[6]  ^ dataout[5]  ^
                       dataout[4]  ^ dataout[3]  ^ dataout[2]  ^
                       dataout[1]);
            checkout[3] = ~ (dataout[31] ^ dataout[30] ^ dataout[27] ^
                       dataout[23] ^ dataout[22] ^ dataout[19] ^
                       dataout[15] ^ dataout[14] ^ dataout[13] ^
                       dataout[12] ^ dataout[10] ^ dataout[9]  ^
                       dataout[8]  ^ dataout[7]  ^ dataout[4]  ^
                       dataout[0]);
            checkout[4] =      dataout[30] ^ dataout[29] ^ dataout[27] ^
            dataout[26] ^ dataout[25] ^ dataout[24] ^
            dataout[21] ^ dataout[19] ^ dataout[17] ^
            dataout[12] ^ dataout[10] ^ dataout[9]  ^
            dataout[4]  ^ dataout[3]  ^ dataout[2]  ^
            dataout[0];
            checkout[5] =      dataout[31] ^ dataout[26] ^ dataout[25] ^
            dataout[23] ^ dataout[21] ^ dataout[20] ^
            dataout[18] ^ dataout[14] ^ dataout[13] ^
            dataout[11] ^ dataout[10] ^ dataout[9]  ^
            dataout[8]  ^ dataout[6]  ^ dataout[5]  ^
            dataout[0];
            checkout[6] =      dataout[31] ^ dataout[30] ^ dataout[29] ^
            dataout[28] ^ dataout[27] ^ dataout[23] ^
            dataout[22] ^ dataout[19] ^ dataout[18] ^
            dataout[17] ^ dataout[16] ^ dataout[15] ^
            dataout[11] ^ dataout[7]  ^ dataout[2]  ^
            dataout[1];
            checkout[7] =      1'b0;    
        end
    endtask // edac32h

    always @ (dataout or checkin or datain) begin
        edac32h(
        dataout,     // output data bits   
        checkout,    // output check bits  
        datain,      // input data bits    
        checkin,     // input check bits   
        datacorr,    // corrected data bits
        singleerr,   // single error       
        doubleerr,   // double error       
        multipleerr // uncorrectable error
        ) ;
    end


endmodule // edac32hamming




