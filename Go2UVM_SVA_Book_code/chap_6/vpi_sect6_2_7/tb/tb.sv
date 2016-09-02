/*
Code for use with the book
"SystemVerilog Assertions Handbook, 2nd edition"ISBN  878-0-9705394-8-7

Code is copyright of VhdlCohen Publishing & CVC Pvt Ltd., copyright 2009 

www.systemverilog.us  ben@systemverilog.us
www.cvcblr.com, info@cvcblr.com

All code provided in this book and in the accompanied website is distributed
 with *ABSOLUTELY NO SUPPORT* and *NO WARRANTY* from the authors.  Neither
the authors nor any supporting vendors shall be liable for damage in connection
with, or arising out of, the furnishing, performance or use of the models
provided in the book and website.
*/
//  in fife vpi_sect6_2_7.c 
// // #include <stdio.h> 
// // #include <vpi_user.h>
// // #include <vcs_vpi_user.h>
// // #include <sv_vpi_user.h>
// // #include <vcsuser.h>
// // void assert_cov (int data, int reason)
// // {
// //   vpiHandle assertion_h, itr_h;
// //   char * a_name;
// //   int a_attempts, a_true_success, a_vac_success, a_failures;
// //   itr_h = vpi_iterate(vpiAssertion, NULL);
// //   vpi_printf ("SystemVerilog Assertions Statistics - demo from SVA Handbook\n");
// //   vpi_printf ("Assertion Name: \t \t No. of True Success \t No. of Vacuous Success \t 
// //                        No. of Failures \t No. of total attempts \n");
// //       while (assertion_h = vpi_scan(itr_h)) {		
// // 	 a_name = vpi_get_str(vpiFullName, assertion_h);
// // 	 a_attempts = vpi_get(vpiAssertAttemptCovered, assertion_h);
// // 	 a_true_success = vpi_get(vpiAssertSuccessCovered, assertion_h);
// // 	 a_vac_success = vpi_get(vpiAssertVacuousSuccessCovered, assertion_h);
// // 	 a_failures = vpi_get(vpiAssertFailureCovered, assertion_h);
// // 	 vpi_printf ("%0s  %0d \t %0d \t %0d \t %0d \t %0d \n",
// // 		a_name, a_true_success, a_vac_success, a_failures, a_attempts);
//     } /* while */
// } /* assert_cov */

module cov_api_test1;
  timeunit 1ns;
  timeprecision 100ps;

logic clk;

cov_api_test dut(.*);

default clocking @(posedge clk); endclocking

 endmodule : cov_api_test1

  
