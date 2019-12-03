import subprocess

p = subprocess.Popen(["Rscript --verbose fmr.R > ../results/fmr.Rout 2> ../results/fmr_errFile.Rout"], stdout = subprocess.PIPE, stderr = subprocess.PIPE, shell=True)
stdout, stderr = p.communicate()

if stderr == b'':
    print("R script ran successfully!")
