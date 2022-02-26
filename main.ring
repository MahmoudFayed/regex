# The Main File

load "lib.ring"

func main

	see "Regex" + nl + nl
	see "Example:" +nl + nl

	see 'load "regex.ring"' + nl + nl
	see 'ptrn = "ring"' + nl
	see 'str = "ring without gems is not a real ring"' + nl
	see 're = new Regex(ptrn)' + nl
	see 'see re.match(str)' + nl
	see 'Output:' + nl
	see 'ring'
