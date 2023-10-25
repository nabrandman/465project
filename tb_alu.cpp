#include "tb_alu.h"

#define MAX_SIM_TIME 20
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    // verilator things
    Verilated::commandArgs(argc, argv);
    Valu *alu = new Valu;
    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    // open waveform for writing
    alu->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    // create test environment
    TestEnvironment* test = new TestEnvironment(alu, &sim_time);
    // inputs to test
    std::vector<input_t> test_inputs = {{0,4,5,AluInTx::AND}, {4,8,4,AluInTx::OR}};

    while (sim_time < MAX_SIM_TIME) {
        alu->clk ^= 1; // invert clock
        alu->eval();
        if(alu->clk == 1) { // only on rising edge
            test->testInputs(&test_inputs);
        }
        m_trace->dump(sim_time); // write data to waveform
        sim_time++;
    }

    // close waveform
    m_trace->close();
    delete alu;
    delete test;
    exit(EXIT_SUCCESS);
}



//*****************************************************************************

// 
TestEnvironment::TestEnvironment(Valu* alu, vluint64_t* sim_time) {
    driver = new Driver(alu);
    scoreboard = new Scoreboard;
    monitor = new Monitor(alu, this->scoreboard);
    this->sim_time = sim_time;
}

TestEnvironment::~TestEnvironment() {
    delete driver;
    delete scoreboard;
    delete monitor;
}

void TestEnvironment::testInputs(std::vector<input_t>* inputs) {
    int len = inputs->size();
    for(int i=0; i<len; i++) {
        if((*inputs)[i].at_time == *(this->sim_time)) {
            AluInTx* tx = GenTemplateInTx((*inputs)[i].operand1,(*inputs)[i].operand2,(*inputs)[i].operation);
            driver->drive(tx);
        }
    }
    monitor->monitorIn();
    monitor->monitorOut();
}

void TestEnvironment::testRandomInputs() {

}

//
Driver::Driver(Valu* alu) {
    this->alu = alu;
}

void Driver::drive(AluInTx* tx) {
    if(tx != NULL) {
        alu->operand1_i = tx->operand1;
        alu->operand2_i = tx->operand2;
        alu->operator_i = tx->op;
        delete tx;
    }
}

// 
Monitor::Monitor(Valu* alu, Scoreboard* scoreboard) {
    this->alu = alu;
    this->scoreboard = scoreboard;
}

void Monitor::monitorIn() {
    AluInTx *tx = new AluInTx;
    tx->operand1 = alu->operand1_i;
    tx->operand2 = alu->operand2_i;
    tx->op = AluInTx::operation(alu->operator_i);

    scoreboard->writeIn(tx);
}

void Monitor::monitorOut() {
    AluOutTx *tx = new AluOutTx;
    tx->result = alu->result_o;

    scoreboard->writeOut(tx);
}

//
void Scoreboard::writeIn(AluInTx* tx) {
    in_queue.push_back(tx);
}

void Scoreboard::writeOut(AluOutTx* out) {
    AluInTx* in = in_queue.front();
    in_queue.pop_front();

    uint32_t result = 0;
    switch (in->op) {
        case AluInTx::AND:
            result = in->operand1 & in->operand2;
            if(result != out->result) {
                std::cout << in->operand1 << " & " << in->operand2 << " Expected: " << result << std::endl;
            }
            break;
        case AluInTx::OR:
            result = in->operand1 | in->operand2;
            if(result != out->result) {
                std::cout << in->operand1 << " | " << in->operand2 << " Expected: " << result << std::endl;
            }
            break;
        case AluInTx::XOR:
            result = in->operand1 ^ in->operand2;
            if(result != out->result) {
                std::cout << in->operand1 << " ^ " << in->operand2 << " Expected: " << result << std::endl;
            }
            break;
        default:
            break;
        }
    delete in;
    delete out;
} 
