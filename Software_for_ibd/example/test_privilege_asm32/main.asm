
my_main.elf:     file format elf32-littleriscv


Disassembly of section .text:

00100000 <_vectors_start>:
  .option norvc;

  // All unimplemented interrupts/exceptions go to the default_exc_handler.
  .org 0x00
  .rept 32
  jal x0, default_exc_handler
  100000:	0aa0006f          	j	1000aa <default_exc_handler>
  100004:	0a60006f          	j	1000aa <default_exc_handler>
  100008:	0a20006f          	j	1000aa <default_exc_handler>
  10000c:	09e0006f          	j	1000aa <default_exc_handler>
  100010:	09a0006f          	j	1000aa <default_exc_handler>
  100014:	0960006f          	j	1000aa <default_exc_handler>
  100018:	0920006f          	j	1000aa <default_exc_handler>
  10001c:	08e0006f          	j	1000aa <default_exc_handler>
  100020:	08a0006f          	j	1000aa <default_exc_handler>
  100024:	0860006f          	j	1000aa <default_exc_handler>
  100028:	0820006f          	j	1000aa <default_exc_handler>
  10002c:	07e0006f          	j	1000aa <default_exc_handler>
  100030:	07a0006f          	j	1000aa <default_exc_handler>
  100034:	0760006f          	j	1000aa <default_exc_handler>
  100038:	0720006f          	j	1000aa <default_exc_handler>
  10003c:	06e0006f          	j	1000aa <default_exc_handler>
  100040:	06a0006f          	j	1000aa <default_exc_handler>
  100044:	0660006f          	j	1000aa <default_exc_handler>
  100048:	0620006f          	j	1000aa <default_exc_handler>
  10004c:	05e0006f          	j	1000aa <default_exc_handler>
  100050:	05a0006f          	j	1000aa <default_exc_handler>
  100054:	0560006f          	j	1000aa <default_exc_handler>
  100058:	0520006f          	j	1000aa <default_exc_handler>
  10005c:	04e0006f          	j	1000aa <default_exc_handler>
  100060:	04a0006f          	j	1000aa <default_exc_handler>
  100064:	0460006f          	j	1000aa <default_exc_handler>
  100068:	0420006f          	j	1000aa <default_exc_handler>
  10006c:	03e0006f          	j	1000aa <default_exc_handler>
  100070:	03a0006f          	j	1000aa <default_exc_handler>
  100074:	0360006f          	j	1000aa <default_exc_handler>
  100078:	0320006f          	j	1000aa <default_exc_handler>
  10007c:	02e0006f          	j	1000aa <default_exc_handler>
  .endr

  // reset vector
  .org 0x80
  jal x0, reset_handler
  100080:	02e0006f          	j	1000ae <reset_handler>

00100084 <_vectors_end>:
.balign 4
.global main


main:
	li	a5,136
  100084:	08800793          	li	a5,136
	csrw	mstatus,a5
  100088:	30079073          	csrw	mstatus,a5
	jal 	ra, goto_user_mode
  10008c:	00a000ef          	jal	ra,100096 <goto_user_mode>
	csrw 	mstatus, a5
  100090:	30079073          	csrw	mstatus,a5
	add 	a5, a5, 1
  100094:	0785                	addi	a5,a5,1

00100096 <goto_user_mode>:

goto_user_mode:
	csrw	mepc,ra
  100096:	34109073          	csrw	mepc,ra
	lui	ra,0x2
  10009a:	6089                	lui	ra,0x2
	addi	ra,ra,-2048
  10009c:	80008093          	addi	ra,ra,-2048 # 1800 <_min_stack+0x800>
	csrc	mstatus,ra
  1000a0:	3000b073          	csrc	mstatus,ra
	mret
  1000a4:	30200073          	mret
	add 	a5, a5, 1
  1000a8:	0785                	addi	a5,a5,1

