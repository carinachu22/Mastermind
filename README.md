# 1D Project Part 2 - ALU Checkoff

## Members

- [Carina] (https://github.com/carinachu22)  
- [Oishin]  (https://github.com/shinz2307)
- [Dian]  (https://github.com/mavene)
- [Radhi]    (https://github.com/rpriyaj)
- [Hui Yi]  (https://github.com/huiyi17)
- [Michelle]  (https://github.com/michelleordelia)

## Overview of Arithmetic Logic Unit (ALU)
The ALU is a combinational logic device that holds several logic computations namely, addition/subtraction, comparison, boolean, shifter and multiplier. 

For this 1D Project, the ALU takes in 16 bit inputs, A & B, 6 bits ALUFN signals to control the ALU operations and expected to have an output of 16 bits + z,v,n (z = sum equals 0, v = overflow, n = negative) signals of 3 bits. 

## ALUFN Operations

| OPERATION     | OPCODE |
| -----------   | ----------- |
| ADD<br>SUB      | 000000<br>000001        |
| MULT     | 000000           |
| AND<br>OR<br>XOR<br>"A"     |  011000<br>011110<br>010110<br>011010|
| SHL<br>SHR<br>SRA<br>       | 100000<br>100001<br>100011    |
| CMPEQ<br>CMPLT<br>CMPLE   | 110011<br>110101<br>110111 |

# Manual Testing
## How to Use Manual Testing <br>
1. When the FPGA is restarted, the top button ( io_button[0] ) to set the FPGA to manual mode. The seven-segment screen should show ‘000H’ for manual mode. Press the middle button (io_button[1] ) to set the FPGA mode.

2. When the seven-segment screen shows ‘0001’, use io_dip[1:0] to set the 16-bit binary number A. If the dip switch is turned on, the bit would be 1 and vice versa. Press the middle button to set the binary value for A.
3. The screen would show ‘0002’ to set the value for B. Repeat step 2 to set the binary value for B. 
4. The screen would show ‘0003’ to set the ALU signal. Press the middle button to set the ALU signal.
5. The LED lights ( io_led[1:0] ) will show the output value calculated from the ALU.
6. Press the middle button to return to WAIT A state. Repeat steps 2 to 4 for other test cases.
<br><br>

## Manual FSM States

| state    | input      |  output     |
| -----------   | ----------- | ----------- |
| IDLE<br>Wait for user input to start manual test  | io_button[1] = next state | 7-segment display 'M' |
| WAIT A<br>Wait for user input A  | io_dip[1] = [15:8] ALU input<br>io_dip[0] = [7:0] ALU input<br>io_button[1] = next state | io_led[1] = io_dip[1]<br>io_led[0] = io_dip[0] |
| WAIT B<br>Wait for user input B | io_dip[1] = [15:8] ALU input<br>io_dip[0] = [7:0] ALU input<br>io_button[1] = next state | io_led[1] = io_dip[1]<br>io_led[0] = io_dip[0] |
| WAIT OP<br>Wait for user input OPCODE | io_dip[0] = [5:0] OPCODE<br>io_button[1] = next state | io_led[0] = io_dip[0] |
| CHECK ALU | io_button[1] = next state / reset | io_led[2][2:0] = ALU zvn<br>io_led[1] = [15:8] ALU out<br>io_led[0] = [7:0] ALU out |



<br>

# Auto Testing
## How to Use Auto Testing <br>
1. When the FPGA is restarted, the top button ( io_button[0] ) is set to Auto Testing mode, the seven-segment screen should show ‘000A’ for auto mode. Press the middle button ( io_button[1] ) to run the test.
2. The seven-segment screen will automatically display ‘0001’. If the test case passes, it shows ‘PASS’ on the screen, otherwise it will show ‘OFOO’ for overflow, or ‘EEEE’ for error.
3. When the screen displays the test case number, the inputs for each test case are shown on the middle and right LED ( io_led[1:0] ). 
4. When the screen displays the ‘PASS’, ‘OFOO’, or ‘EEEE’, the output is shown on the middle and right LED ( io_led[1:0] ), the left LED shows the zvn value of the particular test case.
5. The system repeats and runs all the test cases.
6. When it is finished, the seven-segment screen displays ‘FISH’.
7. To reset, press the reset button.
<br>

## How to Introduce Forced Error (External Modification)
1. Forced error made by manipulating the dip switch ( io_dip[2] ).
2. Turn on any of the dip switches in io_dip[2]. When the dip switch is turned on, the corresponding 8 least significant bit of the calculated ALU output will be flipped.
(e.g. If io_dip[2][0] is turned on and the ALU output is h0000, the forced error will cause the output to be read as h0001.)
3. The seven-segment screen will display ‘EEEE’ for error, showing that the output is different when compared to the pre-computed output in rom_answers.address.
<br><br>

## Auto FSM States

| state    | input      |  output     |
| -----------   | ----------- | ----------- |
| IDLE<br>Wait for user input to start auto test  | io_button[1] = next state | 7-segment display ‘OOOA’ |
| TESTING<br>Run through all cases in ROM  | rom_answers.address<br>io_dip[2]| io_led[1] = alu16.out[15:8]<br>io_led[0] = alu16.out[7:0]<br>io_led[2][2:0] = alu16.zvn[3] |
| PASS<br>Indicate test case passed  | slow_edge.out = back to TESTING | 7-segment display ‘PASS’ |
| DEBUG<br>Indicate unexpected errors  | None | 7-segment display ‘4444’ |
| OVERFLOW<br>Indicate overflow | slow_edge.out = back to TESTING | 7-segment display ‘OFOO’ |
| ERROR<br>Indicate error (triggered by external modificatio)  | slow_edge.out = back to TESTING | 7-segment display ‘EEEE’ |
| FINISH<br>Complete all test cases successfully  | io_button[1] = next state | 7-segment display ‘FISH’<br>io_led[1:0] = b0<br>io_led[3][2:0] = b0|


# Reference Materials
## Github How-To

### Collaborating

First, clone the repository using `git clone`   
```
git clone git clone https://github.com/50002-computation-structures/1d-project-group_15.git  
```

## Making New changes

Before you work on a new feature, you need to do 2 things.   
Step 1: Get updated master branch with the following commands. 

```
#Get updated master branch
git checkout master
git pull origin master
```

Step 2: Create a new branch with this format `<name>-<featurename>` with the following commands
```
#Create new branch
git checkout -b <name>-<feature-name>

#Example:
git checkout -b carina-readme

```

Now, you can make your edits.

To view changes in unstaged file, use `git diff`

## Update changes to Github

Step 1: Save your file on your local computer

Step 2: Stage your changes with `git add .`

Step 3: Commit your changes with a message

```
git commit -m "Insert your commit message"

#Example:
git commit -m "Changed the readme file"

```

Step 4: Push to your branch using `git push` command:

```
git push origin <name>-<feature-name>

#Example:
git push origin carina-readme

```

Step 5: Submit a Pull Request to the `master` branch using the GitHub website `Repo master page -> Pull Request -> New pull request`

## Seeing new changes

After your pull request is successfully merged above, update your master branch with

```
git checkout master
git pull origin master

```
