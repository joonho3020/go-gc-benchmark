#!/usr/bin/env python3

import os
import json
import argparse
import sys
import pandas as pd

def bash(cmd):
    fail = os.system(cmd)
    if fail:
        print(f'[*] failed to execute {cmd}')
        sys.exit(1)

def convert_to_ns(unit: str):
  if 'ms' in unit:
    return 1000.0 * 1000.0
  elif 'ns' in unit:
    return 1.0
  else: # micr sec
    return 1000.0

def parse_output_file(file_name: str):
  p50 = 0.0
  p90 = 0.0
  p99 = 0.0
  with open(file_name, 'r') as f:
    lines = f.readlines()
    for line in lines:
      words = line.split()
      if len(words) >=2 and '50' in words[0]:
        p50 = float(words[1][:-2]) * convert_to_ns(words[1][-2:])
      elif len(words) >= 2 and '90' in words[0]:
        p90 = float(words[1][:-2]) * convert_to_ns(words[1][-2:])
      elif len(words) >= 2 and '99' in words[0]:
        p99 = float(words[1][:-2]) * convert_to_ns(words[1][-2:])
  return (p50, p90, p99)

def run(go_max_procs: int, cores_to_pin: list[int]):
  cores_to_pin_str = [str(x) for x in cores_to_pin]
  task_cores = ','.join(cores_to_pin_str)
  cmd = f'GOMAXPROCS={go_max_procs} taskset -c {task_cores} ./main > OUT'
  bash(cmd)
  return parse_output_file('OUT')

def run_all_configs():
  all_go_max_procs = [1, 2, 4, 8, 16]
  all_thread_cnts = [1, 2, 4, 8, 16]

  p99_stats = []
  for go_max_procs in all_go_max_procs:
    p99_stats_per_thread_cnt = []
    for thread_cnt in all_thread_cnts:
      cores_to_pin = [x for x in range(thread_cnt)]
      (p50, p90, p99) = run(go_max_procs, cores_to_pin)
      p99_stats_per_thread_cnt.append(p99)
      print(p99)
    p99_stats.append(p99_stats_per_thread_cnt)

  df = pd.DataFrame(p99_stats, columns = [f'cpu {x}' for x in all_thread_cnts], index = [f'go_max {x}' for x in all_go_max_procs])
  df.to_csv('out.csv')

def main():
  run_all_configs()

if __name__ == "__main__":
  main()
