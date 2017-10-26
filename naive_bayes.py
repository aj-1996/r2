
import csv			# imports the csv module
import sys			# imports the sys module
import math

	

def cal_p(sample, mean, variance) :
	exponent = -((sample - mean)**2) / (2*variance)
	term1 = 1.0 / math.sqrt(2* math.pi * variance)
	term2 =	math.exp(exponent)
	return term1 * term2                                 #formulae

	

age_c = age_s = age_r = 0
qual_c = qual_s = qual_r = 0                  #initialization
exp_c = exp_s = exp_r = 0
count_c = count_s = count_r = 0

f = open('data.csv', 'rb') 	# opens the csv file
reader = csv.reader(f)  	# creates the reader object

for row in reader:   		# iterates the rows of the file in orders
	if row[0] == "Consultancy":
		age_c = age_c + int(row[1])
		qual_c = qual_c + int(row[2])
		exp_c = exp_c + int(row[3])
		count_c += 1
	elif row[0] == "Service":
		age_s = age_s + int(row[1])
		qual_s = qual_s + int(row[2])
		exp_s = exp_s + int(row[3])
		count_s += 1
	elif row[0] == "Research":
		age_r = age_r + int(row[1])
		qual_r = qual_r + int(row[2])
		exp_r = exp_r + int(row[3])
		count_r += 1

f.close()      			# closing

total_count = count_c + count_s + count_r
pc = float(count_c) / total_count
ps = float(count_s) / total_count
pr = float(count_r) / total_count          #probability 

mean_age_c = float(age_c/count_c)
mean_age_s = float(age_s/count_s)
mean_age_r = float(age_r/count_r)             #mean

mean_qual_c = float(qual_c/count_c)
mean_qual_s = float(qual_s/count_s)
mean_qual_r = float(qual_r/count_r)

mean_exp_c = float(exp_c/count_c)
mean_exp_s = float(exp_s/count_s)
mean_exp_r = float(exp_r/count_r)


age_var_c = age_var_s = age_var_r = 0.0
qual_var_c = qual_var_s = qual_var_r = 0.0         
exp_var_c = exp_var_s = exp_var_r = 0.0

f = open('data.csv', 'rb') 	# opens the csv file
reader = csv.reader(f)  	# creates the reader object

for row in reader:   		# iterates the rows of the file in orders
	if row[0] == "Consultancy": 
		age_var_c = age_var_c + (mean_age_c - float(row[1]))**2
		qual_var_c = qual_var_c + (mean_qual_c - float(row[2])) **2             #variance
		exp_var_c = exp_var_c + (mean_exp_c - float(row[3]))**2
	elif row[0] == "Service":
		age_var_s = age_var_s + (mean_age_s - float(row[1]))**2
		qual_var_s = qual_var_s + (mean_qual_s - float(row[2]))**2
		exp_var_s = exp_var_s + (mean_exp_s - float(row[3]))**2
	elif row[0] == "Research":
		age_var_r = age_var_r + (mean_age_r - float(row[1]))**2
		qual_var_r = qual_var_r + (mean_qual_r - float(row[2]))**2
		exp_var_r = exp_var_r + (mean_exp_r - float(row[3]))**2

f.close()      		# closing

age_var_c = age_var_c / (count_c - 1)
age_var_s = age_var_s / (count_s - 1)
age_var_r = age_var_r / (count_r - 1)

qual_var_c = qual_var_c / (count_c - 1)
qual_var_s = qual_var_s / (count_s - 1)
qual_var_r = qual_var_r / (count_r - 1)          #prior probability

exp_var_c = exp_var_c / (count_c - 1)
exp_var_s = exp_var_s / (count_s - 1)
exp_var_r = exp_var_r / (count_r - 1)

while True:

	print
	print "Enter sample attributes:\n"
	sample_age = int(raw_input("Enter age: ")) 
	sample_qual = int(raw_input("Enter qualification: "))           #accepting from user
	sample_exp = int(raw_input("Enter experience: "))           

	if sample_age - sample_exp >= 15:
		break
	else:
		print "Invalid combination of age and experience."
		continue

	############################################

p_age_c = cal_p(sample_age, mean_age_c, age_var_c)
p_qual_c = cal_p(sample_qual, mean_qual_c, qual_var_c)
p_exp_c = cal_p(sample_exp, mean_exp_c, exp_var_c)

posterior_c = pc * p_age_c * p_qual_c * p_exp_c

	#############################################

p_age_s = cal_p(sample_age, mean_age_s, age_var_s)
p_qual_s = cal_p(sample_qual, mean_qual_s, qual_var_s)
p_exp_s = cal_p(sample_exp, mean_exp_s, exp_var_s)

posterior_s = ps * p_age_s * p_qual_s * p_exp_s

	#############################################

p_age_r = cal_p(sample_age, mean_age_r, age_var_r)
p_qual_r = cal_p(sample_qual, mean_qual_r, qual_var_r)
p_exp_r = cal_p(sample_exp, mean_exp_r, exp_var_r)

posterior_r = pr * p_age_r * p_qual_r * p_exp_r

	#############################################

print

if posterior_c > posterior_s:
	if posterior_c > posterior_r:
		print "\nProbable Profession is Consultancy."
		with open('data.csv','a') as data:
	       	 	data.write('%s,%i,%i,%i\n' % ("Consultancy", sample_age, sample_qual, sample_exp))

	else:
		print "\nProbable Profession is Research."
		with open('data.csv','a') as data:
	       	 	data.write('%s,%i,%i,%i\n' % ("Research", sample_age, sample_qual, sample_exp))
else:
	if posterior_s > posterior_r:
		print "\nProbable Profession is Service."
		with open('data.csv','a') as data:
	       	 	data.write('%s,%i,%i,%i\n' % ("Service", sample_age, sample_qual, sample_exp))
	else:
		print "\nProbable Profession is Research."
		with open('data.csv','a') as data:
	       	 	data.write('%s,%i,%i,%i\n' % ("Research", sample_age, sample_qual, sample_exp))

data.close()

/*
	Output

	[ccoew@localhost 43]$ python naive.py 

	Enter sample attributes:

	Enter age: 45
	Enter qualification: 35
	Enter experience: 12


	Probable Profession is Consultancy.
	[ccoew@localhost 43]$ python naive.py 

	Enter sample attributes:

	Enter age: 30
	Enter qualification: 25
	Enter experience: 10


	Probable Profession is Research.
	[ccoew@localhost 43]$ python naive.py 

	Enter sample attributes:

	Enter age: 30
	Enter qualification: 20
	Enter experience: 8


	Probable Profession is Research.
	[ccoew@localhost 43]$ python naive.py 

	Enter sample attributes:

	Enter age: 25
	Enter qualification: 10
	Enter experience: 5


	Probable Profession is Service.
*/



