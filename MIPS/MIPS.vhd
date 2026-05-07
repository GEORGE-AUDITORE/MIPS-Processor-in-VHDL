library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPS is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC
    );
end MIPS;

architecture Structural of MIPS is

    -- === Component Declarations ===

    component PC
        Port (
            clk    : in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            PC_in  : in  STD_LOGIC_VECTOR(31 downto 0);
            PC_out : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Imem
        Port (
            address : in  STD_LOGIC_VECTOR(3 downto 0);
            instr   : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Signextension
        Port (
            input16  : in  STD_LOGIC_VECTOR(15 downto 0);
            output32 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Control
        Port (
            opcode     : in  STD_LOGIC_VECTOR(5 downto 0);
            RegDst     : out STD_LOGIC;
            ALUSrc     : out STD_LOGIC;
            MemtoReg   : out STD_LOGIC;
            RegWrite   : out STD_LOGIC;
            MemRead    : out STD_LOGIC;
            MemWrite   : out STD_LOGIC;
            Branch     : out STD_LOGIC;
            ALUOp      : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    component Registerfile
        Port (
            clk       : in  STD_LOGIC;
            regWrite  : in  STD_LOGIC;
            readReg1  : in  STD_LOGIC_VECTOR(3 downto 0);
            readReg2  : in  STD_LOGIC_VECTOR(3 downto 0);
            writeReg  : in  STD_LOGIC_VECTOR(3 downto 0);
            writeData : in  STD_LOGIC_VECTOR(31 downto 0);
            readData1 : out STD_LOGIC_VECTOR(31 downto 0);
            readData2 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component ALUcontrol
        Port (
            ALUOp      : in  STD_LOGIC_VECTOR(1 downto 0);
            Funct      : in  STD_LOGIC_VECTOR(5 downto 0);
            ALUControl : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component ALU
        Port (
            A      : in  STD_LOGIC_VECTOR(31 downto 0);
            B      : in  STD_LOGIC_VECTOR(31 downto 0);
            ALUop  : in  STD_LOGIC_VECTOR(3 downto 0);
            Result : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Datamem
        Port (
            clk       : in  STD_LOGIC;
            memRead   : in  STD_LOGIC;
            memWrite  : in  STD_LOGIC;
            address   : in  STD_LOGIC_VECTOR(3 downto 0);
            writeData : in  STD_LOGIC_VECTOR(31 downto 0);
            readData  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Mux2to1_32bit
        Port (
            in0    : in  STD_LOGIC_VECTOR(31 downto 0);
            in1    : in  STD_LOGIC_VECTOR(31 downto 0);
            sel    : in  STD_LOGIC;
            muxOut : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Mux2to1_5bit
        Port (
            in0    : in  STD_LOGIC_VECTOR(4 downto 0);
            in1    : in  STD_LOGIC_VECTOR(4 downto 0);
            sel    : in  STD_LOGIC;
            muxOut : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

    component Leftshift
        Port (
            input   : in  STD_LOGIC_VECTOR(31 downto 0);
            shifted : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    component Adder32
        Port (
            A      : in  STD_LOGIC_VECTOR(31 downto 0);
            B      : in  STD_LOGIC_VECTOR(31 downto 0);
            result : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- === Signal Declarations ===

    signal PC_out, PC_next, instr : STD_LOGIC_VECTOR(31 downto 0);
    signal opcode                 : STD_LOGIC_VECTOR(5 downto 0);
    signal rs, rt, rd             : STD_LOGIC_VECTOR(4 downto 0);
    signal funct                  : STD_LOGIC_VECTOR(5 downto 0);
    signal imm16                  : STD_LOGIC_VECTOR(15 downto 0);
    signal imm32, branchOffset   : STD_LOGIC_VECTOR(31 downto 0);
    signal branchAddr, pc_plus1  : STD_LOGIC_VECTOR(31 downto 0);
    signal readData1, readData2  : STD_LOGIC_VECTOR(31 downto 0);
    signal regDstMuxOut          : STD_LOGIC_VECTOR(4 downto 0);
    signal ALU_B, ALU_result     : STD_LOGIC_VECTOR(31 downto 0);
    signal memReadData, writeData: STD_LOGIC_VECTOR(31 downto 0);
    signal RegDst, ALUSrc, MemtoReg, RegWrite : STD_LOGIC;
    signal MemRead, MemWrite, Branch          : STD_LOGIC;
    signal ALUOp                              : STD_LOGIC_VECTOR(1 downto 0);
    signal ALU_control                        : STD_LOGIC_VECTOR(3 downto 0);
    signal pcSrc                              : STD_LOGIC;

begin

    -- === Main MIPS Datapath ===

    pc_unit: PC port map (clk, reset, PC_next, PC_out);

    imem_unit: Imem port map (PC_out(3 downto 0), instr);

    opcode <= instr(31 downto 26);
    rs     <= instr(25 downto 21);
    rt     <= instr(20 downto 16);
    rd     <= instr(15 downto 11);
    funct  <= instr(5 downto 0);
    imm16  <= instr(15 downto 0);

    signext_unit: Signextension port map (imm16, imm32);

    control_unit: Control port map (
        opcode, RegDst, ALUSrc, MemtoReg, RegWrite,
        MemRead, MemWrite, Branch, ALUOp
    );

    alu_control_unit: ALUcontrol port map (ALUOp, funct, ALU_control);

    regfile_unit: Registerfile port map (
        clk       => clk,
        regWrite  => RegWrite,
        readReg1  => rs(3 downto 0),
        readReg2  => rt(3 downto 0),
        writeReg  => regDstMuxOut(3 downto 0),
        writeData => writeData,
        readData1 => readData1,
        readData2 => readData2
    );

    regdst_mux: Mux2to1_5bit port map (
        in0    => rt,
        in1    => rd,
        sel    => RegDst,
        muxOut => regDstMuxOut
    );

    alusrc_mux: Mux2to1_32bit port map (
        in0    => readData2,
        in1    => imm32,
        sel    => ALUSrc,
        muxOut => ALU_B
    );

    alu_unit: ALU port map (
        A      => readData1,
        B      => ALU_B,
        ALUop  => ALU_control,
        Result => ALU_result
    );

    datamem_unit: Datamem port map (
        clk       => clk,
        memRead   => MemRead,
        memWrite  => MemWrite,
        address   => ALU_result(3 downto 0),
        writeData => readData2,
        readData  => memReadData
    );

    memtoreg_mux: Mux2to1_32bit port map (
        in0    => ALU_result,
        in1    => memReadData,
        sel    => MemtoReg,
        muxOut => writeData
    );

    pc_plus1_adder: Adder32 port map (
        A      => PC_out,
        B      => x"00000001",
        result => pc_plus1
    );

    shift_unit: Leftshift port map (
        input   => imm32,
        shifted => branchOffset
    );

    branch_adder: Adder32 port map (
        A      => pc_plus1,
        B      => branchOffset,
        result => branchAddr
    );

    pcSrc <= '1' when (Branch = '1' and ALU_result /= x"00000000") else '0';



    pc_mux: Mux2to1_32bit port map (
        in0    => pc_plus1,
        in1    => branchAddr,
        sel    => pcSrc,
        muxOut => PC_next
    );

end Structural;

