#!/usr/bin/env python
# coding: utf-8

import argparse
import os
import re
from collections import defaultdict
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser(description='Script that generates epidemic plots and csv reports.')

parser.add_argument('-l', '--log_file', type=str, required=True, help='Input log file')
parser.add_argument('-d', '--dim', type=str, default="200,200", help='Dimensions of the cell grid (WIDTH,HEIGHT)')
parser.add_argument('-i', '--initial_val', default=0, help='Force initial val for the cells')
parser.add_argument('-c', '--state_changes', action="store_true", help='Log state changes to csv file')
parser.add_argument('-f', '--img_format', default="pdf", help='Image format used to export the images')

args = parser.parse_args()

log_filename = args.log_file
dim = list(map(int, args.dim.split(",")))
initial_val = args.initial_val
#log_filename = "covid_store.log"
#dim = 64, 100
#initial_val = None
log_state_changes_to_file = args.state_changes

patt_out_line = ".*Y / (?P<time>[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{3})(?::0)? / [a-zA-Z0-9]+\((?P<x>[0-9]+),(?P<y>[0-9]+)\)\([0-9]+\) / out / +(?P<state>[0-9.-]+) (?:/|para) [a-zA-Z0-9]+\([0-9]+\)"

ID_SUSCEPTIBLE = 0
ID_INFECTED = 1
ID_SICK = 8
ID_RECOVERED = 16
ID_DEAD = -1
ID_WALL = -10

COLOR_SUSCEPTIBLE = "#3498db"
COLOR_INFECTED = "#e74c3c"
COLOR_SICK = "#f1c40f"
COLOR_RECOVERED = "#2ecc71"
COLOR_DEAD = "#9b59b6"


def time_str_to_ts(time_str):
  patt_time = "([0-9]{2}):([0-9]{2}):([0-9]{2}):([0-9]{3})"
  match = re.match(patt_time, time_str)
  if not match:
    raise RuntimeError("Error converting simulation time")
  tu = list(map(int, match.groups()))
  return tu[3] + tu[2]*1000 + tu[1]*60000 + tu[0]*3600000


def dict_to_states_row(states_dict):
  row = []
  row.append(states_dict[ID_SUSCEPTIBLE] if ID_SUSCEPTIBLE in states_dict else 0)
    
  infected_count = 0
  for state in range(ID_INFECTED, ID_SICK):
    if state in states_dict:
      infected_count += states_dict[state]
  row.append(infected_count)

  sick_count = 0
  for state in range(ID_SICK, ID_RECOVERED):
    if state in states_dict:
      sick_count += states_dict[state]
  row.append(sick_count)
    
  for state in [ID_RECOVERED, ID_DEAD, ID_WALL]:
    row.append(states_dict[state] if state in states_dict else 0)
  return row


state_count = defaultdict(int)
df_rows = []
curr_states = [[initial_val] * dim[1] for _ in range(dim[0])]
if initial_val is not None:
    state_count[initial_val] = dim[0]*dim[1]

if log_state_changes_to_file:
  csv_file = open("state_changing.csv", "w")
  csv_file.write(",".join(("time", "x", "y", "previous_state", "current_state")) + "\n")
curr_time = None

with open(log_filename, "r") as log_file:
  for line in log_file:
    line = line.strip()
    match = re.match(patt_out_line, line)
    if not match:
      if line.startswith("Mensaje Y"):
        print(line)
      continue
    if curr_time is None:
      curr_time = match.group("time")
    elif curr_time != match.group("time"):
      #print("Changed to " + match.group("time"))

      row = [time_str_to_ts(curr_time)] + dict_to_states_row(dict(state_count.items()))
      df_rows.append(row)

      curr_time = match.group("time")

    x = int(match.group("x"))
    y = int(match.group("y"))
    
    if not curr_states[x][y] is None:
      state_count[curr_states[x][y]] -= 1

    if log_state_changes_to_file:
      csv_file.write((",".join((match.group("time"), match.group("x"), match.group("y"), str(curr_states[x][y]), str(int(float(match.group("state"))))))))
      csv_file.write("\n")
    #print("Time: %s, cell (%s, %s) changing from %d to %s" % (match.group("time"), match.group("x"), match.group("y"), curr_states[x][y], match.group("state")))
    curr_states[x][y] = int(float(match.group("state")))
    state_count[int(float(match.group("state")))] += 1

if log_state_changes_to_file:
  csv_file.close()


# ## Dataframe creation and visualization
columns = ["time", "susceptible", "infected", "sick", "recovered", "dead", "walls"]
df = pd.DataFrame(df_rows, columns=columns)
df = df.set_index("time")

total_cells = sum(df.iloc[0,:])
population = total_cells - df.iloc[0,:]["walls"]
print("Total cells: %d, population: %d" % (total_cells, population)) 

df_vis = df.copy()
df_vis = df_vis.drop(["walls"], axis=1)
df_vis = df_vis.divide(population)
df_vis.index = df_vis.index.map(lambda x: x/1000)

base_name = os.path.splitext(os.path.basename(log_filename))[0]

col_names = ["infected", "sick", "recovered", "dead"]
colors=[COLOR_INFECTED, COLOR_SICK, COLOR_RECOVERED, COLOR_DEAD]

x = list(df_vis.index)
y = np.vstack([df_vis[col] for col in col_names])

fig, ax = plt.subplots(figsize=(12,7))
ax.stackplot(x, y, labels=col_names, colors=colors)
plt.legend(loc='upper right')
plt.margins(0,0)
plt.title('Epidemic percentages (%s)' % base_name)
#plt.show()
plt.xlabel("Time (s)")
plt.ylabel("Population (%)")
plt.savefig(base_name + "_area" + args.img_format)


fig, ax = plt.subplots(figsize=(12,7))
linewidth = 2

x = list(df_vis.index)
ax.plot(x, df_vis["susceptible"], label="susceptible", color=COLOR_SUSCEPTIBLE, linewidth=linewidth)
ax.plot(x, df_vis["infected"], label="infected", color=COLOR_INFECTED, linewidth=linewidth)
ax.plot(x, df_vis["sick"], label="sick", color=COLOR_SICK, linewidth=linewidth)
ax.plot(x, df_vis["recovered"], label="recovered", color=COLOR_RECOVERED, linewidth=linewidth)
ax.plot(x, df_vis["dead"], label="dead", color=COLOR_DEAD, linewidth=linewidth)
plt.legend(loc='upper right')
plt.margins(0,0)
plt.title('Epidemic percentages (%s)' % base_name)
plt.xlabel("Time (s)")
plt.ylabel("Population (%)")
plt.savefig(base_name + "_lines" + args.img_format)


df_nums = df.drop("walls", axis=1)
df_nums.to_csv(base_name + ".csv")


fig, ax = plt.subplots(figsize=(12,7))
linewidth = 2

x = list(df_vis.index)
ax.plot(x, df_vis["infected"], label="infected", color=COLOR_INFECTED, linewidth=linewidth)
ax.plot(x, df_vis["sick"], label="sick", color=COLOR_SICK, linewidth=linewidth)
ax.plot(x, df_vis["recovered"], label="recovered", color=COLOR_RECOVERED, linewidth=linewidth)
ax.plot(x, df_vis["dead"], label="dead", color=COLOR_DEAD, linewidth=linewidth)
plt.legend(loc='upper right')
plt.margins(0,0)
plt.title('Epidemic percentages (%s)' % base_name)
plt.xlabel("Time (s)")
plt.ylabel("Population (%)")
plt.savefig(base_name + "_lines_nosus" + args.img_format)
