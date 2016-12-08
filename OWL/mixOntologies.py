import os,sys

f = open('charactersOntology.owl', 'r')

g = open('charactersOntologyComplete.owl','w+')

text = f.readlines()

c = open('otherCharacters.owl','r')

chars = c.read()

chars = chars[585:-11] # remove namespace declaration and rdf tag

text.insert(-6,"\n"+chars+"\n")

g.write("".join(text))

#g.seek(-112,2)

#g.write('<-- this is a comment? -->')

f.close()
g.close()