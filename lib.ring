/*
 * Copyright (c) 2022 XXIV
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
load "guilib.ring"

/*
Returns true if the pattern is valid
*/
func isvalidpattern(pattern)
		if !isstring(pattern)
			raise("Error: Pattern `"+ pattern +"` is not a string")
		end
		regex = new qregularexpression()
		regex.setPattern(pattern)
		if !regex.isValid()
			return False
		end
		return True

class Regex

	pattern = ""
	
	func init(pattern)
	  self.pattern = pattern

	func setpattern(pattern)
	  self.pattern = pattern

 
	/*
	Example:

	```ring
	load "regex.ring"
	
	ptrn = "ring"
	str = "ring without gems is not a real ring"
	re = new Regex(ptrn)
	see re.match(str)
	```
	Returns the first match
	*/
	func match(text)
		if !isstring(pattern)
			raise("Error: Pattern `"+ pattern +"` is not a string")
		end
		if !isstring(text)
			raise("Error: Text `"+ text +"` is not a string")
		end
		regex = new qregularexpression()
		regex.setPattern(pattern)
		if !regex.isValid()
			raise("Error: " + regex.errorstring())
		end
		match = regex.match(text,0,0,0)
		if !match.hasMatch()
			raise("Error: no match found")
		end
		matches = []
		for i = 0 to match.lastCapturedIndex()
			add(matches,match.captured(i))
		next
		return matches

	/*
	Example:

	```ring
	load "regex.ring"
	
	ptrn = "ring"
	str = "ring without gems is not a real ring"
	re = new Regex(ptrn)
	for match in re.matchall(str)
		see match
	next
	```
	Returns all the matches
	*/
	func matchall(text)
		if !isstring(pattern)
			raise("Error: Pattern `"+ pattern +"` is not a string")
		end
		if !isstring(text)
			raise("Error: Text `"+ text +"` is not a string")
		end
		regex = new qregularexpression()
		regex.setPattern(pattern)
		if !regex.isValid()
			raise("Error: " + regex.errorstring())
		end
		match = regex.globalMatch(text,0,0,0)
		if !match.hasnext()
			raise("Error: no matches found")
		end
		matches = []
		while match.hasnext()
			item = match.nextitem()
			group = []
			for i = 0 to item.lastCapturedIndex()
				add(group,item.captured(i))
			next
			add(matches,group)
		end
		return matches

	/*
	Returns true if there is a match
	*/
	func hasmatch(text)
		if !isstring(pattern)
			raise("Error: Pattern `"+ pattern +"` is not a string")
		end
		if !isstring(text)
			raise("Error: Text `"+ text +"` is not a string")
		end
		regex = new qregularexpression()
		regex.setPattern(pattern)
		if !regex.isValid()
			raise("Error: " + regex.errorstring())
		end
		match = regex.match(text,0,0,0)
		if !match.hasMatch()
			return False
		end
		return True
	/*
	Returns true if the pattern is valid
	*/
	func isvalidpattern()
		if !isstring(pattern)
			raise("Error: Pattern `"+ pattern +"` is not a string")
		end
		regex = new qregularexpression()
		regex.setPattern(pattern)
		if !regex.isValid()
			return False
		end
		return True

	/*
	Example:

	```ring
	load "regex.ring"
	
	ptrn = "ring"
	str = "ring without gems is not a real ring"
	re = new Regex(ptrn)
	see re.replace(str)
	```
	Returns new string with the replacement
	if there is no match it returns the same string
	*/
	func replace(text,replacement)
		if !isstring(pattern)
			raise("Error: Pattern `"+ pattern +"` is not a string")
		end
		if !isstring(text)
			raise("Error: Text `"+ text +"` is not a string")
		end
		if !isstring(replacement)
			raise("Error: Replacement `"+ replacement +"` is not a string")
		end
		regex = new qregularexpression()
		regex.setPattern(pattern)
		if !regex.isValid()
			raise("Error: " + regex.errorstring())
		end
		match = regex.match(text,0,0,0)
		if !match.hasMatch()
			return text
		end
		matches = match.captured(0)
		newString = substr(text,matches,replacement)
		return newString

	/*
	Example:

	```ring
	load "regex.ring"
	
	ptrn = "ring"
	str = "ring without gems is not a real ring"
	re = new Regex(ptrn)
	for match in re.replaceall(str)
		see match
	next
	```
	Returns new string with the replacement
	if there is no match it returns the same string
	*/
	func replaceall(text,replacement)
		if !isstring(pattern)
			raise("Error: Pattern `"+ pattern +"` is not a string")
		end
		if !isstring(text)
			raise("Error: Text `"+ text +"` is not a string")
		end
		if !isstring(replacement)
			raise("Error: Replacement `"+ replacement +"` is not a string")
		end
		regex = new qregularexpression()
		regex.setPattern(pattern)
		if !regex.isValid()
			raise("Error: " + regex.errorstring())
		end
		match = regex.globalMatch(text,0,0,0)
		if !match.hasnext()
			return text
		end
		matches = []
		while match.hasnext()
			item = match.nextitem()
			add(matches,item.captured(0))
		end
		newString = text
		for str in matches
			newString = substr(newString,str,replacement)
		next
		return newString
