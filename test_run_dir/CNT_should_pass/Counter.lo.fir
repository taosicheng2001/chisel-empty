circuit Counter :
  module Register :
    input clock : Clock
    input reset : UInt<1>
    input io_d : UInt<8>
    output io_q : UInt<8>

    reg reg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), reg) @[Register.scala 9:22]
    io_q <= reg @[Register.scala 11:10]
    reg <= mux(reset, UInt<1>("h0"), io_d) @[Register.scala 9:{22,22} 10:9]

  module Adder :
    input clock : Clock
    input reset : UInt<1>
    input io_a : UInt<8>
    input io_b : UInt<8>
    output io_c : UInt<8>

    node _io_c_T = add(io_a, io_b) @[Adder.scala 10:16]
    node _io_c_T_1 = tail(_io_c_T, 1) @[Adder.scala 10:16]
    io_c <= _io_c_T_1 @[Adder.scala 10:8]

  module Counter :
    input clock : Clock
    input reset : UInt<1>
    output io_dout : UInt<8>

    inst reg of Register @[Counter.scala 8:21]
    inst adder of Adder @[Counter.scala 9:23]
    node _next_T = eq(reg.io_q, UInt<4>("h9")) @[Counter.scala 17:24]
    node next = mux(_next_T, UInt<1>("h0"), adder.io_c) @[Counter.scala 17:19]
    io_dout <= reg.io_q @[Counter.scala 20:13]
    reg.clock <= clock
    reg.reset <= reset
    reg.io_d <= next @[Counter.scala 18:14]
    adder.clock <= clock
    adder.reset <= reset
    adder.io_a <= UInt<8>("h1") @[Counter.scala 13:16]
    adder.io_b <= reg.io_q @[Counter.scala 14:16]
