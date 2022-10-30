/*
 * Dummy tester to start a Chisel project.
 *
 * Author: Martin Schoeberl (martin@jopdesign.com)
 * 
 */

package empty

import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class Tester extends AnyFlatSpec with ChiselScalatestTester {

  "dut" should "work" in {
    test(new Counter).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      for(a <- 0 until 10)
        dut.clock.step()
    }
  }
}
