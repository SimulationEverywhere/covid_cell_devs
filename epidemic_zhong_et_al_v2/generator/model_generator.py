
import argparse

parser = argparse.ArgumentParser(description='Auxiliar script to generate Zhong-based CA models')

parser.add_argument('-f', '--infected_steps', type=int, default=6, help='Number of days for the infected state')
parser.add_argument('-r', '--recovered_steps', type=int, default=7, help='Number of days for the recovered state')
parser.add_argument('-t', '--template_ma', type=str, default="template_sirs_zhong_ma", help='Path to zhong .ma template')
parser.add_argument('-m', '--template_macros', type=str, default="template_sirs_zhong_macros", help='Path to zhong macros template')
parser.add_argument('-o', '--out_ma_file', type=str, default="out.ma", help='Output path of the .ma file')
parser.add_argument('-p', '--out_macros_file', type=str, default="sirs_zhong_macros.inc", help='Output path of the macros file')
parser.add_argument('-v', '--virulences', type=str, default="0.6", help='Default virulence values per state')

args = parser.parse_args()

i = 1
states = ["sus_0"]
neighbors = ["(1,0)", "(0,-1)", "(0,1)", "(-1,0)"]
steps_per_state = list(map(str, [args.infected_steps, args.recovered_steps]))

while i <= args.infected_steps:
    states.append("inf_%d" % i)
    i += 1

while i <= args.infected_steps + args.recovered_steps:
    states.append("rec_%d" % i)
    i += 1

##############################
# GENERATION OF THE .MA FILE
##############################
content = ""
with open(args.template_ma, "r") as f:
    content = f.read()

internal_vars = ["i_%s" % s for s in states] + ["v_%d" % n for n in range(1, args.infected_steps + 1)]
content = content.replace("[[internal_vars]]", " ".join(internal_vars))

internal_vars_values = " ".join(steps_per_state + ["1.0"] + ["0.0"] * (len(states) - 1))
if "," in args.virulences:
    virulences = list(args.virulences.split(","))
else:
    virulences = [args.virulences] * args.infected_steps
internal_vars_values += " %s" % " ".join(virulences)
content = content.replace("[[internal_vars_values]]", internal_vars_values)
update_ports_str = " ".join(["~%s := $i_%s;" % (s, s) for s in states])
content = content.replace("[[initial_ports_set_up]]", update_ports_str)
content = content.replace("[[update_ports_step]]", update_ports_str)
content = content.replace("[[ports]]", " ".join(states))

update_rules = ""
idx_first_rec = len(states)-args.recovered_steps
for i in range(len(states)-1, idx_first_rec, -1):
    update_rules += "$i_%s := $i_%s;\n" % (states[i], states[i-1])
update_rules += "$i_%s := $i_%s + #macro(local_cured);\n\n" % (states[idx_first_rec], states[idx_first_rec-1])

for i in range(idx_first_rec-1, 1, -1):
    update_rules += "$i_%s := round(min((1 - $cured_rate) * $i_%s, 1)*100)/100;\n" % (states[i], states[i - 1])
update_rules += "$i_%s := #macro(internal_infected) + #macro(external_infected);\n\n" % states[1]

update_rules += "$i_%s := 1 " % states[0]
update_rules += " ".join(["- $i_%s" % s for s in states[1:]])
update_rules += ";\n"

content = content.replace("[[update_vars_step]]", update_rules)

with open(args.out_ma_file, "w") as f:
    f.write(content)

#################################
# GENERATION OF THE MACROS FILE
#################################

content = ""
with open(args.template_macros, "r") as f:
    content = f.read()

local_cured_rules = []
for i in range(idx_first_rec-2, 0, -1):
    local_cured_rules.append("round(min($cured_rate * $i_%s, 1)*100)" % states[i])

content = content.replace("[[local_cured]]", "(( %s ) / 100 )" % " +\n".join(local_cured_rules))
content = content.replace("[[infected_vars]]", " + ".join(["i_%s" % s for s in states[idx_first_rec:0]]))

external_infected_comp = \
"""( round(min((
$connection * $movement * $i_sus_0 * (
[[external_infected]]
)), 1)*100) / 100 )"""

internal_infected_comp = \
"""( round(min(( 
$i_sus_0 * (
[[internal_infected]]
)), 1)*100) / 100 )"""

external_infected_rules = []
for nei in neighbors:
    lines = []
    for s in states[args.infected_steps:0:-1]:
        v = "$v_%s" % s.split("_")[-1]
        line = "(%s~pop / $population) * %s * %s~%s" % (nei, v, nei, s)
        lines.append(line)

    ext_comp = external_infected_comp.replace("[[external_infected]]", " +\n".join(lines))
    external_infected_rules.append(ext_comp)

content = content.replace("[[external_infected]]", " +\n".join(external_infected_rules))

lines = []
for s in states[args.infected_steps:0:-1]:
    v = "$v_%s" % s.split("_")[-1]
    line = "(%s * $i_%s)" % (v, s)
    lines.append(line)

internal_infected_rule = internal_infected_comp.replace("[[internal_infected]]", " +\n".join(lines))
content = content.replace("[[internal_infected]]", internal_infected_rule)

with open(args.out_macros_file, "w") as f:
    f.write(content)
