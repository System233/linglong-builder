	.file	"ptrace.c"
	.text
	.comm	rcwd,4,4
	.comm	cwd,4096,32
	.globl	cwdLen
	.bss
	.align 4
	.type	cwdLen, @object
	.size	cwdLen, 4
cwdLen:
	.zero	4
	.globl	cwdFd
	.align 4
	.type	cwdFd, @object
	.size	cwdFd, 4
cwdFd:
	.zero	4
	.section	.rodata
.LC0:
	.string	"stat: %s"
.LC1:
	.string	"open: %s"
.LC2:
	.string	"sendfile: ofd=%d, ifd=%d"
	.text
	.type	copy, @function
copy:
.LFB6:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$120, %esp
	movl	$-1, -12(%ebp)
	movl	$0, -20(%ebp)
	movl	$0, -16(%ebp)
	subl	$8, %esp
	leal	-108(%ebp), %eax
	pushl	%eax
	pushl	8(%ebp)
	call	stat
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	.L2
	call	__errno_location
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strerror
	addl	$16, %esp
	pushl	%eax
	pushl	8(%ebp)
	pushl	$.LC0
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	-12(%ebp), %eax
	jmp	.L9
.L2:
	subl	$8, %esp
	pushl	$0
	pushl	8(%ebp)
	call	open
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	cmpl	$-1, -20(%ebp)
	jne	.L4
	call	__errno_location
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strerror
	addl	$16, %esp
	pushl	%eax
	pushl	8(%ebp)
	pushl	$.LC1
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	$-1, -12(%ebp)
	jmp	.L5
.L4:
	movl	-92(%ebp), %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$577
	pushl	12(%ebp)
	call	open
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	cmpl	$-1, -16(%ebp)
	jne	.L6
	call	__errno_location
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strerror
	addl	$16, %esp
	pushl	%eax
	pushl	12(%ebp)
	pushl	$.LC1
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	$-1, -12(%ebp)
	jmp	.L5
.L6:
	movl	-64(%ebp), %eax
	pushl	%eax
	pushl	$0
	pushl	-20(%ebp)
	pushl	-16(%ebp)
	call	sendfile
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$-1, -12(%ebp)
	jne	.L10
	call	__errno_location
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strerror
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	pushl	-20(%ebp)
	pushl	-16(%ebp)
	pushl	$.LC2
	pushl	$3
	call	syslog
	addl	$32, %esp
	jmp	.L5
.L10:
	nop
.L5:
	cmpl	$-1, -20(%ebp)
	je	.L7
	subl	$12, %esp
	pushl	-20(%ebp)
	call	close
	addl	$16, %esp
.L7:
	cmpl	$-1, -16(%ebp)
	je	.L8
	subl	$12, %esp
	pushl	-16(%ebp)
	call	close
	addl	$16, %esp
.L8:
	movl	-12(%ebp), %eax
.L9:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	copy, .-copy
	.section	.rodata
.LC3:
	.string	"%s/%s"
.LC4:
	.string	"mkdir: %s"
.LC5:
	.string	"copy: %s -> %s"
	.text
	.type	redirect, @function
redirect:
.LFB7:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	rcwd, %eax
	subl	$12, %esp
	pushl	12(%ebp)
	pushl	%eax
	pushl	$.LC3
	pushl	$4096
	pushl	$path.3926
	call	snprintf
	addl	$32, %esp
	movl	$0, -12(%ebp)
	jmp	.L12
.L15:
	movl	-12(%ebp), %eax
	addl	$path.3926, %eax
	movzbl	(%eax), %eax
	cmpb	$47, %al
	jne	.L13
	cmpl	$0, -12(%ebp)
	je	.L13
	movl	-12(%ebp), %eax
	addl	$path.3926, %eax
	movb	$0, (%eax)
	subl	$4, %esp
	pushl	$path.3926
	pushl	$.LC4
	pushl	$7
	call	syslog
	addl	$16, %esp
	subl	$8, %esp
	pushl	$755
	pushl	$path.3926
	call	mkdir
	addl	$16, %esp
	cmpl	$-1, %eax
	jne	.L14
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$17, %eax
	je	.L14
	call	__errno_location
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strerror
	addl	$16, %esp
	pushl	%eax
	pushl	$path.3926
	pushl	$.LC4
	pushl	$3
	call	syslog
	addl	$16, %esp
