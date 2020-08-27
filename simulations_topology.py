# INDEPENDENT CHARACTERS
nsim = 1000

# NEXUS file generator
line1 = "#NEXUS\n\n"
line2 = "LOG start file=simulations.log;\n\n"
line3 = "BEGIN PAUP;\n"
line4 = "\tset nowarnreset autoclose;\n"
line5 = "\texe ind_0.nex;\n"
line6 = "\tset criterion=likelihood;\n"
line7 = "\talltrees;\n"
line8 = "\tcontree /file=ind_0.tre;\n"
line9 = "END;\n\n"

f = open("simulations_ind.nex", "w+")
f.writelines([line1, line2, line3, line4, line5, 
              line6, line7, line8, line9])

for sim in range(1, nsim):
    f.write("BEGIN PAUP;\n")
    f.write("\texe ind_%d.nex;\n" %sim)
    f.write("\tset criterion=likelihood;\n")
    f.write("\talltrees;\n")
    f.write("\tcontree /file=ind_%d.tre;\n\n" %sim)
    f.write("END;\n\n")\
    
f.write("log stop;")

f.close()

# DEPENDENT CHARACTERS
nsim = 1000

# NEXUS file generator
line1 = "#NEXUS\n\n"
line2 = "LOG start file=simulations.log;\n\n"
line3 = "BEGIN PAUP;\n"
line4 = "\tset nowarnreset autoclose;\n"
line5 = "\texe dep_0.nex;\n"
line6 = "\tset criterion=likelihood;\n"
line7 = "\talltrees;\n"
line8 = "\tcontree /file=dep_0.tre;\n"
line9 = "END;\n\n"

f = open("simulations_dep.nex", "w+")
f.writelines([line1, line2, line3, line4, line5, 
              line6, line7, line8, line9])

for sim in range(1, nsim):
    f.write("BEGIN PAUP;\n")
    f.write("\texe dep_%d.nex;\n" %sim)
    f.write("\tset criterion=likelihood;\n")
    f.write("\talltrees;\n")
    f.write("\tcontree /file=dep_%d.tre;\n\n" %sim)
    f.write("END;\n\n")\
    
f.write("log stop;")

f.close()
