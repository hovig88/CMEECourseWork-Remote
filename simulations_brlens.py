# INDEPENDENT CHARACTERS
nsim = 1000

# NEXUS file generator
line1 = "#NEXUS\n\n"
line2 = "LOG start file=simulations.log;\n\n"
line3 = "BEGIN PAUP;\n"
line4 = "\tset nowarnreset autoclose;\n"
line5 = "\texe ind_0.nex;\n"
line6 = "\tgettrees /file=lewis.tre;\n"
line7 = "\tset criterion=likelihood;\n"
line8 = "\tlscore;\n"
line9 = "\tsavetrees /file=ind_0.tre brlens=yes;\n"
line10 = "END;\n\n"

f = open("simulations_ind.nex", "w+")
f.writelines([line1, line2, line3, line4, line5, 
              line6, line7, line8, line9, line10])

for sim in range(1, nsim):
    f.write("BEGIN PAUP;\n")
    f.write("\texe ind_%d.nex;\n" %sim)
    f.write("\tgettrees /file=lewis.tre;\n")
    f.write("\tset criterion=likelihood;\n")
    f.write("\tlscore;\n")
    f.write("\tsavetrees /file=ind_%d.tre brlens=yes;\n\n" %sim)
    f.write("END;\n\n")\
    
f.write("log stop;")

f.close()

# DEPENDENT CHARACTERS
nsim = 1000

# NEXUS file generator
line1 = "#NEXUS\n\n"
line2 = "LOG start file=simulations_dep.log;\n\n"
line3 = "BEGIN PAUP;\n"
line4 = "\tset nowarnreset autoclose;\n"
line5 = "\texe dep_0.nex;\n"
line6 = "\tgettrees /file=lewis.tre;\n"
line7 = "\tset criterion=likelihood;\n"
line8 = "\tlscore;\n"
line9 = "\tsavetrees /file=dep_0.tre brlens=yes;\n"
line10 = "END;\n\n"

f = open("simulations_dep.nex", "w+")
f.writelines([line1, line2, line3, line4, line5, 
              line6, line7, line8, line9, line10])

for sim in range(1, nsim):
    f.write("BEGIN PAUP;\n")
    f.write("\texe dep_%d.nex;\n" %sim)
    f.write("\tgettrees /file=lewis.tre;\n")  
    f.write("\tset criterion=likelihood;\n")
    f.write("\tlscore;\n")
    f.write("\tsavetrees /file=dep_%d.tre brlens=yes;\n\n" %sim)
    f.write("END;\n\n")\
    
f.write("log stop;")

f.close()