.L14:
	movl	-12(%ebp), %eax
	addl	$path.3926, %eax
	movb	$47, (%eax)
.L13:
	addl	$1, -12(%ebp)
.L12:
	movl	-12(%ebp), %eax
	addl	$path.3926, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L15
	subl	$8, %esp
	pushl	$0
	pushl	8(%ebp)
	call	access
	addl	$16, %esp
	cmpl	$-1, %eax
	je	.L17
	subl	$8, %esp
	pushl	$0
	pushl	$path.3926
	call	access
	addl	$16, %esp
	cmpl	$-1, %eax
	jne	.L17
	pushl	$path.3926
	pushl	8(%ebp)
	pushl	$.LC5
	pushl	$7
	call	syslog
	addl	$16, %esp
	subl	$8, %esp
	pushl	$path.3926
	pushl	8(%ebp)
	call	copy
	addl	$16, %esp
	cmpl	$-1, %eax
	jne	.L17
	call	__errno_location
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strerror
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	pushl	$path.3926
	pushl	8(%ebp)
	pushl	$.LC5
	pushl	$3
	call	syslog
	addl	$32, %esp
.L17:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE7:
	.size	redirect, .-redirect
	.globl	pathcmp
	.type	pathcmp, @function
pathcmp:
.LFB8:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	movl	$0, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -8(%ebp)
	jmp	.L19
.L21:
	addl	$1, -4(%ebp)
