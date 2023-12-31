
my_main.elf:     file format elf32-littleriscv


Disassembly of section .text:

00100000 <_vectors_start>:
  .option norvc;

  // All unimplemented interrupts/exceptions go to the default_exc_handler.
  .org 0x00
  .rept 32
  jal x0, default_exc_handler
  100000:	0b00006f          	j	1000b0 <default_exc_handler>
  100004:	0ac0006f          	j	1000b0 <default_exc_handler>
  100008:	0a80006f          	j	1000b0 <default_exc_handler>
  10000c:	0a40006f          	j	1000b0 <default_exc_handler>
  100010:	0a00006f          	j	1000b0 <default_exc_handler>
  100014:	09c0006f          	j	1000b0 <default_exc_handler>
  100018:	0980006f          	j	1000b0 <default_exc_handler>
  10001c:	0940006f          	j	1000b0 <default_exc_handler>
  100020:	0900006f          	j	1000b0 <default_exc_handler>
  100024:	08c0006f          	j	1000b0 <default_exc_handler>
  100028:	0880006f          	j	1000b0 <default_exc_handler>
  10002c:	0840006f          	j	1000b0 <default_exc_handler>
  100030:	0800006f          	j	1000b0 <default_exc_handler>
  100034:	07c0006f          	j	1000b0 <default_exc_handler>
  100038:	0780006f          	j	1000b0 <default_exc_handler>
  10003c:	0740006f          	j	1000b0 <default_exc_handler>
  100040:	0700006f          	j	1000b0 <default_exc_handler>
  100044:	06c0006f          	j	1000b0 <default_exc_handler>
  100048:	0680006f          	j	1000b0 <default_exc_handler>
  10004c:	0640006f          	j	1000b0 <default_exc_handler>
  100050:	0600006f          	j	1000b0 <default_exc_handler>
  100054:	05c0006f          	j	1000b0 <default_exc_handler>
  100058:	0580006f          	j	1000b0 <default_exc_handler>
  10005c:	0540006f          	j	1000b0 <default_exc_handler>
  100060:	0500006f          	j	1000b0 <default_exc_handler>
  100064:	04c0006f          	j	1000b0 <default_exc_handler>
  100068:	0480006f          	j	1000b0 <default_exc_handler>
  10006c:	0440006f          	j	1000b0 <default_exc_handler>
  100070:	0400006f          	j	1000b0 <default_exc_handler>
  100074:	03c0006f          	j	1000b0 <default_exc_handler>
  100078:	0380006f          	j	1000b0 <default_exc_handler>
  10007c:	0340006f          	j	1000b0 <default_exc_handler>
  .endr

  // reset vector
  .org 0x80
  jal x0, reset_handler
  100080:	0340006f          	j	1000b4 <reset_handler>

00100084 <_vectors_end>:
.section .text
.balign 4
.global main

main:
	li	a5,136
  100084:	08800793          	li	a5,136
	li t0, (1 << 21)                    // TW bit is the 22nd bit in mstatus
  100088:	002002b7          	lui	t0,0x200
	csrs mstatus, t0	// Set the TW bit in the mstatus register
  10008c:	3002a073          	csrs	mstatus,t0
	jal 	ra, goto_user_mode
  100090:	00c000ef          	jal	ra,10009c <goto_user_mode>
	wfi
  100094:	10500073          	wfi
	add 	a5, a5, 1
  100098:	00178793          	addi	a5,a5,1

0010009c <goto_user_mode>:

	
goto_user_mode:
	csrw	mepc,ra
  10009c:	34109073          	csrw	mepc,ra
	lui	ra,0x2
  1000a0:	000020b7          	lui	ra,0x2
	addi	ra,ra,-2048
  1000a4:	80008093          	addi	ra,ra,-2048 # 1800 <_min_stack+0x800>
	csrc	mstatus,ra
  1000a8:	3000b073          	csrc	mstatus,ra
	mret
  1000ac:	30200073          	mret

001000b0 <default_exc_handler>:
  jal x0, simple_exc_handler
  1000b0:	1b40006f          	j	100264 <simple_exc_handler>

