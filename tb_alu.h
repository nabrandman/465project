#ifndef __TB_ALU_H__
#define __TB_ALU_H__

#include <stdlib.h>
#include <iostream>
#include <deque>
#include <vector>

// Verilator headers
#include <verilated.h>
#include <verilated_vcd_c.h>
// Verilator generated headers
#include "Valu.h"
#include "Valu___024unit.h"

#define _RED "\033[31m"
#define _GREEN "\033[32m"
#define _RESET "\033[0m"
#define GREEN(x) _GREEN x _RESET // makes the string x the color green
#define RED(x) _GREEN x _RESET // makes the string x the color red

//
class AluInTx {
    public:
        uint32_t operand1;
        uint32_t operand2;
        enum operation {
            AND = Valu___024unit::AND,
            OR = Valu___024unit::OR,
            XOR = Valu___024unit::XOR
        } op;
};

//
class AluOutTx {
    public:
        uint32_t result;
};

// Creates a 
// Arguments:
//  operand1 - signed 32-bit integer
//  operand2 - signed 32-bit integer
//  operation - the operation to be performed
// Returns:
//  pointer to created AluInTx object
AluInTx* GenTemplateInTx(int32_t operand1, int32_t operand2, AluInTx::operation operation) {
    AluInTx* item = new AluInTx;
    item->operand1 = operand1;
    item->operand2 = operand2;
    item->op = operation;
    return item;
}

typedef struct input {
    vluint64_t at_time;
    int32_t operand1;
    int32_t operand2;
    AluInTx::operation operation;
} input_t;

class Driver {
    private:
        Valu *alu;
    public:
        Driver(Valu *in);
        void drive(AluInTx* tx);
};


//
class Scoreboard {
    private:
        std::deque<AluInTx*> in_queue;
    public:
        void writeIn(AluInTx *tx);
        void writeOut(AluOutTx *out);
            
};

//
class Monitor {
    private:
        Valu *alu;
        Scoreboard *scoreboard;
    public:
        Monitor(Valu *alu, Scoreboard *alu_scb);
        void monitorIn();
        void monitorOut();
};


class TestEnvironment {
    private:
        vluint64_t* sim_time;
        Driver* driver;
        Monitor* monitor;
        Scoreboard* scoreboard;
    public:
        TestEnvironment(Valu* alu, vluint64_t* sim_time);
        ~TestEnvironment();
        void testInputs(std::vector<input_t>* inputs); 
        void testRandomInputs();
};

#endif