.L20:
	movl	-4(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$47, %al
	je	.L21
	jmp	.L22
.L23:
	addl	$1, -8(%ebp)
.L22:
	movl	-8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$47, %al
	je	.L23
	movl	-4(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -4(%ebp)
	movzbl	(%eax), %ecx
	movl	-8(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -8(%ebp)
	movzbl	(%eax), %eax
	cmpb	%al, %cl
	je	.L19
	movl	$0, %eax
	jmp	.L24
.L19:
	movl	-4(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	je	.L25
	movl	-8(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L20
.L25:
	movl	-4(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L27
	jmp	.L28
.L29:
	addl	$1, -8(%ebp)
.L28:
	movl	-8(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$47, %al
	je	.L29
	movl	-8(%ebp), %eax
	jmp	.L24
.L27:
	movl	$0, %eax
.L24:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE8:
	.size	pathcmp, .-pathcmp
	.section	.rodata
.LC6:
	.string	"openat: AT_FDCWD %s"
.LC7:
	.string	"redirect: %s -> %s/%s"
	.text
	.globl	trace_openat_path
	.type	trace_openat_path, @function
trace_openat_path:
.LFB9:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8312, %esp
	subl	$4, %esp
	pushl	$0
	leal	-40(%ebp), %eax
	pushl	%eax
	pushl	8(%ebp)
	call	waitpid
	addl	$16, %esp
	jmp	.L31
.L40:
	leal	-108(%ebp), %eax
	pushl	%eax
	pushl	$0
	pushl	8(%ebp)
	pushl	$12
	call	ptrace
	addl	$16, %esp
	movl	-64(%ebp), %eax
	cmpl	$295, %eax
	jne	.L32
	movl	-108(%ebp), %eax
	cmpl	$-100, %eax
	jne	.L32
	movl	-104(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	$0, -12(%ebp)
	movl	$1, -16(%ebp)
	jmp	.L33
.L38:
	leal	-4204(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -28(%ebp)
	movl	-24(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%eax, %edx
	leal	-4204(%ebp), %eax
	pushl	%eax
	pushl	%edx
	pushl	8(%ebp)
	pushl	$2
	call	ptrace
	addl	$16, %esp
	movl	%eax, -32(%ebp)
	movl	-28(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%edx, (%eax)
	movl	$0, -20(%ebp)
	jmp	.L34
.L37:
	movl	-12(%ebp), %edx
	movl	-20(%ebp), %eax
	addl	%edx, %eax
	movzbl	-4204(%ebp,%eax), %eax
	testb	%al, %al
	jne	.L35
	movl	$0, -16(%ebp)
	jmp	.L36
.L35:
	addl	$1, -20(%ebp)
.L34:
	movl	-20(%ebp), %eax
	cmpl	$3, %eax
	jbe	.L37
.L36:
	movl	-12(%ebp), %eax
	addl	$4, %eax
	movl	%eax, -12(%ebp)
.L33:
	cmpl	$0, -16(%ebp)
	jne	.L38
	subl	$4, %esp
	leal	-4204(%ebp), %eax
	pushl	%eax
	pushl	$.LC6
	pushl	$7
	call	syslog
	addl	$16, %esp
	movl	$0, -36(%ebp)
	movzbl	-4204(%ebp), %eax
	cmpb	$47, %al
	je	.L39
	movl	cwdFd, %eax
	movl	%eax, -108(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, -104(%ebp)
	subl	$8, %esp
	leal	-4204(%ebp), %eax
	pushl	%eax
	leal	-4204(%ebp), %eax
	pushl	%eax
	call	redirect
	addl	$16, %esp
	movl	rcwd, %eax
	subl	$12, %esp
	leal	-4204(%ebp), %edx
	pushl	%edx
	pushl	%eax
	leal	-4204(%ebp), %eax
	pushl	%eax
	pushl	$.LC7
	pushl	$7
	call	syslog
	addl	$32, %esp
	leal	-108(%ebp), %eax
	pushl	%eax
	pushl	$0
	pushl	8(%ebp)
	pushl	$13
	call	ptrace
	addl	$16, %esp
	jmp	.L32
.L39:
	subl	$8, %esp
	leal	-4204(%ebp), %eax
	pushl	%eax
	pushl	$cwd
	call	pathcmp
	addl	$16, %esp
	movl	%eax, -36(%ebp)
	cmpl	$0, -36(%ebp)
	je	.L32
	movl	cwdFd, %eax
	movl	%eax, -108(%ebp)
	leal	-4204(%ebp), %eax
	movl	-36(%ebp), %edx
	subl	%eax, %edx
	movl	-24(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -104(%ebp)
	subl	$8, %esp
	pushl	-36(%ebp)
	leal	-4204(%ebp), %eax
	pushl	%eax
	call	redirect
	addl	$16, %esp
	movl	rcwd, %eax
	subl	$12, %esp
	pushl	-36(%ebp)
	pushl	%eax
	leal	-4204(%ebp), %eax
	pushl	%eax
	pushl	$.LC7
	pushl	$7
	call	syslog
	addl	$32, %esp
	leal	-108(%ebp), %eax
	pushl	%eax
	pushl	$0
	pushl	8(%ebp)
	pushl	$13
	call	ptrace
	addl	$16, %esp
.L32:
	pushl	$0
	pushl	$0
	pushl	8(%ebp)
	pushl	$24
	call	ptrace
	addl	$16, %esp
	subl	$4, %esp
	pushl	$0
	leal	-40(%ebp), %eax
	pushl	%eax
	pushl	8(%ebp)
	call	waitpid
	addl	$16, %esp
.L31:
	movl	-40(%ebp), %eax
	andl	$127, %eax
	testl	%eax, %eax
	jne	.L40
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE9:
	.size	trace_openat_path, .-trace_openat_path
	.section	.rodata
.LC8:
	.string	"PTRACE_LOG_LEVEL"
.LC9:
	.string	"DEBUG"
.LC10:
	.string	"INFO"
.LC11:
	.string	"WARNING"
.LC12:
	.string	"ERROR"
	.text
	.globl	setuplog
	.type	setuplog, @function
setuplog:
.LFB10:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	subl	$12, %esp
	pushl	$.LC8
	call	getenv
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	movl	$31, -12(%ebp)
	cmpl	$0, -16(%ebp)
	je	.L42
	subl	$8, %esp
	pushl	$.LC9
	pushl	-16(%ebp)
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L43
	movl	$255, -12(%ebp)
	jmp	.L42
.L43:
	subl	$8, %esp
	pushl	$.LC10
	pushl	-16(%ebp)
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L44
	movl	$127, -12(%ebp)
	jmp	.L42
.L44:
	subl	$8, %esp
	pushl	$.LC11
	pushl	-16(%ebp)
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L45
	movl	$31, -12(%ebp)
	jmp	.L42
.L45:
	subl	$8, %esp
	pushl	$.LC12
	pushl	-16(%ebp)
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L42
	movl	$15, -12(%ebp)
.L42:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	setlogmask
	addl	$16, %esp
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE10:
	.size	setuplog, .-setuplog
	.section	.rodata
.LC13:
	.string	"Usage: %s <CWD> <program>\n"
.LC14:
	.string	"cwd: %s"
.LC15:
	.string	"redirect: %s"
.LC16:
	.string	"execv: %s"
	.text
	.globl	main
	.type	main, @function
main:
.LFB11:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	movl	%esp, %ebp
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	subl	$16, %esp
	movl	%ecx, %ebx
	movl	4(%ebx), %eax
	movl	(%eax), %eax
	subl	$4, %esp
	pushl	$8
	pushl	$35
	pushl	%eax
	call	openlog
	addl	$16, %esp
	call	setuplog
	cmpl	$2, (%ebx)
	jg	.L47
	movl	4(%ebx), %eax
	movl	(%eax), %edx
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	$.LC13
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	movl	$1, %eax
	jmp	.L48
.L47:
	subl	$8, %esp
	pushl	$4096
	pushl	$cwd
	call	getcwd
	addl	$16, %esp
	subl	$12, %esp
	pushl	$cwd
	call	strlen
	addl	$16, %esp
	movl	%eax, cwdLen
	movl	4(%ebx), %eax
	movl	4(%eax), %eax
	movl	%eax, rcwd
	movl	rcwd, %eax
	subl	$8, %esp
	pushl	$65536
	pushl	%eax
	call	open
	addl	$16, %esp
	movl	%eax, cwdFd
	movl	cwdFd, %eax
	cmpl	$-1, %eax
	jne	.L49
	call	__errno_location
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strerror
	addl	$16, %esp
	movl	%eax, %edx
	movl	rcwd, %eax
	pushl	%edx
	pushl	%eax
	pushl	$.LC1
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	$1, %eax
	jmp	.L48
.L49:
	subl	$4, %esp
	pushl	$cwd
	pushl	$.LC14
	pushl	$7
	call	syslog
	addl	$16, %esp
	movl	rcwd, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC15
	pushl	$7
	call	syslog
	addl	$16, %esp
	call	fork
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L50
	pushl	$0
	pushl	$0
	pushl	$0
	pushl	$0
	call	ptrace
	addl	$16, %esp
	movl	4(%ebx), %eax
	leal	8(%eax), %edx
	movl	4(%ebx), %eax
	addl	$8, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	execv
	addl	$16, %esp
	call	__errno_location
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	strerror
	addl	$16, %esp
	movl	%eax, %edx
	movl	4(%ebx), %eax
	addl	$8, %eax
	movl	(%eax), %eax
	pushl	%edx
	pushl	%eax
	pushl	$.LC16
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	$1, %eax
	jmp	.L48
.L50:
	subl	$12, %esp
	pushl	-12(%ebp)
	call	trace_openat_path
	addl	$16, %esp
	call	closelog
	movl	$0, %eax
.L48:
	leal	-8(%ebp), %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.local	path.3926
	.comm	path.3926,4096,32
	.ident	"GCC: (Uos 8.3.0.3-3+rebuild) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
