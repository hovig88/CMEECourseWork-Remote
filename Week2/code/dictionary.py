taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 

#'Afrosoricida' : 'Microgale dobsoni', 'Microgale talazaci'
#'Carnivora' : 'Lyacon pictus' , 'Arctocephalus gazella', 'Canis lupus'
#'Chiroptera' : 'Myotis lucifugus'
#'Rodentia' : 'Gerbillus henleyi', 'Peromyscus crinitus', 'Mus domesticus', 'Cleithrionomys rutilus'

taxa_dic={}
x = 0
for row in taxa:
        if row[1] not in taxa_dic.keys():
                taxa_dic[row[1]] = []
                x = x +1

        for key in taxa_dic.keys():
                if key == row[1]:
                        taxa_dic[key].append(row[0])

print(taxa_dic)
# from pprint import pprint
# pprint(taxa_dic)