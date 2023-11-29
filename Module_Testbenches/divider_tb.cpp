#include <iostream>

#include <verilated.h>
#include <verilated_vcd_c.h>

#include <Vdivider.h>

#define MAX_SIM_TIME 20
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    // verilator things
    Verilated::commandArgs(argc, argv);
    Vdivider *dut = new Vdivider;
    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    // open waveform for writing
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");
    int pos_edge_cnt = 0;
    while (sim_time < MAX_SIM_TIME) {
    // create test environment
        dut->clk ^= 1; // invert clock
        dut->eval();
        if(dut->clk == 1) { // only on rising edge
            pos_edge_cnt++;
            if(pos_edge_cnt == 2) {
                dut->in_en = (int8_t)1;
                dut->a = (int32_t)16;
                dut->b = (int32_t)3;
            }
            if(dut->out_en == 1) {
                std::cout << dut->q << std::endl;
                std::cout << dut->r << std::endl;
            }
        }
        m_trace->dump(sim_time); // write data to waveform
        sim_time++;
    }
    // close waveform
    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}