001000b4 <reset_handler>:
  mv  x1, x0
  1000b4:	00000093          	li	ra,0
  mv  x2, x1
  1000b8:	00008113          	mv	sp,ra
  mv  x3, x1
  1000bc:	00008193          	mv	gp,ra
  mv  x4, x1
  1000c0:	00008213          	mv	tp,ra
  mv  x5, x1
  1000c4:	00008293          	mv	t0,ra
  mv  x6, x1
  1000c8:	00008313          	mv	t1,ra
  mv  x7, x1
  1000cc:	00008393          	mv	t2,ra
  mv  x8, x1
  1000d0:	00008413          	mv	s0,ra
  mv  x9, x1
  1000d4:	00008493          	mv	s1,ra
  mv x10, x1
  1000d8:	00008513          	mv	a0,ra
  mv x11, x1
  1000dc:	00008593          	mv	a1,ra
  mv x12, x1
  1000e0:	00008613          	mv	a2,ra
  mv x13, x1
  1000e4:	00008693          	mv	a3,ra
  mv x14, x1
  1000e8:	00008713          	mv	a4,ra
  mv x15, x1
  1000ec:	00008793          	mv	a5,ra
  mv x16, x1
  1000f0:	00008813          	mv	a6,ra
  mv x17, x1
  1000f4:	00008893          	mv	a7,ra
  mv x18, x1
  1000f8:	00008913          	mv	s2,ra
  mv x19, x1
  1000fc:	00008993          	mv	s3,ra
  mv x20, x1
  100100:	00008a13          	mv	s4,ra
  mv x21, x1
  100104:	00008a93          	mv	s5,ra
  mv x22, x1
  100108:	00008b13          	mv	s6,ra
  mv x23, x1
  10010c:	00008b93          	mv	s7,ra
  mv x24, x1
  100110:	00008c13          	mv	s8,ra
  mv x25, x1
  100114:	00008c93          	mv	s9,ra
  mv x26, x1
  100118:	00008d13          	mv	s10,ra
  mv x27, x1
  10011c:	00008d93          	mv	s11,ra
  mv x28, x1
  100120:	00008e13          	mv	t3,ra
  mv x29, x1
  100124:	00008e93          	mv	t4,ra
  mv x30, x1
  100128:	00008f13          	mv	t5,ra
  mv x31, x1
  10012c:	00008f93          	mv	t6,ra
  la   x2, _stack_start
  100130:	00010117          	auipc	sp,0x10
  100134:	ed010113          	addi	sp,sp,-304 # 110000 <_stack_start>

00100138 <_start>:
  la x26, _bss_start
  100138:	00000d17          	auipc	s10,0x0
  10013c:	1d8d0d13          	addi	s10,s10,472 # 100310 <_bss_end>
  la x27, _bss_end
  100140:	00000d97          	auipc	s11,0x0
  100144:	1d0d8d93          	addi	s11,s11,464 # 100310 <_bss_end>
  bge x26, x27, zero_loop_end
  100148:	01bd5863          	bge	s10,s11,100158 <main_entry>

0010014c <zero_loop>:
  sw x0, 0(x26)
  10014c:	000d2023          	sw	zero,0(s10)
  addi x26, x26, 4
  100150:	004d0d13          	addi	s10,s10,4
  ble x26, x27, zero_loop
  100154:	ffaddce3          	bge	s11,s10,10014c <zero_loop>

00100158 <main_entry>:
  addi x10, x0, 0
  100158:	00000513          	li	a0,0
  addi x11, x0, 0
  10015c:	00000593          	li	a1,0
  jal x1, main
  100160:	f25ff0ef          	jal	ra,100084 <_vectors_end>
  li x5, SIM_CTRL_BASE + SIM_CTRL_CTRL
  100164:	000202b7          	lui	t0,0x20
  100168:	00828293          	addi	t0,t0,8 # 20008 <_stack_len+0x1e008>
  li x6, 1
  10016c:	00100313          	li	t1,1
  sw x6, 0(x5)
  100170:	0062a023          	sw	t1,0(t0)

