
# Taken from https://ubuntuforums.org/showthread.php?t=2117981
import os
import re
import subprocess
import time

if __name__ == '__main__':
    cmd = 'synclient -m 100'

    p = subprocess.Popen(cmd, stdout = subprocess.PIPE, stderr = subprocess.STDOUT, shell = True)
    skip = False
    first = True
    start = False
    start_x = 0
    start_y = 0
    diff_x = 0
    diff_y = 0
    timeStart = 0
    timeEnd = 0
    try:
        while True:
            line = p.stdout.readline().decode('utf-8')
            print(line)
            if not line:
                break
            try:
                tokens = [x for x in re.split(r'([^0-9\.])+', line.strip()) if x.strip()]
                x, y, fingers = int(tokens[1]), int(tokens[2]), int(tokens[4])
                print(x, y, fingers)
                if fingers==3:
                    if not start:
                        start_x = x
                        start_y = y
                        start = True
                        timeStart = time.time()
                if start and not fingers==3:
                    if time.time()-timeStart>1.00:
                        print('too long')
                        start = False
                        start_x = 0
                        start_y = 0
                        diff_y = 0
                        diff_x = 0
                    else:
                        diff_x = x-start_x
                        diff_y = y-start_y
                        #MODIFY THE NUMBERS BELLOW FOR SENSITIVITY
                        if abs(diff_x) > abs(diff_y):
                            # Move in left/right direction
                            if diff_x > 200:
                                    os.system('xdotool key ctrl+alt+Right')
                            elif diff_x < -200:
                                    os.system('xdotool key ctrl+alt+Left')
                        else:
                            # Move in up/down direction
                            if diff_y > 200:
                                    os.system('xdotool key ctrl+alt+Down')
                            elif diff_y < -200:
                                    os.system('xdotool key ctrl+alt+Up')
                        start = False
                        start_x = 0
                        start_y = 0
                        diff_y = 0
                        diff_x = 0
            except (IndexError, ValueError):
                pass
    except KeyboardInterrupt:
        pass
