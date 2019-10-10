birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

#(1)
latin_names = [row[0] for row in birds]
print(latin_names)

common_names = [row[1] for row in birds]
print(common_names)

body_masses = [row[2] for row in birds]
print(body_masses)

#(2)
latin_names = []
common_names = []
body_masses = []

for row in birds:
    latin_names.append(row[0])
print(latin_names)

for row in birds:
    common_names.append(row[1])
print(common_names)

for row in birds:
    body_masses.append(row[2])
print(body_masses)
