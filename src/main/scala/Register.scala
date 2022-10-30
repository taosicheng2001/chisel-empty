import chisel3._

class Register extends Module{
    val io = IO(new Bundle{
        val d = Input(UInt(8.W))
        val q = Output(UInt(8.W))
    })

    val reg = RegInit(0.U)
    reg := io.d
    io.q := reg
}