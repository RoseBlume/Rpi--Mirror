import os
while True:
    try:
        project = str(input("What is the name of your plugin folder? "))
        break
    except:
        print("Input must be a string")

def resource(a):
    f = open("resources.qrc", "r")
    #f2 = open("resources.txt", "w")
    lines = f.readlines()
    f.close
    ef1 = lines[-1]
    ef2 = lines[-2]
    #print(ef1)
    #print(ef2)
    lines[-2] = "\t\t<file>Plugins/"+ a +"</file>\n"
    lines[-1] = ef2
    lines.append(ef1)
    #print(lines)
    f = open("resources.qrc", "w")
    f.writelines(lines)
    f.close()
        #f.seek(7)
        #f.write("\n\t\t<file>plugins/Hello<file>\n")
        #f.close

        #for x in f:
        #    print(x)
def plugin(a):
    f = open("qml/plugs/Plugins.qml", "r")
    #f2 = open("resources.txt", "w")
    lines = f.readlines()
    f.close
    ef1 = lines[-1]
    #print(ef1)
    lines[-1] = "\tListElement { name: \"" + a + "\" }\n"
    lines.append(ef1)
    #print(lines)
    f = open("qml/plugs/Plugins.qml", "w")
    f.writelines(lines)
    f.close()
resource(project)
plugin(project)

def comp():
    os.system("cmake -B build")
    os.system("make --directory=build")
    os.system("./build/Mirror")

compy = str(input("Would you like to compile and run the project (Y/n): "))
if (((compy == "y") or (compy == "")) or (compy == "Y")):
    comp()
