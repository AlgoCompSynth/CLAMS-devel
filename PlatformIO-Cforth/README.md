# Building `cforth` with PlatformIO

1. Run './1_setup.sh`. This will

    a. Install `python3-pip` and `python3-venv` if necessary.

    b. Remove the PlatformIO cache `$HOME/.platformio`.

    c. Create and activate a fresh virtual environment `$HOME/platformio_venv`.

    d. Install PlatformIO core in the environment with `pip`.

    e. List the supported boards to `board_list.txt`. Note that RP2040 / RP2350 boards
supported by the platform <https://github.com/maxgerhardt/platform-raspberrypi.git>
are ***not*** included!

    f. Make a fresh clone of <https://github.com/MitchBradley/cforth.git> to
`$HOME/Projects/cforth`.

    g. Append `testing_platformio.ini` to `$HOME/Projects/cforth/platformio.ini`.

    h. Build the host `cforth`. This creates dictionary data for the embedded Forth.

    i. Deactivate the virtual environment.

3.  Connect your board and put it in `BOOTSEL` mode. You should only
    have one board connected at a time.

    I have had intermittent issues with boards when connected by a USB
    hub or one of those USB-A to micro or USB-C adapters. If you have
    problems, connect with a known good USB cable directly to the host
    computer.

4.  Run the test with the script `./test_board.sh`. The parameters are

    a.  `PIO_ENVIRONMENT`: The environment from `platformio.ini` to
        use. The default is a Raspberry Pi Pico, `rpipico`.

    b.  `BOARD_TAG`: An optional board tag. The default is the empty
        string. The test script uses the name
        `${PIO_ENVIRONMENT}${BOARD_TAG}` for the `.log` and `.elf`
        files.

    For example, when I first tested the [Pimoroni Pico Plus
    2](https://shop.pimoroni.com/products/pimoroni-pico-plus-2?variant=42092668289107),
    which wasn't in the Arduino framework board list at the time, I used the
    command:

    ```
    ./test_board.sh generic_rp2350 "-pimoroni_pico_plus_2"
    ```

    which generated

    ```
    generic_rp2350-pimoroni_pico_plus_2.elf
    generic_rp2350-pimoroni_pico_plus_2.log
    ```

## What the `test_board.sh` script does

Aside from logging information possibly useful in troubleshooting, the
script does a `pio run` with the specified environment to build and
upload the `cforth` firmware to the board. It then fetches the firmware
`.elf` file from the build environment.

Finally, it lists the active "/dev/ttyACM*" and "/dev/ttyUSB*" TTYs.
This is almost always just `/dev/ttyACM0`, unless you have more than
one board connected or a board with both a USB serial port and a
UART-to-USB bridge port.

If all went well you can do `screen /dev/ttyACM0 115200`, do an
`Enter`, and receive the `cforth` `ok` prompt. I have not tested
`cforth` itself extensively yet, but `2 3 + . Enter` behaves as expected.
