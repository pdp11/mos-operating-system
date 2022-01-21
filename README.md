These files, and the information here, were provided by J. Noel Chiappa.
See https://gunkies.org/wiki/MOS_operating_system

---

The **MOS operating system** (formally the *Micro Operating System*,
but informally *Mathis' Operating System*, after the creator, Jim
Mathis of SRI) was a cooperative real-time multi-tasking operating
system, originally for the PDP-11, used for a number of packet
switches and similar network applications.  It was initially written
as part of the Terminal Interface Unit project, the first application
which used it.

It supported processes (but not preemption, or creation/termination of
processes - all processes were created at system linking time), queued
inter-process messages (*signals*), asynchronous I/O, and allocation
and freeing of main memory; it had no file system or other support for
secondary storage.

It appears to have been inspired by the [ELF operating
system](https://github.com/larsbrinkhoff/elf-operating-system) (which
also has *Device Control Tables* and *I/O Request Blocks*, which look
similar in their details to the MOS ones, and uses signals to notify
of asynchronous I/O operation completion), but it is much simpler than
ELF; for instance, all MOS code necessarily shares a single address
space, and MOS processes are static, unlike ELF.

The original version was written in MACRO-11, the assembly language
for the PDP-11; it was later re-written at least three times in C: at
BBN, at UCL, and at Proteon.  The first and last versions were
portable; the latter also ran on the MC68000, the Intel x86, and the
AMD29000.  All were somewhat extended from the original; the first two
fairly extensively, the latter only to make use of up-calls in the I/O
system, and to support pseudo-terminals.