00100174 <sleep_loop>:
  wfi
  100174:	10500073          	wfi
  j sleep_loop
  100178:	ffdff06f          	j	100174 <sleep_loop>

0010017c <uart_out>:

  return res;
}

void uart_out(uart_t uart, char c) {
  while (DEV_READ(uart + UART_STATUS_REG) & UART_STATUS_TX_FULL)
  10017c:	00852783          	lw	a5,8(a0)
  100180:	0027f793          	andi	a5,a5,2
  100184:	fe079ce3          	bnez	a5,10017c <uart_out>
    ;

  DEV_WRITE(uart + UART_TX_REG, c);
  100188:	00b52223          	sw	a1,4(a0)
}
  10018c:	00008067          	ret

00100190 <putchar>:
#include "demo_system.h"

#include "dev_access.h"
#include "uart.h"

int putchar(int c) {
  100190:	ff010113          	addi	sp,sp,-16
  100194:	00812423          	sw	s0,8(sp)
  100198:	00112623          	sw	ra,12(sp)
#ifdef SIM_CTRL_OUTPUT
  DEV_WRITE(SIM_CTRL_BASE + SIM_CTRL_OUT, c);
#else
  if (c == '\n') {
  10019c:	00a00793          	li	a5,10
int putchar(int c) {
  1001a0:	00050413          	mv	s0,a0
  if (c == '\n') {
  1001a4:	00f51863          	bne	a0,a5,1001b4 <putchar+0x24>
    uart_out(DEFAULT_UART, '\r');
  1001a8:	00d00593          	li	a1,13
  1001ac:	80001537          	lui	a0,0x80001
  1001b0:	fcdff0ef          	jal	ra,10017c <uart_out>
  }

  uart_out(DEFAULT_UART, c);
  1001b4:	0ff47593          	zext.b	a1,s0
  1001b8:	80001537          	lui	a0,0x80001
  1001bc:	fc1ff0ef          	jal	ra,10017c <uart_out>
#endif

  return c;
}
  1001c0:	00c12083          	lw	ra,12(sp)
  1001c4:	00040513          	mv	a0,s0
  1001c8:	00812403          	lw	s0,8(sp)
  1001cc:	01010113          	addi	sp,sp,16
  1001d0:	00008067          	ret

001001d4 <puts>:

int getchar(void) { return uart_in(DEFAULT_UART); }

int puts(const char* str) {
  1001d4:	ff010113          	addi	sp,sp,-16
  1001d8:	00812423          	sw	s0,8(sp)
  1001dc:	00112623          	sw	ra,12(sp)
  1001e0:	00050413          	mv	s0,a0
  while (*str) {
  1001e4:	00044503          	lbu	a0,0(s0)
  1001e8:	00051a63          	bnez	a0,1001fc <puts+0x28>
    putchar(*str++);
  }

  return 0;
}
  1001ec:	00c12083          	lw	ra,12(sp)
  1001f0:	00812403          	lw	s0,8(sp)
  1001f4:	01010113          	addi	sp,sp,16
  1001f8:	00008067          	ret
    putchar(*str++);
  1001fc:	00140413          	addi	s0,s0,1
  100200:	f91ff0ef          	jal	ra,100190 <putchar>
  100204:	fe1ff06f          	j	1001e4 <puts+0x10>

00100208 <puthex>:

void puthex(uint32_t h) {
  100208:	ff010113          	addi	sp,sp,-16
  10020c:	00812423          	sw	s0,8(sp)
  100210:	00912223          	sw	s1,4(sp)
  100214:	01212023          	sw	s2,0(sp)
  100218:	00112623          	sw	ra,12(sp)
  10021c:	00050413          	mv	s0,a0
  100220:	00800493          	li	s1,8
  // Iterate through h taking top 4 bits each time and outputting ASCII of hex
  // digit for those 4 bits
  for (int i = 0; i < 8; i++) {
    cur_digit = h >> 28;

    if (cur_digit < 10)
  100224:	00900913          	li	s2,9
    cur_digit = h >> 28;
  100228:	01c45513          	srli	a0,s0,0x1c
    if (cur_digit < 10)
  10022c:	02a96863          	bltu	s2,a0,10025c <puthex+0x54>
      putchar('0' + cur_digit);
  100230:	03050513          	addi	a0,a0,48 # 80001030 <_stack_start+0x7fef1030>
  for (int i = 0; i < 8; i++) {
  100234:	fff48493          	addi	s1,s1,-1
    else
      putchar('A' - 10 + cur_digit);
  100238:	f59ff0ef          	jal	ra,100190 <putchar>

    h <<= 4;
  10023c:	00441413          	slli	s0,s0,0x4
  for (int i = 0; i < 8; i++) {
  100240:	fe0494e3          	bnez	s1,100228 <puthex+0x20>
  }
}
  100244:	00c12083          	lw	ra,12(sp)
  100248:	00812403          	lw	s0,8(sp)
  10024c:	00412483          	lw	s1,4(sp)
  100250:	00012903          	lw	s2,0(sp)
  100254:	01010113          	addi	sp,sp,16
  100258:	00008067          	ret
      putchar('A' - 10 + cur_digit);
  10025c:	03750513          	addi	a0,a0,55
  100260:	fd5ff06f          	j	100234 <puthex+0x2c>

00100264 <simple_exc_handler>:
  } else {
    asm volatile("csrc mstatus, %0\n" : : "r"(1 << 3));
  }
}

void simple_exc_handler(void) {
  100264:	ff010113          	addi	sp,sp,-16
  puts("EXCEPTION!!!\n");
  100268:	00000517          	auipc	a0,0x0
  10026c:	06450513          	addi	a0,a0,100 # 1002cc <simple_exc_handler+0x68>
void simple_exc_handler(void) {
  100270:	00112623          	sw	ra,12(sp)
  puts("EXCEPTION!!!\n");
  100274:	f61ff0ef          	jal	ra,1001d4 <puts>
  puts("============\n");
  100278:	00000517          	auipc	a0,0x0
  10027c:	06450513          	addi	a0,a0,100 # 1002dc <simple_exc_handler+0x78>
  100280:	f55ff0ef          	jal	ra,1001d4 <puts>
  puts("MEPC:   0x");
  100284:	00000517          	auipc	a0,0x0
  100288:	06850513          	addi	a0,a0,104 # 1002ec <simple_exc_handler+0x88>
  10028c:	f49ff0ef          	jal	ra,1001d4 <puts>
  __asm__ volatile("csrr %0, mepc;" : "=r"(result));
  100290:	34102573          	csrr	a0,mepc
  puthex(get_mepc());
  100294:	f75ff0ef          	jal	ra,100208 <puthex>
  puts("\nMCAUSE: 0x");
  100298:	00000517          	auipc	a0,0x0
  10029c:	06050513          	addi	a0,a0,96 # 1002f8 <simple_exc_handler+0x94>
  1002a0:	f35ff0ef          	jal	ra,1001d4 <puts>
  __asm__ volatile("csrr %0, mcause;" : "=r"(result));
  1002a4:	34202573          	csrr	a0,mcause
  puthex(get_mcause());
  1002a8:	f61ff0ef          	jal	ra,100208 <puthex>
  puts("\nMTVAL:  0x");
  1002ac:	00000517          	auipc	a0,0x0
  1002b0:	05850513          	addi	a0,a0,88 # 100304 <simple_exc_handler+0xa0>
  1002b4:	f21ff0ef          	jal	ra,1001d4 <puts>
  __asm__ volatile("csrr %0, mtval;" : "=r"(result));
  1002b8:	34302573          	csrr	a0,mtval
  puthex(get_mtval());
  1002bc:	f4dff0ef          	jal	ra,100208 <puthex>
  putchar('\n');
  1002c0:	00a00513          	li	a0,10
  1002c4:	ecdff0ef          	jal	ra,100190 <putchar>

  while (1)
  1002c8:	0000006f          	j	1002c8 <simple_exc_handler+0x64>
