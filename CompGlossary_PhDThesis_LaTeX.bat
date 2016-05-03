REM #Generates the glossary file the LaTeX PhD thesis. 
REM #Must be added everytime a new glossary reference is created.

cd D:\Scott\Documents\PhD Project\Documents\LaTeX_Thesis\

makeindex -s "ScottGleason PhDThesis.ist" -o "ScottGleason PhDThesis.gls" "ScottGleason PhDThesis.glo"

REM "LaTeX glossary generation complete"

timeout 150