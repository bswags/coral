import subprocess, os, filecmp

numTests = 0
numCorrect = 0

def get_immediate_subdirectories(dir):
    return [name for name in os.listdir(dir)
            if os.path.isdir(os.path.join(dir, name))]
    
def compileTests(subdirs):
    for dir in subdirs:    
        for file in os.listdir(dir):
            if file.endswith('.cl'):
                #print files
                compileFile = dir +'/' + file                
                subprocess.call([pathToCoral, compileFile])
                
def runFiles(subdirs):
    for dir in subdirs:    
        for file in os.listdir(dir):
            if file.endswith('.clx'):
                with open(file+'.out', 'w') as outfile:
                    subprocess.call(["python", compileFile], stdout=outfile, stderr=outfile)
                    
def compare():
    for dir in subdirs:    
        for file in os.listdir(dir):
            if file.endswith('.out'):
                numTests++                            
                fileName = file.rsplit['.'][0]
                if(True === filecmp.cmp(file, fileName+'.exp'))
                    numCorrect++
                                


current_directory = os.getcwd()
subdirs = get_immediate_subdirectories(current_directory)

fileList = []
pathToCoral = '../src/build/coralc'
compileTests(subdirs)
runFiles(subdirs)
compare(subdirs)

print numCorrect + ' ' + numTests                    
            








