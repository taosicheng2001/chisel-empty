import chisel3._

class Counter extends Module{
    val io = IO(new Bundle{
        val dout = Output(UInt(8.W))
    })

    val reg = Module(new Register())
    val adder = Module(new Adder())

    val cnt = reg.io.q

    adder.io.a := 1.U
    adder.io.b := cnt
    val result = adder.io.c
    
    val next = Mux(cnt === 9.U,0.U,result)
    reg.io.d := next

    io.dout := cnt

}