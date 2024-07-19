A python scripts can identifying unhealthy disks, retrieving their serial numbers, and lighting up the LEDs for those disks for truenas scale.
```
#!/usr/bin/python3
import subprocess
import re

def run_command(command):
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True, text=True)
    if result.returncode != 0:
        print(f"Error running command: {command}\nError message: {result.stderr}")
    return result.stdout

def get_unhealthy_disks():
    zpool_status_output = run_command('zpool status -P')
    unhealthy_disks = re.findall(r'(/dev/disk/by-partuuid/[a-zA-Z0-9-]+)\s+DEGRADED', zpool_status_output)
    return unhealthy_disks

def get_disk_info_from_smartctl(disk):
    smartctl_output = run_command(f'smartctl -i {disk}')
    serial_number_match = re.search(r'Serial Number:\s+(\S+)', smartctl_output)
    model_number_match = re.search(r'Device Model:\s+(.+)', smartctl_output)

    if serial_number_match and model_number_match:
        return serial_number_match.group(1), model_number_match.group(1)
    return None, None

def get_disk_info_from_storcli():
    storcli_output = run_command('storcli /c0/eALL/sALL show all')
    disks = re.findall(r'/c0/e(\d+)/s(\d+).+?SN = (\S+).+?Model Number = (.+?)(?:\s|$)', storcli_output, re.DOTALL)
    return disks

def light_up_disk(enclosure_id, slot_id):
    command = f'storcli /c0/e{enclosure_id}/s{slot_id} start locate'
    run_command(command)
    print(f"Started locate LED for enclosure {enclosure_id}, slot {slot_id}")

def light_off_disk(enclosure_id, slot_id):
    command = f'storcli /c0/e{enclosure_id}/s{slot_id} stop locate'
    run_command(command)
    print(f"Stopped locate LED for enclosure {enclosure_id}, slot {slot_id}")

def main():
    unhealthy_disks = get_unhealthy_disks()
    unhealthy_serial_model_pairs = set()

    for disk in unhealthy_disks:
        serial_number, model_number = get_disk_info_from_smartctl(disk)
        if serial_number and model_number:
            unhealthy_serial_model_pairs.add((serial_number, model_number))

    disks_info = get_disk_info_from_storcli()

    for enclosure_id, slot_id, serial_number, model_number in disks_info:
        if (serial_number, model_number) in unhealthy_serial_model_pairs:
            light_up_disk(enclosure_id, slot_id)
        else:
            light_off_disk(enclosure_id, slot_id)

if __name__ == "__main__":
    main()
```