001000aa <default_exc_handler>:
  jal x0, simple_exc_handler
  1000aa:	10a0006f          	j	1001b4 <simple_exc_handler>

001000ae <reset_handler>:
  mv  x1, x0
  1000ae:	00000093          	li	ra,0
  mv  x2, x1
  1000b2:	8106                	mv	sp,ra
  mv  x3, x1
  1000b4:	8186                	mv	gp,ra
  mv  x4, x1
  1000b6:	8206                	mv	tp,ra
  mv  x5, x1
  1000b8:	8286                	mv	t0,ra
  mv  x6, x1
  1000ba:	8306                	mv	t1,ra
  mv  x7, x1
  1000bc:	8386                	mv	t2,ra
  mv  x8, x1
  1000be:	8406                	mv	s0,ra
  mv  x9, x1
  1000c0:	8486                	mv	s1,ra
  mv x10, x1
  1000c2:	8506                	mv	a0,ra
  mv x11, x1
  1000c4:	8586                	mv	a1,ra
  mv x12, x1
  1000c6:	8606                	mv	a2,ra
  mv x13, x1
  1000c8:	8686                	mv	a3,ra
  mv x14, x1
  1000ca:	8706                	mv	a4,ra
  mv x15, x1
  1000cc:	8786                	mv	a5,ra
  mv x16, x1
  1000ce:	8806                	mv	a6,ra
  mv x17, x1
  1000d0:	8886                	mv	a7,ra
  mv x18, x1
  1000d2:	8906                	mv	s2,ra
  mv x19, x1
  1000d4:	8986                	mv	s3,ra
  mv x20, x1
  1000d6:	8a06                	mv	s4,ra
  mv x21, x1
  1000d8:	8a86                	mv	s5,ra
  mv x22, x1
  1000da:	8b06                	mv	s6,ra
  mv x23, x1
  1000dc:	8b86                	mv	s7,ra
  mv x24, x1
  1000de:	8c06                	mv	s8,ra
  mv x25, x1
  1000e0:	8c86                	mv	s9,ra
  mv x26, x1
  1000e2:	8d06                	mv	s10,ra
  mv x27, x1
  1000e4:	8d86                	mv	s11,ra
  mv x28, x1
  1000e6:	8e06                	mv	t3,ra
  mv x29, x1
  1000e8:	8e86                	mv	t4,ra
  mv x30, x1
  1000ea:	8f06                	mv	t5,ra
  mv x31, x1
  1000ec:	8f86                	mv	t6,ra
  la   x2, _stack_start
  1000ee:	00010117          	auipc	sp,0x10
  1000f2:	f1210113          	addi	sp,sp,-238 # 110000 <_stack_start>

001000f6 <_start>:
  la x26, _bss_start
  1000f6:	00000d17          	auipc	s10,0x0
  1000fa:	152d0d13          	addi	s10,s10,338 # 100248 <_bss_end>
  la x27, _bss_end
  1000fe:	00000d97          	auipc	s11,0x0
  100102:	14ad8d93          	addi	s11,s11,330 # 100248 <_bss_end>
  bge x26, x27, zero_loop_end
  100106:	01bd5763          	bge	s10,s11,100114 <main_entry>

0010010a <zero_loop>:
  sw x0, 0(x26)
  10010a:	000d2023          	sw	zero,0(s10)
  addi x26, x26, 4
  10010e:	0d11                	addi	s10,s10,4
  ble x26, x27, zero_loop
  100110:	ffaddde3          	bge	s11,s10,10010a <zero_loop>

00100114 <main_entry>:
  addi x10, x0, 0
  100114:	4501                	li	a0,0
  addi x11, x0, 0
  100116:	4581                	li	a1,0
  jal x1, main
  100118:	f6dff0ef          	jal	ra,100084 <_vectors_end>
  li x5, SIM_CTRL_BASE + SIM_CTRL_CTRL
  10011c:	000202b7          	lui	t0,0x20
  100120:	02a1                	addi	t0,t0,8 # 20008 <_stack_len+0x1e008>
  li x6, 1
  100122:	4305                	li	t1,1
  sw x6, 0(x5)
  100124:	0062a023          	sw	t1,0(t0)

