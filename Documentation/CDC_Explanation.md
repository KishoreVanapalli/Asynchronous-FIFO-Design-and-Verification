# Clock Domain Crossing (CDC)

Clock Domain Crossing occurs when data moves between logic
driven by different clocks.

Problems:
- Metastability
- Data corruption
- Data loss

Solution:
- Gray code pointers
- Two-flop synchronizers
- Separate read and write clocks

The asynchronous FIFO safely transfers data between two
independent clock domains.