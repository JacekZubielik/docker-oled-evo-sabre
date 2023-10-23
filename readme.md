[![Docker](https://github.com/JacekZubielik/docker-oled-evo-sabre/actions/workflows/docker-publish-arm.yml/badge.svg)](https://github.com/JacekZubielik/docker-oled-evo-sabre/actions/workflows/docker-publish-arm.yml)

# SSD1322 OLED - Control and configuration for Audiophonics EvoSabre DAC

## Background

This project enables the control of a secondary OLED screen alongside the Audiophonics EvoSabre DAC while utilizing the Logitech Media Server.

In fact, it is compatible with any other Arm64 architecture-based hardware that runs **LMS** and features an OLED screen, whether it is an **SSD1322** on any Linux distribution supporting **Docker**.

I have conducted tests on a 64-bit RPi4 and it should also function on **Odroid** and similar devices, regardless of whether you are using the Audiophonics EvoSabre DAC or a different DAC of your preference.

## Functionality

The script serves the following purposes:

- Displaying information from LMS on the OLED screen.
- Toggling between song titles/track information and artist/album details during playback, with automatic scrolling.
- Employing a combination of subscriptions for monitoring state changes (e.g., power, playback) and using JSONRPC polling during playback, with a separate backup polling mechanism in case subscriptions are not updated.
- Allowing for the configuration of font sizes, text placements, and more via an external file: `/appdata/oled4docker.cfg`.
- Providing potential support for any device compatible with `luma.oled`.
- Automatically adjusting contrast between day and night, as defined in an external file: `/appdata/oled4docker.cfg` (Sunrise and sunset times are retrieved from <a href="https://sunrise-sunset.org/api" target="_blank">Sunset and sunrise times API - Sunrise-Sunset.org</a>.
- Separate settings for energy-saving screen contrast are located in an external file: `/appdata/oled4docker.cfg`.
- Displaying a clock when the player is turned off or stopped.
- Separate screen saver settings are located in an external file: `/appdata/oled4docker.cfg`.


## Installation

To enable SPI support on a Raspberry Pi, you can follow these steps:

1. Add `dtparam=spi=on` to the `/boot/config.txt` file using a text editor. You can use the `nano` text editor for this:

   ```
   sudo nano /boot/config.txt
   ```

   Add the `dtparam=spi=on` line to the file and save it.

2. To increase the SPI buffer size to display a bitmap logo during startup, edit the `/boot/cmdline.txt` file:

   ```
   sudo nano /boot/cmdline.txt
   ```

   Add `spidev.bufsiz=8192` to the end of the line and save it.

3. Check if the SPI port is working by typing:

   ```
   ls -l /dev/spidev*
   ```

   You should see output similar to the following:

   ```
   crw-rw---- 1 root spi 153, 0 Oct 23 11:15 /dev/spidev0.0
   crw-rw---- 1 root spi 153, 1 Oct 23 11:15 /dev/spidev0.1
   ```

Remember that these changes will only take effect after you reboot your Raspberry Pi.

```bash
git clone https://github.com/JacekZubielik/docker-oled-evo-sabre.git
```

```bash
cd docker-oled-evo-sabre
```

```bash
mv .env_exemple .env
```

```bash
docker compose -d up
```

## Configuration

Variables in the `.env` file.

(Remember to rename the `.env_exemple` file to `.env` before the first run).

#### OLED=

This options is required and specifies the OLED device name, as per luma.oled devices.

#### LMSIP=

The script will try to detect the LMS on the network. However, if this doesn't work for some reason, or if you have multiple LMSs, you can override this discovery process by specifying the IP address of your LMS.

#### MAC=

The script will try to detect the MAC address of your Squeezelite (player). If this fails, you can override the MAC address. Also, if you choose to specify the MAC address in Squeezelite settings, you must also then specify the same MAC address here.

#### LOGFILE=

If you specify LOGFILE=Y, the logger output from the script will be written to `/appdata/oled4docker.log`, rather than just to standard out.

#### LOCATION=

If you specify your latitude and longitude, the script will try to discover the sunrise and sunset times, and adjust the screen contrast automatically for day and night. The location must be 2 float numbers, separated by a comma e.g. for London, specify LOCATION=51.507351,-0.127758

You can change the contrast level within the range of 0 to 255 in the `/appdata/oled4docker.cfg` file.

For example:
```
contrast_day=150
contrast_night=10
contrast_screensave=10
```

## Credits

This Docker image has been created to facilitate the operation of an additional OLED screen in conjunction with the Audiophonics EvoSabre DAC, LMS and SqueezeLite installed within a Docker environment. Please note that it is only compatible with 64-bit operating systems.

Additionally, it features a Python3 script authored by Peter Sketch (also known as **peteS-UK**). This script is specifically designed for use with <a href="https://www.picoreplayer.org/" target="_blank">piCorePlayer</a> and is available on <a href="https://github.com/peteS-UK/EvoSabre-DAC-PCP" target="_blank">GitHub - peteS-UK/EvoSabre-DAC-PCP</a>. For more detailed information, kindly refer to the author's page.

## License

In line with the reuse of luma.core, the software is available under MIT license

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


