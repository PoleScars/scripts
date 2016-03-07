#!/usr/bin/env Rscript
#--------------------------------------
# Script for producing LaTeX Table from Input File
#
# Version:  1.2
# Date:     17th May 2015
# Author:   Nicholas Hamilton
# Email:    n.hamilton@unsw.edu.au
#--------------------------------------
if(!suppressMessages(require('pacman'))){install.packages('pacman',type='source');suppressMessages(library(pacman))}
p_load(c("optparse","xtable","Hmisc"),character.only=TRUE)

#Script Options
options('default.input' = 'table',
        'default.output'=  NULL,
        'default.delimiter'="",
        'default.scalebox' =1.0,
        'default.resizebox'='',
        'default.hline.after'="tub",
        'xtable.table.placement'='htbp',
        'width'=10000)

#Make the Options List
options_list <- list( 
  make_option(c("-i","--input"),
              type    = 'character',
              default = getOption('default.input'),
              dest    = 'input',
              help    = "Input Filename, [default '%default'] 
                NOTE I:   1st positional argument (if provided) is equivalent and takes precedence, 
                NOTE II:  For special characters in the column headers, use the following: 
                          BSL for backslash \\, 
                          OBR for open brace {, 
                          CBR for close brace }, 
                          SPC for space ' ',
                          DOL for Dollar Sign $,
                          HAT for hat ^,
                          USC for underscore _,
                          MIN for minus -,
                          PLS for plus"),
  make_option(c("-o", "--output"), 
              type    = "character", 
              default = getOption('default.output'),
              dest    = 'output',
              help    = "Output Filename, if Null or Empty, will use '<INPUT>.tex', 
                where <INPUT> is obtained by the --input argument (see above)
                [default '%default']"),
  make_option(c("-d", "--delimiter"), 
              type    = "character", 
              default = getOption('default.delimiter'),
              dest    = 'delimiter',
              help    = "Delimiter when reading data from file [default '%default']"),
  make_option(c("-C", "--Caption"), 
              type    = "character",
              default = NULL,
              dest    = 'captionLong',
              help    = "Long Caption [default '%default']"),
  make_option(c("-c", "--caption"), 
              type    = "character", 
              default = NULL,
              dest    = 'captionShort',
              help    = "Short Caption, will be used as long caption if long caption is not provided [default '%default']"),
  make_option(c("--captionbottom"), 
              type    = 'logical',
              action  = 'store_true', 
              default = FALSE,
              dest    = 'caption.placement.bottom',
              help    = "Put captions on the bottom, rather than the top [default '%default' (On Top)]"),
  make_option(c("-l", "--label"), 
              type    = "character", 
              default = NULL,
              dest    = 'label',
              help    = "The label tag used for cross-referencing, ignored if NULL [default '%default' (IGNORED)]"),
  make_option(c("-a", "--align"), 
              type    = "character", 
              default = NULL,
              dest    = 'align',
              help    = "Alignment, space seperated string, requires either 1 value (which will be repeated), or n+1 values,
                where n represents the number of columns in the table [default '%default']"),
  make_option(c("-p", "--placement"), 
              type    = "character", 
              default = getOption("xtable.table.placement", "ht"),
              dest    = 'placement',
              help    = "Table Placement, values other than 'h','t','b' or 'p' (or combinations) 
                will be removed [default '%default']"),
  make_option(c("-f", "--format"), 
              type    = "character", 
              default = NULL,
              dest    = 'display',
              help    = "Format the columns, these values are passed to the formatC function. 
                Use 'd' (for integers), 'f', 'e', 'E', 'g', 'G', 'fg' (for reals), or 
                's' (for strings). 'f' gives numbers in the usual xxx.xxx format; 'e' 
                and 'E' give n.ddde+nn or n.dddE+nn (scientific format); 'g' and 'G' 
                put x[i] into scientific format only if it saves space to do so. 
                [default '%default']"),
  make_option(c("-H", "--hline"), 
              type    = "character", 
              default = getOption('default.hline.after'),
              dest    = 'hline.after',
              help    = "Where to put horizontal lines, out of range (resolved) indexes, will 
                be discarded without error [default '%default']
                NOTE I:   Can resolve the following, in order of preference:
                          + 'a' or 'all' as all lines, including before header (above header row)
                          + 'u','under' or 'underline' as line under header row,
                          + 's','t','start' or 'top' as first line (above header row), 
                          + 'e','b','end' or 'bottom' as last line (below last row),
                          + -1 to n as the integer positions of the lines, 
                            where -1 is the line immediately above the header row, 
                            and n is the position immediately below the final row.
                NOTE II:  Can parse ranges, for example 'start:end' will put a line 
                          under every row and before the top header row, whilst '-1:1'
                          will put lines at the row indexes -1,0 and 1.
                NOTE III: Consider using --booktabs argument for additional emphasis"),
  make_option(c("--floatingenvironment"), 
              type    = "character", 
              default = "table",
              dest    = 'environFloating',
              help    = "Environment to use for the floating environment, say 'table' or 'table*' [default '%default']"),
  make_option(c("--tableenvironment"), 
              type    = "character", 
              default = "tabular",
              dest    = 'environTable',
              help    = "Environment to use for the actual table, say 'tabular' or 'tabularx' [default '%default']"),
  make_option(c("--latexenvironment"), 
              type    = "character", 
              default = NULL,
              dest    = 'environLatex',
              help    = "Environment to use in surrounding the table within the LaTex document, 
                center, raggedleft etc... [default '%default']"),
  make_option("--scalebox",
              type='double',
              default=getOption('default.scalebox'),
              dest = 'scalebox',
              help=sprintf("Use a scalebox environment, ignored if >= 1.0 or <= 0.0 [default '%.1f']",getOption('default.scalebox'))),
  make_option("--resizebox",
              type='character',
              default=getOption('default.resizebox'),
              dest = 'resizebox',
              help="Use a resizebox environment, expects two values as space delimited string to be passed through to the 
                resizebox LaTeX macro, ignored if two arguments are not present [default '%default']"),
  make_option(c("--sideways"),
              type    = 'logical',
              action  = 'store_true', 
              default = FALSE,
              dest    = 'sideways',
              help    = "Print Table as Sideways Table [default '%default' (Standard Table)]"),
  make_option(c("--norownumbers"),
              type    = 'logical',
              action  = 'store_false', 
              default = TRUE,
              dest    = 'rownumbers',
              help    = "Suppress the row numbers in the table [default '%default' (Include Row Numbers)]"),
  make_option(c("--booktabs"),
              type    = 'logical',
              action  = 'store_true', 
              default = FALSE,
              dest    = 'booktabs',
              help    = "Use Booktabs, to enhance the quality of the tables [default '%default' (Don't Use Booktabs)]"),
  make_option("--addtorownumber",
              type    ='character',
              default ="",
              dest    = 'addtorownumber',
              help    ="The numbers of addtorow [default '%default']"),
  make_option("--addtorowcommand",
              type    ='character',
              default ="",
              dest    = 'addtorowcommand',
              help    ="The commands of addtorow [default '%default']"),
 make_option(c("-v", "--verbose"),
              type    = 'logical',
              action  = 'store_true', 
              default = FALSE,
              dest    = 'verbose',
              help    = "Print extra output to console [default '%default']"),
  make_option(c("--print"),
              type    = 'logical',
              action  = 'store_true', 
              default = FALSE,
              dest    = 'print',
              help    = "Print table to console, in addition to writing output file [default '%default']")
)

#Parse the Arguments
parser <- OptionParser(usage = "%prog Options", option_list=options_list)

#Try to parse the arguments
tryCatch({
  args <- parse_args(parser,positional_arguments=TRUE)  
},warning=function(e){
  stop(sprintf("Problem parsing arguments, %s",as.character(e)),call.=getOption('default.mycall'))
})

#Load the Variables
input           = if(length(args$args) <= 0){args$options$input}else{args$args[1]}
output          = args$options$output
delimiter       = args$options$delimiter
verbose         = args$options$verbose
doPrint         = args$options$print
captionShort    = args$options$captionShort
captionLong     = args$options$captionLong
label           = args$options$label
align           = args$options$align
environFloating = args$options$environFloating
environTable    = args$options$environTable
environLatex    = args$options$environLatex
sideways        = args$options$sideways
display         = args$options$display
booktabs        = args$options$booktabs
hline.after     = args$options$hline.after
scalebox        = args$options$scalebox
resizebox       = args$options$resizebox
addtorownumber  = args$options$addtorownumber
addtorowcommand = args$options$addtorowcommand

#HELPER FUNCTIONS
#Function to split a string based on delimiter
split <- function(x,delim=delimiter){
  if(delim == ""){delim = "(\\s+)"}
  unlist(strsplit(x,split=delim))
}
#Function to check string if it is null or empty
nOrE  <- function(x){ if(is.null(x) ){ return(TRUE) }; return( x == "" ) }
#Function to trim duplicates
trimD <- function(x){ gsub("(.*?)\\1+","\\1",x,TRUE) }
#Function to trim all whitespace
trimW <- function(x){ gsub("\\s", "", x) }
#Function to trim leading whitespace
trimF <- function(x){ gsub("^\\s+", "", x) }
#Function to trim trailing whitespace
trimB <- function(x){ gsub("\\s+$", "", x)}
#Function to trim leading and trailing whitespace
trim  <- function(x){ gsub("^\\s+|\\s+$", "", x) }
#Function to parse the Alignment from user argument
pAln  <- function(x){ 
  x=gsub("([^\\|\\s ])(\\|)","\\1 \\2",x);
  x=gsub("([\\s ]+)([\\|]+$)","\\2",x);
  trim(x)
}
#Function to parse the column format from user argument
pFmt  <- function(x){ x=gsub("([deEGs]|fg)([^\\s ])","\\1 \\2",x);x=gsub("(f)([^g\\s ])","\\1 \\2",x);trim(x)}
#Function to parse the hrule positions from user argument
pHla  <- function(x,n,firstAttempt=TRUE){
  tryCatch({
    x = gsub("all|every","a",x,TRUE)            #Replace 'all' with 'a'
    x = gsub("under|underline","u",x,TRUE)      #Replace under or underline with 'u'
    x = gsub("head|heading|header","h",x,TRUE)  #Replace head,heading,header with 'h' (Same result as above)                                            
    x = gsub("start|top|beginning","s",x,TRUE)  #Replace Start, Top or Beginning with 's'
    x = gsub("finish|end|bottom","e",x,TRUE)    #Replace End, Finish or Bottom with 'e'
    x = gsub("[a]","s:e,",x,TRUE)               #Replace 'a' with 's:e'
    x = gsub("[uh]","0,",x,TRUE)                #Replace 'u' with 0
    x = gsub("[st]","-1,",x,TRUE)               #Replace 's' or 't' with -1
    x = gsub("[ebf]",paste0(n,","),x,TRUE)      #Replace 'e','f' or 'b' with n
    x = gsub("[a-z]+","",x,TRUE)                #Remove remaining alpha characters
    x = gsub("([,:]?)\\1+","\\1",x)             #Replace Concurrent Commas and Colon with single
    x = gsub("[:,]$|^[:,]","",x)                #Remove leading and trailing comma or colon
    x = gsub("(,:)|(:,)",":",x)                 #Replace comma colon with colon
    x = parse(text=trim(sprintf("c(%s)",x)))    #Parse the string to an expression
    x = sort(eval(x))                           #Evaluate the Expression, then form Sorted Unique List of Numbers
    return(x[which(x >= -1 & x <= n)])          #Return Acceptable Range
  },error=function(e){
    if(firstAttempt){ #PREVENT RECURSIVE CALLS IF DEFAULT CAUSES AN ERROR
      x = getOption('default.hline.after')
      if(verbose)writeLines(sprintf("Error parsing hline positions, falling back to default %s",x))
      return(pHla(x,n,FALSE))
    }else{
      stop(as.character(e)) 
    }
  })
}

#Function to parse the float position string
pPlc <- function(x){tolower(trimD(trimW(gsub("[^htbp]","",x,TRUE))))}

#Float Placement htbp
options("xtable.table.placement" = pPlc(args$options$placement))  
#Incorporate Rownames 1,2,3, ... n in table
options("xtable.include.rownames"= args$options$rownumbers) 
#Caption PLacement
options("xtable.caption.placement"=if(args$options$caption.placement.bottom){'bottom'}else{'top'})

#Run some checks
if(nOrE(input)) stop("Input file '<EMPTY>' is not valid, consider altering the --input argument",call.=F)
if(!file.exists(input)) stop(sprintf("Input file '%s' doesn't exists",input),call.=F)

#Check Output, Assign Default if Null or Empty
if(nOrE(output)) output = paste0(input,".tex")

#Check the Captions
captionLong = if(nOrE(captionLong)){captionShort}else{captionLong}
captionShort= if(nOrE(captionShort)){captionLong}else{captionShort}

#Load the File
df <- read.table(input,header=TRUE,sep=if(delimiter=="\t" | delimiter==" "){""}else{delimiter})
colnames(df) = as.character(trim(split(readLines(input)[1])))

#Parse the Hlines
hline.after = pHla(hline.after,nrow(df))

#Parse Alignment, put spaces if can be resolved
align = pAln(align)

#Convert Alignment to vector
if(!is.null(align)){ align = split(align); if(length(align) == 1){ align = rep(align,ncol(df) + 1)}}
if(length(align) > ncol(df) + 1){
  if(verbose){
    writeLines("WARNING: Truncating alignment directive as too many have been provided, consider altering the --align argument");
    Sys.sleep(5)
  } 
  align = align[0:ncol(df)+1]
}

#Convert Display Instructions to Vector
if(!nOrE(display)){
  display = split(pFmt(display))
  if(length(display) == 1){display = rep(display,ncol(df) + 1) }# If only one value is provided, repeat it
  if(length(display) == ncol(df)){ display = c('d',display) }   # Provide for Row Numbers
  if(!is.null(display) & length(display) != ncol(df) + 1){      # Throw an Error
    stop(sprintf("'In this case, --format' must have length equal to %i ( ncol(x) + 1 )",ncol(df)),call.=F) 
  }
}

#Process the Table
tryCatch({
  
  #Process the Captions
  caption = c(captionLong,captionShort)
  if(!is.null(captionLong) && !is.null(captionShort)){
    if(captionLong == captionShort){
      caption=c(captionLong)
    }
  }
  
  #Buld the xtable object.
  x = xtable(df,caption=caption,label=label,align=align,display=display)
  
  #Function to Sanitize Columns
  sanCol <- function(x,execute=FALSE){
    if(execute){
      x = gsub("BSL","\\",  x,fixed=TRUE)
      x = gsub("FSL","/",  x,fixed=TRUE)
      x = gsub("OBR","{",   x,fixed=TRUE)
      x = gsub("CBR","}",   x,fixed=TRUE)
      x = gsub("SPC"," ",   x,fixed=TRUE)
      x = gsub("DOL","$",   x,fixed=TRUE)
      x = gsub("HAT","^",   x,fixed=TRUE)
      x = gsub("USC","_",   x,fixed=TRUE)
      x = gsub("MIN","-",   x,fixed=TRUE)
      x = gsub("PLS","+",   x,fixed=TRUE)
    }
    x
  }
  
  #Functions to Add To Row 
  addtorow = NULL
  tryCatch({
    addtorownumber  = gsub("m","-",addtorownumber,fixed=TRUE)
    addtorownumber  = as.integer(split(addtorownumber))
    addtorowcommand = split(addtorowcommand)
    if(length(addtorownumber) == length(addtorownumber)){
      addtorow         = list()
      addtorow$pos     = as.list(addtorownumber)
      addtorow$command = addtorowcommand
    }else{
      addtorow = NULL
    }
  },error=function(e){
    writeLines("Problem Parsing addtorow logic")
    writeLines(as.character(e))
  })
  
  #Build the list of standard arguemnts
  tabArgs = list(x                          = x,
                 tabular.environment        = environTable,
                 floating                   = !(toupper(environFloating) %in% c('NULL','NA','NONE')),
		             add.to.row                 = addtorow,
                 floating.environment       = environFloating,
                 latex.environments         = environLatex,
                 include.rownames           = getOption("xtable.include.rownames"),
                 hline.after                = hline.after,
                 booktabs                   = booktabs,
                 sanitize.colnames.function = sanCol,
                 sanitize.rownames.function = identity,
                 sanitize.text.function     = identity)
  
  #Use Scalebox if valid
  if(scalebox < 1.0 & scalebox > 0.0){ tabArgs$scalebox = scalebox }
  
  #Use Sideways table if valid
  if(sideways){ tabArgs$floating.environment="sidewaystable" }
  
  #Get the Lines
  lines <- capture.output(do.call("print",tabArgs))
  
  #Strip leading whitespace
  lines <- trimF(lines)
  
  #Apply the Resizebox
  resizebox = split(resizebox)
  if(length(resizebox) == 2){
    resizebox = gsub("\\!","!",resizebox,fixed=TRUE)
    ix = grep(sprintf('\\\\(begin|end)\\{%s\\}',environTable,fixed=TRUE),lines)
    if(length(ix) == 2){
      lines <- c(lines[1:ix[2]],"}",lines[(ix[2]+1):length(lines)])
      lines <- c(lines[1:(ix[1]-1)],sprintf("\\resizebox{%s}{%s}{",resizebox[1],resizebox[2]),lines[ix[1]:length(lines)])
    }
  }
  
  #Write to file
  if(verbose) writeLines(sprintf("Attempting to Write Table to File %s",output))
  writeLines(lines,output)
  
  #Reporting
  if((verbose | doPrint) & file.exists(output)){writeLines("\n");writeLines(readLines(output));writeLines("\n")}
},error=function(e){
  writeLines(as.character(e))
})