00100128 <sleep_loop>:
  wfi
  100128:	10500073          	wfi
  j sleep_loop
  10012c:	bff5                	j	100128 <sleep_loop>

0010012e <uart_out>:

  return res;
}

void uart_out(uart_t uart, char c) {
  while (DEV_READ(uart + UART_STATUS_REG) & UART_STATUS_TX_FULL)
  10012e:	451c                	lw	a5,8(a0)
  100130:	8b89                	andi	a5,a5,2
  100132:	fff5                	bnez	a5,10012e <uart_out>
    ;

  DEV_WRITE(uart + UART_TX_REG, c);
  100134:	c14c                	sw	a1,4(a0)
}
  100136:	8082                	ret

00100138 <putchar>:
#include "demo_system.h"

#include "dev_access.h"
#include "uart.h"

int putchar(int c) {
  100138:	1141                	addi	sp,sp,-16
  10013a:	c422                	sw	s0,8(sp)
  10013c:	c606                	sw	ra,12(sp)
#ifdef SIM_CTRL_OUTPUT
  DEV_WRITE(SIM_CTRL_BASE + SIM_CTRL_OUT, c);
#else
  if (c == '\n') {
  10013e:	47a9                	li	a5,10
int putchar(int c) {
  100140:	842a                	mv	s0,a0
  if (c == '\n') {
  100142:	00f51663          	bne	a0,a5,10014e <putchar+0x16>
    uart_out(DEFAULT_UART, '\r');
  100146:	45b5                	li	a1,13
  100148:	80001537          	lui	a0,0x80001
  10014c:	37cd                	jal	10012e <uart_out>
  }

  uart_out(DEFAULT_UART, c);
  10014e:	0ff47593          	zext.b	a1,s0
  100152:	80001537          	lui	a0,0x80001
  100156:	3fe1                	jal	10012e <uart_out>
#endif

  return c;
}
  100158:	40b2                	lw	ra,12(sp)
  10015a:	8522                	mv	a0,s0
  10015c:	4422                	lw	s0,8(sp)
  10015e:	0141                	addi	sp,sp,16
  100160:	8082                	ret

00100162 <puts>:

int getchar(void) { return uart_in(DEFAULT_UART); }

int puts(const char* str) {
  100162:	1141                	addi	sp,sp,-16
  100164:	c422                	sw	s0,8(sp)
  100166:	c606                	sw	ra,12(sp)
  100168:	842a                	mv	s0,a0
  while (*str) {
  10016a:	00044503          	lbu	a0,0(s0)
  10016e:	e509                	bnez	a0,100178 <puts+0x16>
    putchar(*str++);
  }

  return 0;
}
  100170:	40b2                	lw	ra,12(sp)
  100172:	4422                	lw	s0,8(sp)
  100174:	0141                	addi	sp,sp,16
  100176:	8082                	ret
    putchar(*str++);
  100178:	0405                	addi	s0,s0,1
  10017a:	3f7d                	jal	100138 <putchar>
  10017c:	b7fd                	j	10016a <puts+0x8>

0010017e <puthex>:

void puthex(uint32_t h) {
  10017e:	1141                	addi	sp,sp,-16
  100180:	c422                	sw	s0,8(sp)
  100182:	c226                	sw	s1,4(sp)
  100184:	c04a                	sw	s2,0(sp)
  100186:	c606                	sw	ra,12(sp)
  100188:	842a                	mv	s0,a0
  10018a:	44a1                	li	s1,8
  // Iterate through h taking top 4 bits each time and outputting ASCII of hex
  // digit for those 4 bits
  for (int i = 0; i < 8; i++) {
    cur_digit = h >> 28;

    if (cur_digit < 10)
  10018c:	4925                	li	s2,9
    cur_digit = h >> 28;
  10018e:	01c45513          	srli	a0,s0,0x1c
    if (cur_digit < 10)
  100192:	00a96e63          	bltu	s2,a0,1001ae <puthex+0x30>
      putchar('0' + cur_digit);
  100196:	03050513          	addi	a0,a0,48 # 80001030 <_stack_start+0x7fef1030>
  for (int i = 0; i < 8; i++) {
  10019a:	14fd                	addi	s1,s1,-1
    else
      putchar('A' - 10 + cur_digit);
  10019c:	3f71                	jal	100138 <putchar>

    h <<= 4;
  10019e:	0412                	slli	s0,s0,0x4
  for (int i = 0; i < 8; i++) {
  1001a0:	f4fd                	bnez	s1,10018e <puthex+0x10>
  }
}
  1001a2:	40b2                	lw	ra,12(sp)
  1001a4:	4422                	lw	s0,8(sp)
  1001a6:	4492                	lw	s1,4(sp)
  1001a8:	4902                	lw	s2,0(sp)
  1001aa:	0141                	addi	sp,sp,16
  1001ac:	8082                	ret
      putchar('A' - 10 + cur_digit);
  1001ae:	03750513          	addi	a0,a0,55
  1001b2:	b7e5                	j	10019a <puthex+0x1c>

001001b4 <simple_exc_handler>:
  } else {
    asm volatile("csrc mstatus, %0\n" : : "r"(1 << 3));
  }
}

void simple_exc_handler(void) {
  1001b4:	1141                	addi	sp,sp,-16
  puts("EXCEPTION!!!\n");
  1001b6:	00000517          	auipc	a0,0x0
  1001ba:	04e50513          	addi	a0,a0,78 # 100204 <simple_exc_handler+0x50>
void simple_exc_handler(void) {
  1001be:	c606                	sw	ra,12(sp)
  puts("EXCEPTION!!!\n");
  1001c0:	374d                	jal	100162 <puts>
  puts("============\n");
  1001c2:	00000517          	auipc	a0,0x0
  1001c6:	05250513          	addi	a0,a0,82 # 100214 <simple_exc_handler+0x60>
  1001ca:	3f61                	jal	100162 <puts>
  puts("MEPC:   0x");
  1001cc:	00000517          	auipc	a0,0x0
  1001d0:	05850513          	addi	a0,a0,88 # 100224 <simple_exc_handler+0x70>
  1001d4:	3779                	jal	100162 <puts>
  __asm__ volatile("csrr %0, mepc;" : "=r"(result));
  1001d6:	34102573          	csrr	a0,mepc
  puthex(get_mepc());
  1001da:	3755                	jal	10017e <puthex>
  puts("\nMCAUSE: 0x");
  1001dc:	00000517          	auipc	a0,0x0
  1001e0:	05450513          	addi	a0,a0,84 # 100230 <simple_exc_handler+0x7c>
  1001e4:	3fbd                	jal	100162 <puts>
  __asm__ volatile("csrr %0, mcause;" : "=r"(result));
  1001e6:	34202573          	csrr	a0,mcause
  puthex(get_mcause());
  1001ea:	3f51                	jal	10017e <puthex>
  puts("\nMTVAL:  0x");
  1001ec:	00000517          	auipc	a0,0x0
  1001f0:	05050513          	addi	a0,a0,80 # 10023c <simple_exc_handler+0x88>
  1001f4:	37bd                	jal	100162 <puts>
  __asm__ volatile("csrr %0, mtval;" : "=r"(result));
  1001f6:	34302573          	csrr	a0,mtval
  puthex(get_mtval());
  1001fa:	3751                	jal	10017e <puthex>
  putchar('\n');
  1001fc:	4529                	li	a0,10
  1001fe:	3f2d                	jal	100138 <putchar>

  while (1)
  100200:	a001                	j	100200 <simple_exc_handler+0x4c>
  100202:	0000                	unimp
